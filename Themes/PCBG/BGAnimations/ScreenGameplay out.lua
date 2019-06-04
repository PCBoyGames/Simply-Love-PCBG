return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(0,0,0,0) end,
		OnCommand=function(self) self:sleep(0.5):linear(1):diffusealpha(1):sleep(1) end
	},
	Def.BitmapText{
		Font="_wendy small",
		Text=THEME:GetString("ScreenGameplay","Pass"),
		InitCommand=function(self) self:Center():diffuse(1,1,1,0) end,
		OnCommand=function(self) self:zoom(2):sleep(0.5):linear(1):diffusealpha(1):sleep(1):linear(1):diffusealpha(0) end
	}
}