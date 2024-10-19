using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;

public partial class Player : CharacterBody2D
{
	[Export]
	public CastingManager CastingManager { get; set; }
	[Export]
	public float MaxSpeed { get; set; } = 400;
	[Export]
	public float MaxAcc { get; set; } = 2000;
	[Export]
	public float MaxDcc { get; set; } = 3000;
	private AnimationPlayer _animationPlayer;
	private Sprite2D _sprite;

	
	public Vector2 Pos { get; set; }
	Vector2 acceleration = Vector2.Zero;

	//string []MyInputs = {"Move_L", "Move_R", "Move_U", "Move_D"};
	Dictionary<String, Vector2> _Inputs = new Dictionary<String, Vector2>();

	public override void _Input(InputEvent @event)
	{
		
	}

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_Inputs.Add("Move_L", new Vector2(-1, 0));
		_Inputs.Add("Move_R", new Vector2(1, 0));
		_Inputs.Add("Move_U", new Vector2(0, -1));
		_Inputs.Add("Move_D", new Vector2(0, 1));
		_animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
		 _sprite = GetNode<Sprite2D>("Sprite2D");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}

	public override void _PhysicsProcess(double delta)
	{
		acceleration = Vector2.Zero;
		/*
		foreach (var input in _Inputs.Keys)
		{
			if (Input.Is(input))
			{
				_Inputs.TryGetValue(input, out Vector2 dir);
				acceleration = dir * MaxAcc;
			}
		}*/

		//GD.Print(acceleration);
		
		double vel_x = Velocity.X, vel_y = Velocity.Y;

		bool x_right = Input.IsActionPressed("Move_R");
		bool x_left = Input.IsActionPressed("Move_L");
		bool y_up = Input.IsActionPressed("Move_U");
		bool y_down = Input.IsActionPressed("Move_D");

		acceleration = new Vector2(MaxAcc * (x_right ^ x_left?(x_right?1:-1):0), MaxAcc * (y_up ^ y_down?(y_up?-1:1):0));

		if(x_right)
			_sprite.FlipH =false;
		if(x_left)
			_sprite.FlipH =true;
		if(x_right ^ x_left)
		{
			if(vel_x <= MaxSpeed && vel_x >= -MaxSpeed)
				vel_x += acceleration.X * delta;
			else
				vel_x = MaxSpeed * (x_right?1:-1);
		}else
		{
			if(vel_x != 0)
				vel_x -= MaxDcc * delta * (Velocity.X > 0 ? 1 : -1);
			if(vel_x < 100 && vel_x > -100)
				vel_x = 0;
		}
			
		if(y_up ^ y_down)
		{
			if(vel_y <= MaxSpeed && vel_y >= -MaxSpeed)
				vel_y += acceleration.Y * delta;
			else
				vel_y = MaxSpeed * (y_up?-1:1);
		}else
		{
			if(vel_y != 0)
				vel_y -= MaxDcc * delta * (Velocity.Y > 0 ? 1 : -1);
			if(vel_y < 100 && vel_y > -100)
				vel_y = 0;
		}
		Velocity = new Vector2((float)vel_x, (float)vel_y);
		if(vel_y+vel_x!=0)
		{
			
			if(!_animationPlayer.IsPlaying())
			{
				_animationPlayer.Play("walk");
			}
			 
		}else
		{
			if(!(_animationPlayer.CurrentAnimation=="cast"))
			{
				_animationPlayer.Stop();
			}
		}
		MoveAndSlide();
		for (int i = 0; i < GetSlideCollisionCount(); i++)
		{
			var collision = GetSlideCollision(i);
			GD.Print("I collided with ", ((Node)collision.GetCollider()).Name);
		}
	}
}
