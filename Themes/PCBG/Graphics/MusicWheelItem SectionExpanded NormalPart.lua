local colorindex = SL.Global.ActiveColorIndex

return Def.ActorFrame{
	InitCommand=cmd(x, 26),
	Def.Quad{
		InitCommand=cmd(diffuse, GetHexColor(colorindex+1); zoomto, (_screen.w/2.1675), (_screen.h/15))
	},
	Def.Quad{
		InitCommand=cmd(diffuse, GetHexColor(colorindex+1); zoomto, (_screen.w/2.1675), (_screen.h/15 - 1))
	},
	Def.Quad{
		InitCommand=cmd(diffuse, GetHexColor(colorindex+1); zoomto, (_screen.w/2.1675)-1, (_screen.h/15)-1)
	},
	Def.Quad{
		InitCommand=cmd(diffuse, GetHexColor(colorindex+1); zoomto, (_screen.w/2.1675)-1, (_screen.h/15 - 1)-1)
	},
	Def.Quad{
		InitCommand=cmd(diffuse, Color.Black; diffusealpha, 0.5; zoomto, (_screen.w/2.1675)-1, (_screen.h/15)-1)
	},
	Def.Quad{
		InitCommand=cmd(diffuse, Color.Black; diffusealpha, 0.5; zoomto, (_screen.w/2.1675)-1, (_screen.h/15 - 1)-1)
	}

}