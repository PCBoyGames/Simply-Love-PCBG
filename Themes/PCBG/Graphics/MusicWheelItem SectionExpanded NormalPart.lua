return Def.ActorFrame{
	InitCommand=cmd(x, 26),

	Def.Quad{
		InitCommand=cmd(diffuse, color("#4488FF"); zoomto, (_screen.w/2.1675), (_screen.h/15))
	},
	Def.Quad{
		InitCommand=cmd(diffuse, color("#4488FF"); zoomto, (_screen.w/2.1675), (_screen.h/15 - 1))
	},
	Def.Quad{
		InitCommand=cmd(diffuse, color("#112244"); zoomto, (_screen.w/2.1675)-1, (_screen.h/15)-1)
	},
	Def.Quad{
		InitCommand=cmd(diffuse, color("#112244"); zoomto, (_screen.w/2.1675)-1, (_screen.h/15 - 1)-1)
	}
}