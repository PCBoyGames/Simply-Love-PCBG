if SL.Global.GameMode ~= "StomperZ" then
	local pn = ...

	local playerStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	local grade = playerStats:GetGrade()

	-- "I passd with a q though."
	local title = GAMESTATE:GetCurrentSong():GetDisplayFullTitle()
	if title == "D" then grade = "Grade_Tier99" end

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

	return t

end
