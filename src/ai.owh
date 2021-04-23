rule("aiSub_EnableAI")
{
	event
	{
		Subroutine;
		aiSub_EnableAI;
	}

	actions
	{
		Call Subroutine(allSub_WaitForFrame);
		Clear Status(Players In Slot(Slot Of(Event Player), Team 2), Unkillable);
		Players In Slot(Slot Of(Event Player), Team 2).bot_MoveWASDEnabled = True;
		Players In Slot(Slot Of(Event Player), Team 2).bot_MoveCrouchEnabled = True;
		Players In Slot(Slot Of(Event Player), Team 2).bot_MoveJumpEnabled = True;
		Players In Slot(Slot Of(Event Player), Team 2).ai_AIEnabled = True;
	}
}

rule("aiSub_ReactionDelay")
{
	event
	{
		Subroutine;
		aiSub_ReactionDelay;
	}

	actions
	{
		Wait(Random Real(Players In Slot(Slot Of(Event Player), Team 2).ai_ReactionTime / 4, Players In Slot(Slot Of(Event Player), Team 2)
			.ai_ReactionTime), Ignore Condition);
	}
}

rule("aiSub_ButtonsReset")
{
	event
	{
		Subroutine;
		aiSub_ButtonsReset;
	}

	actions
	{
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Primary Fire));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Secondary Fire));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Ability 1));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Ability 2));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Ultimate));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Jump));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Crouch));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Melee));
		Stop Holding Button(Players In Slot(Slot Of(Event Player), Team 2), Button(Reload));
		Wait(1 / 60, Ignore Condition);
	}
}

