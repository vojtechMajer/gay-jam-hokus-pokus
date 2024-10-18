using System;
using Godot;

public partial class SpellBase : Node2D
{
    public Node2D spellScene;
    public virtual void CastSpell(Node2D parent){}
    public virtual string getSpellName(){return "";}
    public virtual float GetCastTime(){return 0;}

    public void Destroy()
    {
        spellScene.QueueFree();
        GD.Print("Destroying spell");
    }
}