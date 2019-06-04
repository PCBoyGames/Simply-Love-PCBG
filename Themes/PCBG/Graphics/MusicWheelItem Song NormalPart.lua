return Def.ActorFrame{
	InitCommand=cmd(x, 26),

	Def.Quad{
		InitCommand=cmd(diffuse, color("#888888"); zoomto, (_screen.w/2.1675), (_screen.h/15))
	},
	Def.Quad{
		InitCommand=cmd(diffuse, color("#888888"); zoomto, (_screen.w/2.1675), (_screen.h/15 - 1))
	},
	Def.Quad{
		InitCommand=cmd(diffuse, color("#111111"); zoomto, (_screen.w/2.1675)-1, (_screen.h/15)-1)
	},
	Def.Quad{
		InitCommand=cmd(diffuse, color("#111111"); zoomto, (_screen.w/2.1675)-1, (_screen.h/15 - 1)-1)
	}
}