rule("aiSub_FacingStart")
{
	event
	{
		Subroutine;
		aiSub_FacingStart;
	}

	actions
	{
		Abort If(Event Player != Players In Slot(Slot Of(Event Player), Team 2));
		Abort If(Event Player.ai_CanAim == False);
		Call Subroutine(allSub_WaitForFrame);
		Stop Facing(Event Player);
		"0 == hitscan/beam, 1 == projectile, 2 == arcing projectile"
		If(Event Player.ai_AimType == 0);
			If(Event Player.ai_AimBase == 0);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					Eye Position(Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)) + Event Player.ai_AimModX,
					Vertical Angle From Direction(Direction Towards(Eye Position(Event Player), Eye Position(Players In Slot(Slot Of(Event Player),
					Team 1)) - Vector(0, 0.250, 0))) + Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 1);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					Eye Position(Players In Slot(Slot Of(Event Player), Team 1))) + Event Player.ai_AimModX, Vertical Angle From Direction(
					Direction Towards(Eye Position(Event Player), Eye Position(Players In Slot(Slot Of(Event Player), Team 1))))
					+ Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 2);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					Position Of(Players In Slot(Slot Of(Event Player), Team 1))) + Event Player.ai_AimModX, Vertical Angle From Direction(
					Direction Towards(Eye Position(Event Player), Position Of(Players In Slot(Slot Of(Event Player), Team 1))))
					+ Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 3);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					Position Of(Players In Slot(Slot Of(Event Player), Team 1)) + Event Player.ai_FacingRelPosMod) + Event Player.ai_AimModX,
					Vertical Angle From Direction(Direction Towards(Eye Position(Event Player), Position Of(Players In Slot(Slot Of(Event Player),
					Team 1)) + Event Player.ai_FacingRelPosMod)) + Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player,
					Direction and Turn Rate);
			End;
		Else If(Event Player.ai_AimType == 1);
			If(Event Player.ai_AimBase == 0);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)) / Event Player.ai_ProjectileSpeed) + Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)) + Event Player.ai_AimModX,
					Vertical Angle From Direction(Direction Towards(Eye Position(Event Player), World Vector Of(Speed Of(Players In Slot(Slot Of(
					Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player), Team 1)), Players In Slot(Slot Of(Event Player),
					Team 1), Rotation) * (Distance Between(Event Player, Eye Position(Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0,
					0.250, 0)) / Event Player.ai_ProjectileSpeed) + Eye Position(Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250,
					0))) + Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 1);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Eye Position(Players In Slot(Slot Of(
					Event Player), Team 1))) + Event Player.ai_AimModX, Vertical Angle From Direction(Direction Towards(Eye Position(Event Player),
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Eye Position(Players In Slot(Slot Of(
					Event Player), Team 1)))) + Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 2);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Position Of(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Position Of(Players In Slot(Slot Of(
					Event Player), Team 1))) + Event Player.ai_AimModX, Vertical Angle From Direction(Direction Towards(Eye Position(Event Player),
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Position Of(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Position Of(Players In Slot(Slot Of(
					Event Player), Team 1)))) + Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 3);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Position Of(
					Players In Slot(Slot Of(Event Player), Team 1)) + Event Player.ai_FacingRelPosMod) / Event Player.ai_ProjectileSpeed)
					+ Position Of(Players In Slot(Slot Of(Event Player), Team 1)) + Event Player.ai_FacingRelPosMod) + Event Player.ai_AimModX,
					Vertical Angle From Direction(Direction Towards(Eye Position(Event Player), World Vector Of(Speed Of(Players In Slot(Slot Of(
					Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player), Team 1)), Players In Slot(Slot Of(Event Player),
					Team 1), Rotation) * (Distance Between(Event Player, Position Of(Players In Slot(Slot Of(Event Player), Team 1))
					+ Event Player.ai_FacingRelPosMod) / Event Player.ai_ProjectileSpeed) + Position Of(Players In Slot(Slot Of(Event Player),
					Team 1)) + Event Player.ai_FacingRelPosMod)) + Event Player.ai_AimModY), Event Player.ai_AimTurnRate, To Player,
					Direction and Turn Rate);
			End;
		Else If(Event Player.ai_AimType == 2);
			If(Event Player.ai_AimBase == 0);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)) / Event Player.ai_ProjectileSpeed) + Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)) + Event Player.ai_AimModX,
					Vertical Angle From Direction(Direction Towards(Eye Position(Event Player), World Vector Of(Speed Of(Players In Slot(Slot Of(
					Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player), Team 1)), Players In Slot(Slot Of(Event Player),
					Team 1), Rotation) * (Distance Between(Event Player, Eye Position(Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0,
					0.250, 0)) / Event Player.ai_ProjectileSpeed) + Eye Position(Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250,
					0))) + Event Player.ai_AimModY + Arcsine In Degrees(-9.800 * (Distance Between(Eye Position(Event Player), Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)) - Event Player.ai_AimDistanceMod)
					/ Event Player.ai_ProjectileSpeed ^ 2) / 2), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 1);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Eye Position(Players In Slot(Slot Of(
					Event Player), Team 1))) + Event Player.ai_AimModX, Vertical Angle From Direction(Direction Towards(Eye Position(Event Player),
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Eye Position(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Eye Position(Players In Slot(Slot Of(
					Event Player), Team 1)))) + Event Player.ai_AimModY + Arcsine In Degrees(-9.800 * (Distance Between(Eye Position(Event Player),
					Eye Position(Players In Slot(Slot Of(Event Player), Team 1))) - Event Player.ai_AimDistanceMod)
					/ Event Player.ai_ProjectileSpeed ^ 2) / 2), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 2);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Position Of(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Position Of(Players In Slot(Slot Of(
					Event Player), Team 1))) + Event Player.ai_AimModX, Vertical Angle From Direction(Direction Towards(Eye Position(Event Player),
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Position Of(
					Players In Slot(Slot Of(Event Player), Team 1))) / Event Player.ai_ProjectileSpeed) + Position Of(Players In Slot(Slot Of(
					Event Player), Team 1)))) + Event Player.ai_AimModY + Arcsine In Degrees(-9.800 * (Distance Between(Eye Position(Event Player),
					Position Of(Players In Slot(Slot Of(Event Player), Team 1))) - Event Player.ai_AimDistanceMod)
					/ Event Player.ai_ProjectileSpeed ^ 2) / 2), Event Player.ai_AimTurnRate, To Player, Direction and Turn Rate);
			Else If(Event Player.ai_AimBase == 3);
				Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Angle Towards(Event Player,
					World Vector Of(Speed Of(Players In Slot(Slot Of(Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player),
					Team 1)), Players In Slot(Slot Of(Event Player), Team 1), Rotation) * (Distance Between(Event Player, Position Of(
					Players In Slot(Slot Of(Event Player), Team 1)) + Event Player.ai_FacingRelPosMod) / Event Player.ai_ProjectileSpeed)
					+ Position Of(Players In Slot(Slot Of(Event Player), Team 1)) + Event Player.ai_FacingRelPosMod) + Event Player.ai_AimModX,
					Vertical Angle From Direction(Direction Towards(Eye Position(Event Player), World Vector Of(Speed Of(Players In Slot(Slot Of(
					Event Player), Team 1)) * Throttle Of(Players In Slot(Slot Of(Event Player), Team 1)), Players In Slot(Slot Of(Event Player),
					Team 1), Rotation) * (Distance Between(Event Player, Position Of(Players In Slot(Slot Of(Event Player), Team 1))
					+ Event Player.ai_FacingRelPosMod) / Event Player.ai_ProjectileSpeed) + Position Of(Players In Slot(Slot Of(Event Player),
					Team 1)) + Event Player.ai_FacingRelPosMod)) + Event Player.ai_AimModY + Arcsine In Degrees(-9.800 * (Distance Between(
					Eye Position(Event Player), Position Of(Players In Slot(Slot Of(Event Player), Team 1)) + Event Player.ai_FacingRelPosMod)
					- Event Player.ai_AimDistanceMod) / Event Player.ai_ProjectileSpeed ^ 2) / 2), Event Player.ai_AimTurnRate, To Player,
					Direction and Turn Rate);
			End;
		End;
	}
}

