using Godot;
using Godot.Collections;
using System;

[Tool]
public partial class FoxyTest : Node2D
{
	[Export]
	int Width { get; set; } = 30;

	[Export]
	int Length { get; set; } = 30;

	[Export]
	int LayerCount { get; set; } = 3;

	[Export]
	TileSet TileSet { get; set; }

	[Export]
	Array<Vector2I> LayersAtlasPos { get; set; }

	[Export]
	Sprite2D Placeholder { get; set; }

	TileMapLayer[] _layers;

	public override void _Ready()
	{
		_layers = new TileMapLayer[LayerCount];
		SetupLayers();
	}

	public override void _Process(double delta)
	{
		base._Process(delta);
	}

	public override void _Input(InputEvent @event)
	{
		base._Input(@event);

		if (@event is InputEventMouseMotion mouseMotion && !mouseMotion.IsPressed())
		{
			UpdatePlaceholder(mouseMotion.Position);
		}
	}

	public void SetupLayers()
	{
		for (int layer = 0; layer < _layers.Length; layer++)
		{
			_layers[layer] = new TileMapLayer();
			_layers[layer].TileSet = TileSet;
			_layers[layer].Name = "layer_" + layer.ToString();
			_layers[layer].CollisionVisibilityMode = TileMapLayer.DebugVisibilityMode.ForceShow;
			_layers[layer].Position = new Vector2(0, layer * TileSet.TileSize.Y);
			_layers[layer].ZIndex = -layer;
			AddChild(_layers[layer]);
			for (int x = 0; x < Width; x++)
			{
				for (int y = 0; y < Length; y++)
				{
					_layers[layer].SetCell(new(x, -y), 0, LayersAtlasPos[layer]);
				}
			}
		}
	}

	public void UpdatePlaceholder(Vector2 mousePos)
	{
		Vector2I tilePos = _layers[0].LocalToMap(GetGlobalMousePosition() + new Vector2(0, 16));
		Vector2 pos = _layers[0].MapToLocal(tilePos);
		GD.Print(tilePos + " " + pos);
		Placeholder.Position = new(ToGlobal(pos).X, ToGlobal(pos).Y);
	}
}
