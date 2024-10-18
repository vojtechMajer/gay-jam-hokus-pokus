using System;
using Godot;

public partial class WaterSpell : Node2D, ISpell
{
    public void CastSpell(Node2D parent)
    {
        throw new NotImplementedException();
    }

    public string getSpellName()
    {
        return "blubblub";
    }
}

public partial class FireSpell : Node2D, ISpell
{
    int count = 0;
    public void CastSpell(Node2D parent)
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

    public string getSpellName()
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