rule("aiSub_FacingLookAt")
{
	event
	{
		Subroutine;
		aiSub_FacingLookAt;
	}

	actions
	{
		Players In Slot(Slot Of(Event Player), Team 2).ai_CanAim = False;
		Wait(2 / 60, Ignore Condition);
		Players In Slot(Slot Of(Event Player), Team 2).ai_AimTurnRate = Random Real(Players In Slot(Slot Of(Event Player), Team 2)
			.ai_FacingCapMin, Players In Slot(Slot Of(Event Player), Team 2).ai_FacingCapMin * 1.500);
		Stop Facing(Players In Slot(Slot Of(Event Player), Team 2));
		Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction Towards(Eye Position(Players In Slot(Slot Of(Event Player),
			Team 2)), Players In Slot(Slot Of(Event Player), Team 2).ai_LookAtVector), Evaluate Once(Random Real(Players In Slot(Slot Of(
			Event Player), Team 2).ai_FacingCapMin, Players In Slot(Slot Of(Event Player), Team 2).ai_FacingCapMax)), To World,
			Direction and Turn Rate);
		Wait Until(Is In View Angle(Players In Slot(Slot Of(Event Player), Team 2), Players In Slot(Slot Of(Event Player), Team 2)
			.ai_LookAtVector - Vector(0, Y Component Of(Eye Position(Players In Slot(Slot Of(Event Player), Team 2))), 0), 12.500), 2);
		Stop Facing(Players In Slot(Slot Of(Event Player), Team 2));
	}
}

rule("aiSub_FacingReset")
{
	event
	{
		Subroutine;
		aiSub_FacingReset;
	}

	actions
	{
		Event Player.ai_AimType = Event Player.ai_AimTypeDefault;
		Event Player.ai_AimBase = Event Player.ai_AimBaseDefault;
		Call Subroutine(aiSub_FacingStart);
	}
}

