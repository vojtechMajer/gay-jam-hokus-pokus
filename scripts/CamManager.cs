using Godot;
using Godot.Collections;
using System;

[Tool]
public partial class CamManager : Node2D
{
	private bool _camMoving = false;
	private Vector2 _mouseBasePos = Vector2I.Zero;
	private Vector2 _basePos = Vector2I.Zero;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
       
    }


    public override void _Input(InputEvent @event)
    {
        base._Input(@event);

        if (@event is InputEventMouseButton eventKey )
		{
			switch (eventKey.ButtonIndex)
			{
				case MouseButton.Middle:
					if(eventKey.Pressed)
					{
						_camMoving = true;
						_mouseBasePos = eventKey.Position;
						_basePos = Position;
					}
					else
					{
						_camMoving = false;
					}
					break;
            }
		}

		if(@event is InputEventMouseMotion mouseMotion )
		{
			if(_camMoving)
			{
				Position = _basePos + (_mouseBasePos - mouseMotion.Position);
			}
		}
    }
}
