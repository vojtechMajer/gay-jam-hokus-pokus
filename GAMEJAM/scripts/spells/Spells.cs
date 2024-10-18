using System;
using Godot;

public partial class FireWind : SpellBase
{
    public override void CastSpell(Node2D parent)
    {
        spellScene = (Node2D)GD.Load<PackedScene>("res://GAMEJAM/particles/fire_wind.tscn").Instantiate();
        parent.AddChild(spellScene);
    }

    public override float GetCastTime()
    {
        return 4;
    }

    public override string getSpellName()
    {
        return "blubblub";
    }

    public override void _Process(double delta)
    {
        Rotation = Helper.FromNodeToMouse(this).Angle();
        GD.Print(Helper.FromNodeToMouse(this).Angle());
    }
}

public partial class FireSpell : SpellBase
{
    int count = 0;
    public override void CastSpell(Node2D parent)
    {
        Projectile projectile = new Projectile(){
            Name = count++.ToString(),
            Position = parent.Position,
            Damage = 50,
        };
        parent.GetParent().AddChild(projectile);
        projectile.AddCollisionExceptionWith(parent);
        projectile.Init(Helper.FromNodeToMouse(parent) * 100, 10, 20);
        projectile.SpellTexture.Texture = (Texture2D)GD.Load("res://icon.svg");
        
    }

    public override float GetCastTime()
    {
        return 0.2f;
    }

    public override string getSpellName()
    {
        return "BOMBA";
    }
}

public partial class Helper : Node2D
{
    public static Vector2 FromNodeToMouse(Node2D node)
    {   
        return (node.GetGlobalMousePosition() - node.GlobalPosition).Normalized();
    }
}