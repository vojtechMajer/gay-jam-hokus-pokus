using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using Godot;

public partial class Projectile : RigidBody2D
{
    public StatusEffect effect {get; set;} = StatusEffect.NONE;
    public int Damage { get; set; } = 0;

    public float LifeTime { get; set; } = 0;

    public Sprite2D SpellTexture { get; set; } = new Sprite2D();
    public CollisionShape2D Collision { get; set; } = new CollisionShape2D();

    Stopwatch timer;


    public override void _PhysicsProcess(double delta)
    {
        base._PhysicsProcess(delta);
    }

    public void Init(Vector2 direction, float speed, float lifeTime, StatusEffect effect = StatusEffect.NONE)
    {
        LinearVelocity = direction * speed;
        this.effect = effect;
        timer = Stopwatch.StartNew();
        LifeTime = lifeTime;
        ContactMonitor = true;
        MaxContactsReported = 100;
        AddChild(SpellTexture);
        SpellTexture.Scale = new Vector2(0.2f, 0.2f);
        CircleShape2D circleShape = new CircleShape2D();
        circleShape.Radius = 10;
        Collision.Shape = circleShape; 
        AddChild(Collision);
        GravityScale = 0;
    }

    public override void _Process(double delta)
    {
        var bodies = GetCollidingBodies();
        foreach (var body in bodies)
        {
            if(body is Enemy enemy)
            {
                enemy.TakeDamage(Damage);
                QueueFree();
                GD.Print("destroed by collision");
            }
            GD.Print("collided with: " + body.Name);
        }

        if(timer.Elapsed.TotalSeconds > LifeTime)
        {
            QueueFree();
            GD.Print("destroed by timeout");
        }
    }
}