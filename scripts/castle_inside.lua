local CastleInside = File:extend()

CastleInside.step = 1

function CastleInside:new()
	CastleInside.super.new(self, "castle")
	Art.new(self, "castle_inside")

	self:setText([[[username] шла по коридорам замка.]])
	self:setOptions({
		{
			text = "Продолжать идти",
			func = function () self:walk() end
		},
		{
			text = "Вернуться",
			options = {},
			func = function () self:goBack() end
		}
	})
end

function CastleInside:walk()
	self.dead = true
	if CastleInside.step == 3 then
	if CastleInside.step >= 3 then
		self:loadThroneRoom()
		return
	elseif CastleInside.step == 1 then
		Game:replaceFile("castle", require("tentacle")("castle", "castle_inside"))
	elseif CastleInside.step == 2 then
		Game:replaceFile("castle", require("spider")("castle", "castle_inside"))
	end
	CastleInside.step = CastleInside.step + 1
end

function CastleInside:goBack()
	self.player:regainHealth()
	self:setOptions({})
	Game:replaceFile("castle", require("castle")())
end


function CastleInside:loadThroneRoom()
	Game:replaceFile("castle", require("throne_room")())
end


function CastleInside:__tostring()
	return lume.tostring(self, "Forest")
end

function CastleInside:resetStep()
	CastleInside.step = 1
end

return CastleInside