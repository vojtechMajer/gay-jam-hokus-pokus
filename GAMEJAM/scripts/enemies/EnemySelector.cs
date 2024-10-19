using System;
using Godot;

public enum EnemyType
{
	GOLEM,
	SPIRIT,
	DEMON
}


public partial class EnemySelector : Node2D
{
	[Export]
	public EnemyType EnemyType { get; set; }
	public Enemy Enemy { get; set; }

	public override void _Ready()
	{
		
		switch (EnemyType)
		{
			case EnemyType.GOLEM:
				Enemy = new Golem();
				break;
			case EnemyType.SPIRIT:
				Enemy = new Spirit();
				break;
			case EnemyType.DEMON:
				Enemy = new Demon();
				break;
		}
		Enemy.Name = "single";
		AddChild(Enemy);
	}
}
