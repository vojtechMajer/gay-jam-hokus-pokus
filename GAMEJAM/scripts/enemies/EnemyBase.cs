using System;
using Godot;

public enum StatusEffect{
    SLOWED,
    BURNING,
    POISONED,
    NONE
}

public abstract partial class Enemy : RigidBody2D
{
    [Export]
    public int Base_HP { get; set; } = 100;
    [Export]
    public float Base_Speed { get; set; } = 1000;
    [Export]
    public float Base_Damage { get; set; } = 10;

    public Sprite2D EnemyTexture { get; set; } = new Sprite2D();
    public CollisionShape2D CollisionShape { get; set; } = new CollisionShape2D();

    protected int Mod_HP;
    protected float Mod_Speed;
    protected float Mod_Damage;

    protected StatusEffect _StatusEffect = StatusEffect.NONE;

    public override void _Ready()
    {
        Mod_HP = Base_HP;
        Mod_Speed = Base_Speed;
        Mod_Damage = Base_Damage;
        ContactMonitor = true;
        MaxContactsReported = 100;
        GravityScale = 0;

        EnemyTexture.Texture = (Texture2D)GD.Load("res://icon.svg");
        CollisionShape.Shape = new CircleShape2D() {
            Radius = 64,
        };
        
        AddChild(EnemyTexture);
        AddChild(CollisionShape);
    }

    public abstract void TakeDamage(int dmg);

    protected void ApplyDamage(int dmg){
        Base_HP -= dmg;
        if(Base_HP <= 0)
        {
            Die();
        }
    }

    public void ApplyStatusEffect(StatusEffect effect)
    {
        _StatusEffect = effect; 
    }

    public void Die(){
        QueueFree();
    }
}