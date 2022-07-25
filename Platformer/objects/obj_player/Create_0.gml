//initial keybinds
_keyRight = (keyboard_check(global.rightKey) || keyboard_check(global.altRight));
_keyLeft = (keyboard_check(global.leftKey) || keyboard_check(global.altLeft));
_keySlam = (keyboard_check_pressed(global.downKey) || keyboard_check_pressed(global.altDown));
_keyJump = (keyboard_check_pressed(global.jumpKey) || keyboard_check_pressed(global.altJump));
_keyUse = keyboard_check_pressed(global.useKey1);
//factory defaults basically, do not edit at runtime.
WALK_SPD = 3.5;
ACCEL_RATE = .2;
DECCEL_RATE = .8;
JUMP_SPD = -8;

//Movement variables
grav = .4; //gravity acceleration rate
hSpd = 0; //current horizontal movemnt speed
vSpd = 0; //current vertical movement speed

walkSpd = WALK_SPD; //max walking speed
accelRate = ACCEL_RATE; //rate of speeding up
deccelRate = DECCEL_RATE; //slowdown spped if no buttons pressed
jumpSpd = JUMP_SPD; //jump height

slamSpd = 25; //speed of slam attack
floatSpd = -1;

floatTimer = 0;
floatCooldown = 0;

canJump = 0; //timer for jump input
coyoteTime = 5; //max coyote time

onGround = false; //if on the ground and not in air

extraJumpCount = 1; //increase for more jumps
maxJumps = 1; //maximum extra jumps

jumpInputBuffer = 7; //MIM buffer
jumpInputTimer = -1; //MIM timer

window_set_fullscreen(global.fullscreen);

#region player states
stateFreeMove = function()
{
	hSpd += (_keyRight - _keyLeft) * accelRate; //must be right minus left
	if(hSpd > walkSpd)hSpd = walkSpd;
	if(hSpd < -walkSpd)hSpd = -walkSpd;
	if((_keyRight - _keyLeft) = 0) && (onGround)
	{
		hSpd *= deccelRate;
		if(abs(hSpd)<=.1) hSpd = 0;
	}

	//jump and vertical speed
	vSpd += grav;

	if(_keyJump) //set the MIM
	{jumpInputTimer = jumpInputBuffer;}

	if(canJump > 0) && (jumpInputTimer>=0) //BOING
	{
		vSpd = jumpSpd;
		canJump = 0;
		jumpInputTimer = -1;
	}

	if(!onGround) && (extraJumpCount>0) && (jumpInputTimer>=0) //Midair BOING
	{
		vSpd = jumpSpd;
		canJump = 0;
		jumpInputTimer = -1;
		extraJumpCount--;
	}

	if(jumpInputTimer >=0) //MIM handling
		{jumpInputTimer--;}

	if(_keySlam) && (!onGround) //Slam move
		{vSpd = slamSpd; 
		state = stateSlam;}
		
	if(_keyUse && floatCooldown <=0)
	{
		state = stateFloat;
		floatTimer = 120;
	}
}
stateSlam = function()
{
	vSpd += grav*1.5;
	if(onGround)
	state = stateFreeMove;
}
stateFloat = function()
{
	hSpd = (_keyRight - _keyLeft)*WALK_SPD/2;
	vSpd = floatSpd;
	
	if(_keyUse)
	state = stateFreeMove;
	
	if(_keyJump)&&(extraJumpCount>0)
	{
		vSpd = jumpSpd;
		canJump = 0;
		jumpInputTimer = -1;
		extraJumpCount--;
		state = stateFreeMove;
		floatCooldown = 60;
	}
	else if(_keyJump)&&(extraJumpCount<=0)
	{
		state = stateFreeMove;
		floatCooldown = 60;
	}
	
	if(_keySlam)
	{vSpd = slamSpd; 
	state = stateSlam;}
	
	if(floatTimer >=0)
	{floatTimer--;}
	else
	{
		state = stateFreeMove;
		floatCooldown = 60;
	}
		
}
state = stateFreeMove;
#endregion