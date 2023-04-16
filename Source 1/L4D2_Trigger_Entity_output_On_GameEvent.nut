// This Vscript can fire outputs when a game or modevent happens. 
// To find the available events possible, check "resource/modevents.res" for available events like "player_death", "weapon_fire_on_empty"...
// the function name must be "OnGameEvent_EVENTNAME(Params)"


//	Commenting on survivor team wipe
		function "OnGameEvent_mission_lost(params){
				DoEntFire("snd_fail", "Playsound", "", 0.0, null, null) // This fires the output
		}
    
//	Commenting on Defib usage
		function OnGameEvent_defibrillator_used(params){
				DoEntFire("defib_used_*", "add", "1", 0.0, null, null)
		}

//	Makes Specified player laugh five seconds after someone has earned an achievement
		function OnGameEvent_achievement_earned(params){
        DoEntFire("!Nick", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
        DoEntFire("!Rochelle", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
        DoEntFire("!Coach", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
        DoEntFire("!Ellis", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
        
        DoEntFire("!Bill", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
        DoEntFire("!Louis", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
        DoEntFire("!Francis", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
        DoEntFire("!Zoey", "speakresponseconcept", "PlayerLaugh", 5, null, null); 
		}
