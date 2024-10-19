using System;
using Godot;
using System.Collections.Generic;
using System.Diagnostics;

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

	Dictionary<SpellKeyPair, SpellBase> _SpellKeys = new Dictionary<SpellKeyPair, SpellBase>();

	public bool IsCasting { get; set; } = false;
	SpellBase currentSpell;
	Stopwatch _CastTimer = new Stopwatch();

	public override void _Ready()
	{
		_SpellKeys.Add(new (Key.E, Key.E), new FireSpell());
		_SpellKeys.Add(new (Key.E, Key.R), new FireWind());
	}

	public override void _Process(double delta)
	{
		//GD.Print(_CastTimer.Elapsed.TotalSeconds);
		if(currentSpell != null && _CastTimer.Elapsed.TotalSeconds > currentSpell.GetCastTime())
		{
			_CastTimer.Stop();
			_CastTimer.Reset();
			currentSpell.Destroy();
			currentSpell = null;
		}
	}

	public override void _Input(InputEvent @event)
	{
		if(_CastTimer.IsRunning)
			return;

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
		if(_SpellKeys.TryGetValue(_KeySpellInput, out SpellBase spell)){
			spell.CastSpell((Node2D)this.GetParent());
			_CastTimer.Start();
			currentSpell = spell;
			GD.Print("spell casted: " + spell.getSpellName());
		}else
		{
			GD.Print("Invalid spell keys");
		}
	}
}