rule("AI Aim Mod Calculation")
{
	event
	{
		Subroutine;
		aiSub_AimModSet;
	}

	actions
	{
		Stop Chasing Player Variable(Event Player, ai_AimModX);
		Stop Chasing Player Variable(Event Player, ai_AimModY);
		If(Array Contains(Global.scopeHeroes, Hero Of(Event Player)) && Is Firing Secondary(Event Player));
			If(Horizontal Angle Towards(Event Player, Players In Slot(Slot Of(Event Player), Team 1)) > 0);
				Chase Player Variable Over Time(Event Player, ai_AimModX, Random Real(0, (Global.difficultyMax - Players In Slot(Slot Of(
					Event Player), Team 1).p_Difficulty) * 0.450), Random Real(0.100, 0.500), None);
			Else;
				Chase Player Variable Over Time(Event Player, ai_AimModX, Random Real(-0.450 * (Global.difficultyMax - Players In Slot(Slot Of(
					Event Player), Team 1).p_Difficulty), 0), Random Real(0.100, 0.500), None);
			End;
			Chase Player Variable Over Time(Event Player, ai_AimModY, Random Real(-0.300 * (Global.difficultyMax - Players In Slot(Slot Of(
				Event Player), Team 1).p_Difficulty), (Global.difficultyMax - Players In Slot(Slot Of(Event Player), Team 1).p_Difficulty)
				* 0.300), Random Real(0.100, 0.500), None);
		Else;
			If(Horizontal Angle Towards(Event Player, Players In Slot(Slot Of(Event Player), Team 1)) > 0);
				Chase Player Variable Over Time(Event Player, ai_AimModX, Random Real(0, (Global.difficultyMax - Players In Slot(Slot Of(
					Event Player), Team 1).p_Difficulty) * 0.750), Random Real(0.100, 0.500), None);
			Else;
				Chase Player Variable Over Time(Event Player, ai_AimModX, Random Real(-0.750 * (Global.difficultyMax - Players In Slot(Slot Of(
					Event Player), Team 1).p_Difficulty), 0), Random Real(0.100, 0.500), None);
			End;
			Chase Player Variable Over Time(Event Player, ai_AimModY, Random Real(-0.550 * (Global.difficultyMax - Players In Slot(Slot Of(
				Event Player), Team 1).p_Difficulty), (Global.difficultyMax - Players In Slot(Slot Of(Event Player), Team 1).p_Difficulty)
				* 0.550), Random Real(0.100, 0.500), None);
		End;
	}
}

rule("AI Aim Calculation")
{
	event
	{
		Subroutine;
		aiSub_AimCalculation;
	}

	actions
	{
		If(Event Player.ai_AimTurnRate == 0);
			Call Subroutine(allSub_WaitForFrame);
			Chase Player Variable Over Time(Event Player, ai_AimTurnRate, Random Real(Event Player.ai_FacingPadMin,
				Event Player.ai_FacingPadMax), Random Real(0.050, 0.150), None);
			Wait(0.150, Ignore Condition);
			Stop Chasing Player Variable(Event Player, ai_AimTurnRate);
		Else If(Random Real(0, 1) < 0.350 - Event Player.ai_ChanceMod);
			Call Subroutine(allSub_WaitForFrame);
			Event Player.ai_AimStopTime = Total Time Elapsed + Random Real(0.150, 0.250) - Event Player.ai_ChanceMod;
			Chase Player Variable At Rate(Event Player, ai_AimTurnRate, 0, Random Integer(250, 500), Destination and Rate);
			Wait Until(Event Player.ai_AimTurnRate == 0, Random Real(0.150, 0.250) - Event Player.ai_ChanceMod);
			Stop Chasing Player Variable(Event Player, ai_AimTurnRate);
			Chase Player Variable Over Time(Event Player, ai_AimTurnRate, 0, Random Real(0.150, 0.250) - Event Player.ai_ChanceMod, None);
			Call Subroutine(aiSub_AimModSet);
		Else;
			Call Subroutine(allSub_WaitForFrame);
			Event Player.ai_AimTurnRate = (Event Player.ai_FacingAngleMod * Angle Between Vectors(Facing Direction Of(Event Player),
				Direction Towards(Eye Position(Event Player), Eye Position(Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.300,
				0)))) ^ Event Player.ai_FacingAnglePow + Random Real(Event Player.ai_FacingPadMin, Event Player.ai_FacingPadMax);
		End;
		If(Array Contains(Global.scopeHeroes, Hero Of(Event Player)) && Is Firing Secondary(Event Player));
			Event Player.ai_AimTurnRate = Event Player.ai_AimTurnRate / 1.500;
		End;
	}
}

