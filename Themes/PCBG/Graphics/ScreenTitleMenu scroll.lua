local index = Var("GameCommand"):GetIndex()

local t = Def.ActorFrame{}

-- this renders the text of a single choice in the scroller
t[#t+1] = LoadFont("_wendy small")..{
	Name="Choice"..index,
	Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() ),

	OnCommand=cmd(diffusealpha,0; sleep,index * 0.075; linear,0.2; diffusealpha,1),
	OffCommand=cmd(sleep,index * 0.075; linear,0.18; diffusealpha, 0),

	GainFocusCommand=cmd(stoptweening; linear,0.1; zoom,1; diffuse, PlayerColor(PLAYER_2); glow,{1,1,1,0.5}; decelerate,0.05; glow,{1,1,1,0.0}; shadowlength,0.5),
	LoseFocusCommand=cmd(stoptweening; linear,0.1; zoom,0; diffuse, ThemePrefs.Get("RainbowMode") and {1,1,1,1} or color("#888888"); glow,{1,1,1,0}; shadowlength,0)
}

return t