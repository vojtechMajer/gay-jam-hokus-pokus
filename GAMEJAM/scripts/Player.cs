using Godot;
using System;

public partial class Player : CharacterBody2D
{
	[Export]
	public Sprite2D Playertexture;

	public Vector2 Pos { get; set; }
	public int HP { get; set; }


	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}
}
