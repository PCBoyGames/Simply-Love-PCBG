local tweentime = 0.325

return Def.ActorFrame{
	InitCommand=function(self)
		self:Center():draworder(101)
	end,
	OffCommand=function(self)
		-- by the time this screen's OffCommand is called, player mods should already have been read from file
		-- and applied to the SL[pn].ActiveModifiers table, so it is now safe to call ApplyMods() on any human players
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			ApplyMods(player)
		end
	end,

	Def.Quad{
		Name="FadeToBlack",
		InitCommand=function(self)
			self:horizalign(right):vertalign(bottom):FullScreen()
			self:diffuse( Color.Black ):diffusealpha(0)
		end,
		OnCommand=function(self)
			self:sleep(tweentime*2):linear(tweentime):diffusealpha(1)
		end
	},

	Def.Quad{
		Name="HorizontalWhiteSwoosh",
		InitCommand=function(self)
			self:horizalign(center):vertalign(middle)
				:diffuse( Color.White )
				:zoomto(_screen.w + 100,52):faderight(0):fadeleft(0):cropright(1):diffusealpha(0)
		end,
		OnCommand=function(self)
			self:cropright(0):linear(tweentime):diffusealpha(1):sleep(tweentime)
			self:linear(tweentime*2):diffusealpha(0):y(50)
			self:sleep(0.1):queuecommand("Load")
		end,
		LoadCommand=function(self)
			SCREENMAN:GetTopScreen():Continue()
		end
	},
	Def.Quad{
		Name="HorizontalWhiteSwoosh2",
		InitCommand=function(self)
			self:horizalign(center):vertalign(middle)
				:diffuse( Color.Black )
				:zoomto(_screen.w + 100,50):faderight(0):fadeleft(0):cropright(1):diffusealpha(1)
		end,
		OnCommand=function(self)
			self:cropright(0):linear(tweentime):diffusealpha(1):sleep(tweentime)
			self:linear(tweentime*2):diffusealpha(1):y(50)
			self:sleep(0.1):queuecommand("Load")
		end,
		LoadCommand=function(self)
			SCREENMAN:GetTopScreen():Continue()
		end
	},

	Def.BitmapText{
		Font="_wendy small",
		Text=THEME:GetString("ScreenProfileLoad","Loading Profiles..."),
		InitCommand=function(self)
			self:diffuse( Color.White ):zoom(0.6):sleep(tweentime*2):linear(tweentime*2):y(50):diffusealpha(0)
		end
	}
}