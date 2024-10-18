using System;
using Godot;

public interface ISpell{
    void CastSpell(Node2D parent);
    string getSpellName();
}