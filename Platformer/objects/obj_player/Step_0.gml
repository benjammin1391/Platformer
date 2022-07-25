_keyRight = (keyboard_check(global.rightKey) || keyboard_check(global.altRight));
_keyLeft = (keyboard_check(global.leftKey) || keyboard_check(global.altLeft));
_keySlam = (keyboard_check_pressed(global.downKey) || keyboard_check_pressed(global.altDown));
_keyJump = (keyboard_check_pressed(global.jumpKey) || keyboard_check_pressed(global.altJump));
_keyUse = keyboard_check_pressed(global.useKey1);

state();
if(floatCooldown >0) floatCooldown--;

//Collisions
var _didCollide = false;
if(place_meeting(x + hSpd,y, obj_platform)) //horizontal
{
	_didCollide = true;
	while(abs(hSpd)> .1)
	{
		hSpd *= .05;
		if(!place_meeting(x + hSpd,y, obj_platform))
		{x += hSpd;}
	}
	hSpd = 0;
}

onGround = false;
canJump --;
if(place_meeting(x,y+vSpd,obj_platform))//vertical collision check
{
	_didCollide = true;
	var _collider = instance_place(x,y+vSpd,obj_platform);
	if(vSpd > 0)//coming from above
	{
		if(_collider.isBreakable = true)&&(state = stateSlam)
		{instance_destroy(_collider);}
		canJump = coyoteTime;
		onGround = true;
		extraJumpCount = maxJumps;
		var _bounce = vSpd*_collider.bounceForce*-1;
		if(_bounce)<=-1//boing
		{vSpd = _bounce;}
		else
		{
			while(abs(vSpd)>.1)
			{
				vSpd *=.5;
				if(!place_meeting(x,y+vSpd, obj_platform))
				{y += vSpd;}
			}
		vSpd = 0;
		walkSpd = _collider.spd; 
		accelRate = _collider.accel;
		deccelRate = _collider.deccel;
		jumpSpd = _collider.jump; 
		}
	}
	else
	{
		while(abs(vSpd)>.1)
		{
			vSpd *=.5;
			if(!place_meeting(x,y+vSpd, obj_platform))
			{y += vSpd;}
		}
		vSpd = 0;
	}
}

if(!_didCollide)//in midair, reset stats
{
	walkSpd = WALK_SPD;
	accelRate = ACCEL_RATE;
	deccelRate = DECCEL_RATE;
	jumpSpd = JUMP_SPD;
}

//Movement
x += hSpd;
y += vSpd;