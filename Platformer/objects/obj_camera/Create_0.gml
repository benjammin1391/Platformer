camera = camera_create();

var _vm = matrix_build_lookat(x,y,-10,x,y,0,0,1,0);
var _pm  = matrix_build_projection_ortho(640,360,1,99999);

camera_set_view_mat(camera,_vm);
camera_set_proj_mat(camera,_pm);

view_camera[0] = camera;

follow = obj_player;
xTo = x;
yTo = y;
zoomScale = 1;
minZoom = .5;
maxZoom = 2;
zoomSpd = .02;

function zoomIn(_zScale,_zSpeed)
{
	if(zoomScale > _zScale)
	{
		zoomScale -= _zSpeed;
		if(zoomScale < _zScale)
		zoomScale = _zScale;
	}
	var _ppm  = matrix_build_projection_ortho(640*zoomScale,360*zoomScale,1,99999);
	camera_set_proj_mat(camera,_ppm);
}
function zoomOut(_zScale,_zSpeed)
{
	if(zoomScale < _zScale)
	{
		zoomScale += _zSpeed;
		if(zoomScale > _zScale)
		zoomScale = _zScale;
	}
	var _ppm  = matrix_build_projection_ortho(640*zoomScale,360*zoomScale,1,99999);
	camera_set_proj_mat(camera,_ppm);
}
function zoomSet(_zScale)
{
	zoomScale = _zScale;
	var _ppm  = matrix_build_projection_ortho(640*zoomScale,360*zoomScale,1,99999);
	camera_set_proj_mat(camera,_ppm);
}