if SL.Global.GameMode ~= "StomperZ" then
	local pn = ...

	local playerStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	local grade = playerStats:GetGrade()
	local profname = PROFILEMAN:GetProfile(pn):GetDisplayName()
	local colorindex = SL.Global.ActiveColorIndex

	-- "I passd with a q though."
	-- Notice how it says passd?
	-- I'm trying to make sure
	-- this tiny little Easter
	-- egg doesn't happen on fail.
	local title = GAMESTATE:GetCurrentSong():GetDisplayFullTitle()
	if title == "D" and grade ~= "Grade_Failed" then grade = "Grade_Tier99" end
	
	-- The Question Unanswered is
	-- planned to be a 240 BPM
	-- darkpsy mix spanning thirty
	-- minutes. Good luck trying
	-- to pass the sim when I
	-- release it to the public.
	if title == "The Question Unanswered" and grade ~= "Grade_Failed" then grade = "Grade_Tier98" end

	local t = Def.ActorFrame{}

	t[#t+1] = LoadActor(THEME:GetPathG("", "_grades/"..grade..".lua"), playerStats)..{
		InitCommand=cmd(xy, 70, _screen.cy-134),
		OnCommand=function(self)
			self:zoom(0.4)
			if pn == PLAYER_1 then
				self:x( self:GetX() * -1 )
			end
		end
	}

	if ThemePrefs.Get("nice") > 0 then
		t[#t+1] = LoadActor("nice.lua", pn)
	end
	
	if grade == "Grade_Failed" then
		t[#t+1] = LoadActor("sounds/die.ogg")..{
			InitCommand=cmd(xy, 70, _screen.cy-134),
			OnCommand=function(self)
				self:play("sounds/die.ogg")
			end
		}
	end

	if grade == "Grade_Tier99" then
		t[#t+1] = LoadActor("sounds/q.ogg")..{
			InitCommand=cmd(xy, 70, _screen.cy-134),
			OnCommand=function(self)
				self:play("sounds/q.ogg")
			end
		}
	end
	
	if grade == "Grade_Tier01" then
		t[#t+1] = LoadActor("sounds/dingfour.ogg")..{
			InitCommand=cmd(xy, 70, _screen.cy-134),
			OnCommand=function(self)
				self:play("sounds/dingfour.ogg")
			end
		}
	end
	
	if grade == "Grade_Tier02" then
		t[#t+1] = LoadActor("sounds/dingthree.ogg")..{
			InitCommand=cmd(xy, 70, _screen.cy-134),
			OnCommand=function(self)
				self:play("sounds/dingthree.ogg")
			end
		}
	end
	
	if grade == "Grade_Tier03" then
		t[#t+1] = LoadActor("sounds/dingtwo.ogg")..{
			InitCommand=cmd(xy, 70, _screen.cy-134),
			OnCommand=function(self)
				self:play("sounds/dingtwo.ogg")
			end
		}
	end
	
	if grade == "Grade_Tier04" then
		t[#t+1] = LoadActor("sounds/dingone.ogg")..{
			InitCommand=cmd(xy, 70, _screen.cy-134),
			OnCommand=function(self)
				self:play("sounds/dingone.ogg")
			end
		}
	end
	
	if profname == "PCBoy" or profname == "PCBoyGames" or profname == "PCBG" then
		if grade == "Grade_Tier01" then
			t[#t+1] = LoadActor("eggs/pcboy.png")..{
				InitCommand=cmd(xy, -70, _screen.cy-130; zoom, 1; diffuse, GetHexColor(colorindex+1); diffusealpha, 0),
				OnCommand=function(self)
					self:sleep(3):linear(3):diffusealpha(1)
				end
			}
		end
	end
	
	if profname == "PCBoy" or profname == "PCBoyGames" or profname == "PCBG" then
		if grade == "Grade_Tier01" then
			t[#t+1] = LoadActor("eggs/pcboy1.ogg")..{
				InitCommand=cmd(xy, 70, _screen.cy-134),
				OnCommand=function(self)
					self:play("eggs/pcboy1.ogg")
				end
			}
		end
	end
	
	if grade == "Grade_Tier98" then
		t[#t+1] = LoadActor("eggs/pcboy.png")..{
			InitCommand=cmd(xy, -70, _screen.cy-130; zoom, 1; diffuse, GetHexColor(colorindex+1); diffusealpha, 0),
			OnCommand=function(self)
				self:sleep(3):linear(3):diffusealpha(1)
			end
		}
	end

	if grade == "Grade_Tier98" then
		t[#t+1] = LoadActor("eggs/pcboy2.ogg")..{
			InitCommand=cmd(xy, 70, _screen.cy-134),
			OnCommand=function(self)
				self:play("eggs/pcboy2.ogg")
			end
		}
	end

	



	return t

end
