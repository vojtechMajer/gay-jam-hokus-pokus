using System;
using Godot;
using System.Collections.Generic;

public partial class CastingManager : Node2D
{
    struct SpellKeyPair{
        public Key first;
        public Key second;

        public SpellKeyPair(Key first, Key second)
        {
            this.first = first;
            this.second = second;
        }
    }

    SpellKeyPair _KeySpellInput = new SpellKeyPair(Key.None, Key.None);

    Dictionary<SpellKeyPair, ISpell> _SpellKeys = new Dictionary<SpellKeyPair, ISpell>();

    public override void _Ready()
    {
        _SpellKeys.Add(new (Key.E, Key.E), new FireSpell());
    }

    public override void _Input(InputEvent @event)
    {
        if(@event is InputEventKey key && key.IsPressed())
        {
            if(key.Keycode == Key.R || key.Keycode == Key.E || key.Keycode == Key.T || key.Keycode == Key.F)
            {
                if(_KeySpellInput.first == Key.None)
                {
                    _KeySpellInput.first = key.Keycode;
                }else{
                    _KeySpellInput.second = key.Keycode;
                    TryCastSpell();
                    _KeySpellInput.first = Key.None;
                }
            }
        }
    }

    private void TryCastSpell(){
        if(_SpellKeys.TryGetValue(_KeySpellInput, out ISpell spell)){
            spell.CastSpell((Node2D)GetParent());
            GD.Print("spell casted: " + spell.getSpellName());
        }else
        {
            GD.Print("Invalid spell keys");
        }
    }
}