rule("aiSub_FlickIn")
{
	event
	{
		Subroutine;
		aiSub_FlickIn;
	}

	actions
	{
		Stop Facing(Players In Slot(Slot Of(Event Player), Team 2));
		If(Players In Slot(Slot Of(Event Player), Team 2).ai_AimBase == 0);
			Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction Towards(Eye Position(Event Player), Eye Position(
				Players In Slot(Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)), Evaluate Once(Random Integer(Players In Slot(Slot Of(
				Event Player), Team 2).ai_FacingCapMax - 180, Players In Slot(Slot Of(Event Player), Team 2).ai_FacingCapMax)), To World,
				Direction and Turn Rate);
			Wait Until(Is In View Angle(Players In Slot(Slot Of(Event Player), Team 2), Vector(X Component Of(Eye Position(Players In Slot(
				Slot Of(Event Player), Team 1)) - Vector(0, 0.250, 0)), Y Component Of(Eye Position(Players In Slot(Slot Of(Event Player),
				Team 1)) - Vector(0, 0.250, 0)) - Y Component Of(Eye Position(Players In Slot(Slot Of(Event Player), Team 2)) - Vector(0,
				0.250, 0)), Z Component Of(Eye Position(Players In Slot(Slot Of(Event Player), Team 1)))), 0.500), 1);
		Else If(Players In Slot(Slot Of(Event Player), Team 2).ai_AimBase == 1);
			Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction Towards(Eye Position(Event Player), Eye Position(
				Players In Slot(Slot Of(Event Player), Team 1))), Evaluate Once(Random Integer(Players In Slot(Slot Of(Event Player), Team 2)
				.ai_FacingCapMax - 180, Players In Slot(Slot Of(Event Player), Team 2).ai_FacingCapMax)), To World, Direction and Turn Rate);
			Wait Until(Is In View Angle(Players In Slot(Slot Of(Event Player), Team 2), Vector(X Component Of(Eye Position(Players In Slot(
				Slot Of(Event Player), Team 1))), Y Component Of(Eye Position(Players In Slot(Slot Of(Event Player), Team 1)))
				- Y Component Of(Eye Position(Players In Slot(Slot Of(Event Player), Team 2))), Z Component Of(Eye Position(Players In Slot(
				Slot Of(Event Player), Team 1)))), 0.500), 1);
		End;
	}
}

rule("aiSub_FlickOut")
{
	event
	{
		Subroutine;
		aiSub_FlickOut;
	}

	actions
	{
		Stop Facing(Players In Slot(Slot Of(Event Player), Team 2));
		Start Facing(Players In Slot(Slot Of(Event Player), Team 2), Direction From Angles(Horizontal Facing Angle Of(Players In Slot(
			Slot Of(Event Player), Team 2)) - Random Real(0.600, 1), Vertical Facing Angle Of(Players In Slot(Slot Of(Event Player),
			Team 2)) - Random Real(0.300, 0.700)), Evaluate Once(Random Integer(Players In Slot(Slot Of(Event Player), Team 2)
			.ai_FacingCapMax - 180, Players In Slot(Slot Of(Event Player), Team 2).ai_FacingCapMax)), To World, None);
		Wait(Random Real(0.100, 0.200), Ignore Condition);
		Call Subroutine(aiSub_FacingReset);
	}
}