//JUST the pose parameter parts for a QC.
//-- poseparameter -------------
$poseparameter wheels	-180 180 loop 360	//Loops one pose parameter.
$poseparameter wheels_a		 0 1	            //Toggles from one pose to another
$poseparameter bed		 0 1	            //Toggles from one pose to another
$poseparameter steer	-1 1 	            //Goes between two opposite frames. like left/neutral/right, up/neutral/down
//-- animations -------------
$animation 	a_idle 			"Neutral"		//Idle sequence. Use your model's smd. (or any of the models you got)

$animation 	steer_0 		anims/truck_anim frames 0 0 weightlist "steer" 	subtract a_idle 0 //left
$animation 	steer_1 		anims/truck_anim frames 1 1 weightlist "steer" 	subtract a_idle 0 //neutral
$animation 	steer_2 		anims/truck_anim frames 2 2 weightlist "steer" 	subtract a_idle 0 //right

$animation 	wheels_auto 	anims/truck_anim	fps 5	weightlist "wheels"	subtract a_idle 0 //full rolling animation.
$animation 	wheels_0 		anims/truck_anim frames 0 0 weightlist "wheels"	subtract a_idle 0 // 0°
$animation 	wheels_1 		anims/truck_anim frames 1 1 weightlist "wheels"	subtract a_idle 0 // 90°
$animation 	wheels_2 		anims/truck_anim frames 2 2 weightlist "wheels"	subtract a_idle 0 // 180°
$animation 	wheels_3 		anims/truck_anim frames 3 3 weightlist "wheels"	subtract a_idle 0 // 270°
$animation 	wheels_4 		anims/truck_anim frames 4 4 weightlist "wheels"	subtract a_idle 0 // 360°

$animation 	bed_0 			anims/truck_anim frames 0 0 weightlist "bed"	subtract a_idle 0 //idle
$animation 	bed_1 			anims/truck_anim frames 1 1 weightlist "bed"	subtract a_idle 0 //up
//-- sequences -------------
$sequence 	0_Idle			a_idle

$sequence 	steer 			{ steer_0 	steer_1 	steer_2								}	blendwidth 3 blend "steer"		-1 1 		delta autoplay hidden
$sequence 	wheel_all 		{ wheels_0	wheels_1	wheels_2	wheels_3	wheels_4	}	blendwidth 5 blend "wheels"		-180 180	delta autoplay hidden
$sequence 	wheel_autoroll	{ wheels_0	wheels_auto										}	blendwidth 2 blend "wheels_a"	0 1			delta autoplay hidden
$sequence 	bed 			{ bed_0		bed_1 											}	blendwidth 2 blend "bed"		0 1 		delta autoplay hidden

//-- collisionmodel -------------
$collisionmodel truck_phy {
$concave
$mass 800.0
$inertia 1.00
}




//-- other example -------------

/*
Idk where else to put it.
But here's a pose parameter setup that adds simultaneously left/neutral/right AND up/neutral/down pose parameters to one one sequence.

$PoseParameter "ver_aims" -1 1 loop 0
$PoseParameter "hor_aims" -2 2 loop 0

$animation "a_idle"	anims/a_idle"
$animation "ldr"	"anims/lookposes2"	frames 0 0 subtract a_idle  0
$animation "ld"		"anims/lookposes2"	frames 1 1 subtract a_idle  0
$animation "ldl"	"anims/lookposes2"	frames 2 2 subtract a_idle  0
$animation "lsr"	"anims/lookposes2"	frames 3 3 subtract a_idle  0
$animation "ls"		"anims/lookposes2"	frames 4 4 subtract a_idle  0
$animation "lsl"	"anims/lookposes2"	frames 5 5 subtract a_idle  0
$animation "lur"	"anims/lookposes2"	frames 6 6 subtract a_idle  0
$animation "lu"		"anims/lookposes2"	frames 7 7 subtract a_idle  0
$animation "lul"	"anims/lookposes2"	frames 8 8 subtract a_idle  0

$Sequence "look_poses" {
ldr ld ldl
lsr ls lsl
lur lu lul
blendwidth 3 //it blends three in vertical and three in horizontal.
blend "hor_aims" -1 1 //hence why two pose parameters are used.
blend "ver_aims" -1 1 //hence why two pose parameters are used.
delta
}
