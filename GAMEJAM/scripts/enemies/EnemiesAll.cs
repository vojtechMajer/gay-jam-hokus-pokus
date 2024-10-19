using System;
using Godot;

public partial class Golem : Enemy
{
	public Golem()
	{
		Base_HP = 200;    
		Base_Speed = 500;
		Base_Damage = 10;
	}

	public override void TakeDamage(int dmg)
	{
		if(_StatusEffect == StatusEffect.POISONED)
		{
			ApplyDamage(dmg * 2);
		}else
		{
			ApplyDamage(dmg);
		}
	}

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);
	}
}

public partial class Spirit : Enemy
{
	public Spirit()
	{
		Base_HP = 100;    
		Base_Speed = 1000;
		Base_Damage = 20;
	}

	public override void TakeDamage(int dmg)
	{
		if(_StatusEffect == StatusEffect.BURNING)
		{
			ApplyDamage(dmg * 2);
		}else
		{
			ApplyDamage(dmg);
		}
	}
}

public partial class Demon : Enemy
{
	public Demon()
	{
		Base_HP = 1000;    
		Base_Speed = 200;
		Base_Damage = 30;
	}

	public override void TakeDamage(int dmg)
	{
		if(_StatusEffect == StatusEffect.BURNING)
		{
			ApplyDamage(dmg * 2);
		}else
		{
			ApplyDamage(dmg);
		}
	}
}
