local slc = SL.Global.ActiveColorIndex

local af = Def.ActorFrame{}

af[#af+1] = Def.Quad{
	InitCommand=cmd(zoomto,_screen.w,0; diffuse, Color.Black; Center),
	OnCommand=cmd( accelerate,0.3; zoomtoheight,128; diffusealpha,0.9; sleep,2.5; linear,0.25),
	OffCommand=cmd(accelerate,0.3; zoomtoheight,1000)
}

af[#af+1] = Def.ActorFrame {
	InitCommand=function(self) self:Center() end,
	LoadActor("pcboy.png")..{
		InitCommand=cmd(zoom, 1; diffuse, GetHexColor(slc+1); diffusealpha,0; y, -100),
		OnCommand=cmd(decelerate, 0.75; diffusealpha, 1; y, 0; sleep, 1.5; decelerate, 0.75; x, -85; rotationz, -360; sleep, 2; linear, 0.25; diffusealpha, 0)
	}
}

af[#af+1] = Def.BitmapText{
	Font="_miso",
	Text=ScreenString("ThemeDesign"),
	InitCommand=cmd(diffuse,GetHexColor(slc+1); diffusealpha,0; Center; zoom, 2; x, 460),
	OnCommand=cmd(sleep,3;linear,0.25;diffusealpha,1),
	OffCommand=cmd(linear, 0.25; diffusealpha,0),
}

return af