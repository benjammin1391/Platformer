x += (xTo - x)/5;
y += (yTo - y)/5;

if(follow != noone)
{
	xTo = follow.x;
	yTo = follow.y;
}

var vm = matrix_build_lookat(x,y,-10,x,y,0,0,1,0);
camera_set_view_mat(camera, vm);

if(keyboard_check(global.zoomInKey))
zoomIn(minZoom,zoomSpd);

if(keyboard_check(global.zoomOutKey))
zoomOut(maxZoom,zoomSpd);

if(keyboard_check(global.zoomResetKey))
zoomSet(1);

if(keyboard_check(global.fullscreenKey))
{
	global.fullscreen = !global.fullscreen;
	window_set_fullscreen(global.fullscreen);
}