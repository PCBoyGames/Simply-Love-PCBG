local t = Def.ActorFrame{

	OnCommand=function(self)
		self:xy(_screen.cx - (IsUsingWideScreen() and 170 or 165), _screen.cy - 29)
	end,

	-- ----------------------------------------
	-- Actorframe for Artist, BPM, and Song length
	Def.ActorFrame{
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set"),

		-- background for Artist, BPM, and Song Length, first quad is border, then overlay
		Def.Quad{
			InitCommand=function(self)
				self:diffuse(color("#FFFFFF"))
					:zoomto( IsUsingWideScreen() and 321 or 310, 89 )

				if ThemePrefs.Get("RainbowMode") then
					self:diffusealpha(0.75)
				end
			end
		},
		Def.Quad{
			InitCommand=function(self)
				self:diffuse(color("#000000"))
					:zoomto( IsUsingWideScreen() and 320 or 310, 88 )

				if ThemePrefs.Get("RainbowMode") then
					self:diffusealpha(0.75)
				end
			end
		},

		Def.ActorFrame{

			InitCommand=cmd(x, -110),

			-- Artist Label
			LoadFont("_miso")..{
				InitCommand=function(self)
					local text = GAMESTATE:IsCourseMode() and "NumSongs" or "Artist"
					self:settext( THEME:GetString("SongDescription", text) )
						:horizalign(right):y(8)
						:maxwidth(44)
				end,
				OnCommand=function(self) self:diffuse(0.5,0.5,0.5,1) end
			},

			-- Song Artist
			LoadFont("_miso")..{
				InitCommand=cmd(horizalign,left; xy, 5,8; maxwidth,WideScale(225,260) ),
				SetCommand=function(self)
					if GAMESTATE:IsCourseMode() then
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							self:settext( #course:GetCourseEntries() )
						else
							self:settext("")
						end
					else
						local song = GAMESTATE:GetCurrentSong()
						if song and song:GetDisplayArtist() then
							self:settext( song:GetDisplayArtist() )
						else
							self:settext("")
						end
					end
				end
			},

			LoadFont("_miso")..{
				InitCommand=function(self)
					local text = GAMESTATE:IsCourseMode() and "CourseName" or "SongName"
					self:settext( THEME:GetString("SongDescription", text) )
						:horizalign(right):y(-12)
						:maxwidth(44)
				end,
				OnCommand=function(self) self:diffuse(0.5,0.5,0.5,1) end
			},

			LoadFont("_miso")..{
				InitCommand=function(self)
					local text = GAMESTATE:IsCourseMode() and "CourseName" or "GroupName"
					self:settext( THEME:GetString("SongDescription", text) )
						:horizalign(right):y(-32)
						:maxwidth(44)
				end,
				OnCommand=function(self) self:diffuse(0.5,0.5,0.5,1) end
			},



			LoadFont("_miso")..{
				InitCommand=cmd(horizalign,left; xy, 5,-32; maxwidth,WideScale(225,260) ),
				SetCommand=function(self)
					if GAMESTATE:IsCourseMode() then
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							self:settext( #course:GetCourseEntries() )
						else
							self:settext("")
						end
					else
						local song = GAMESTATE:GetCurrentSong()
						if song and song:GetGroupName() then
							self:settext( song:GetGroupName() )
						else
							self:settext("")
						end
					end
				end
			},

			LoadFont("_miso")..{
				InitCommand=cmd(horizalign,left; xy, 5,-12; maxwidth,WideScale(225,260) ),
				SetCommand=function(self)
					if GAMESTATE:IsCourseMode() then
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							self:settext( #course:GetCourseEntries() )
						else
							self:settext("")
						end
					else
						local song = GAMESTATE:GetCurrentSong()
						if song and song:GetDisplayFullTitle() then
							self:settext( song:GetDisplayFullTitle() )
						else
							self:settext("")
						end
					end
				end
			},





			-- BPM Label
			LoadFont("_miso")..{
				Text=THEME:GetString("SongDescription", "BPM"),
				InitCommand=function(self)
					self:horizalign(right):y(28)
						:diffuse(0.5,0.5,0.5,1)
				end
			},

			-- BPM value
			LoadFont("_miso")..{
				InitCommand=cmd(horizalign, left; y, 28; x, 5; diffuse, color("1,1,1,1")),
				SetCommand=function(self)
					--defined in ./Scipts/SL-CustomSpeedMods.lua
					local text = GetDisplayBPMs()
					self:settext(text or "")
				end
			},

			-- Song Length Label
			LoadFont("_miso")..{
				Text=THEME:GetString("SongDescription", "Length"),
				InitCommand=function(self)
					self:horizalign(right)
						:x(_screen.w/4.5):y(28)
						:diffuse(0.5,0.5,0.5,1)
				end
			},

			-- Song Length Value
			LoadFont("_miso")..{
				InitCommand=cmd(horizalign, left; y, 28; x, _screen.w/4.5 + 5),
				SetCommand=function(self)
					local duration

					if GAMESTATE:IsCourseMode() then
						local Players = GAMESTATE:GetHumanPlayers()
						local player = Players[1]
						local trail = GAMESTATE:GetCurrentTrail(player)

						if trail then
							duration = TrailUtil.GetTotalSeconds(trail)
						end
					else
						local song = GAMESTATE:GetCurrentSong()
						if song then
							duration = song:MusicLengthSeconds()
						end
					end


					if duration then
						duration = duration / SL.Global.ActiveModifiers.MusicRate
						if duration == 105.0 then
							-- r21 lol
							self:settext( THEME:GetString("SongDescription", "r21") )
						else
							local hours = 0
							if duration > 3600 then
								hours = math.floor(duration / 3600)
								duration = duration % 3600
							end

							local finalText
							if hours > 0 then
								-- where's HMMSS when you need it?
								finalText = hours .. ":" .. SecondsToMMSS(duration)
							else
								finalText = SecondsToMSS(duration)
							end

							self:settext( finalText )
						end
					else
						self:settext("")
					end
				end
			}
		}

	}
}

return t
