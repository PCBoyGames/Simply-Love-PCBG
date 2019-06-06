local player = ...
local pn = ToEnumShortString(player)
local p = PlayerNumber:Reverse()[player]

return Def.ActorFrame{
	Name="StepArtistAF_" .. pn,
	InitCommand=cmd(draworder,1),

	-- song and course changes
	OnCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentSongChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentCourseChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),

	PlayerJoinedMessageCommand=function(self, params)
		if params.Player == player then
			self:queuecommand("Appear" .. pn)
		end
	end,
	PlayerUnjoinedMessageCommand=function(self, params)
		if params.Player == player then
			self:ease(0.5, 275):addy(scale(p,0,1,1,-1) * 30):diffusealpha(0)
		end
	end,

	-- depending on the value of pn, this will either become
	-- an AppearP1Command or an AppearP2Command when the screen initializes
	["Appear"..pn.."Command"]=function(self) self:visible(true) end,

	InitCommand=function(self)
		self:visible( false ):halign( p )

		if player == PLAYER_1 then

			self:y(_screen.cy + 21)
			self:x( _screen.cx - (IsUsingWideScreen() and 283.5 or 346))

		elseif player == PLAYER_2 then

			self:y(_screen.cy + 136)
			self:x( _screen.cx - (IsUsingWideScreen() and 282.5 or 346))
		end

		if GAMESTATE:IsHumanPlayer(player) then
			self:queuecommand("Appear" .. pn)
		end
	end,

	-- colored background quad
	Def.Quad{
		Name="BackgroundQuad",
		InitCommand=cmd(zoomto, 321, (_screen.h/28)+1; x, 113; diffuse,color("#FFFFFF") ),
		StepsHaveChangedCommand=function(self)
			local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)

			if StepsOrTrail then
				local difficulty = StepsOrTrail:GetDifficulty()
				self:diffuse(color("#FFFFFF"))
			else
				self:diffuse(color("#FFFFFF"))
			end
		end
	},
	Def.Quad{
		Name="BackgroundQuad",
		InitCommand=cmd(zoomto, 320, _screen.h/28; x, 113; diffuse,color("#000000") ),
		StepsHaveChangedCommand=function(self)
			local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)

			if StepsOrTrail then
				local difficulty = StepsOrTrail:GetDifficulty()
				self:diffuse( color("#000000") )
			else
				self:diffuse( color("#000000") )
			end
		end
	},

	--STEPS label
	Def.BitmapText{
		Font="_miso",
		OnCommand=cmd(diffuse, color("1,1,1,1"); horizalign, left; x, -45; settext, Screen.String("STEPS"))
	},

	--stepartist text
	Def.BitmapText{
		Font="_miso",
		InitCommand=cmd(diffuse,color("#FFFFFF"); horizalign, left; x, 0; maxwidth, 270),
		StepsHaveChangedCommand=function(self)

			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepsOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSteps(player)

			-- if we're hovering over a group title, clear the stepartist text
			if not SongOrCourse then
				self:settext("")
			elseif StepsOrCourse then

				local stepartist = GAMESTATE:IsCourseMode() and StepsOrCourse:GetScripter() or StepsOrCourse:GetAuthorCredit()
				self:settext(stepartist or ""):diffuse( color("#FFFFFF") )

				for i=1, stepartist:utf8len() do
					if stepartist:utf8sub(i,i):byte() >= 240 then
						self:AddAttribute(i-1, { Length=1, Diffuse={1,1,1,1} } )
					end
				end
			end
		end
	}
}