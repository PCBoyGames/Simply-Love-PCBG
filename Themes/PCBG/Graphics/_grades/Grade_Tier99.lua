return LoadActor("graphics/q.png")..{ 	OnCommand=function(self) self:linear(0.01):zoom(0.4):x(-70):sleep(1.6):linear(0.45):rotationz(360):zoom(0.85):x(70) end }