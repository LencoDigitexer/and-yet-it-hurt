local Bat = Fight:extend()

function Bat:new(...)
	Bat.super.new(self, ...)
    Art.new(self, "bat")
    
    self.enemyName = "bat"

	self.anim:add("attacking", 1);
	self.anim:add("defending", 1);
	self.anim:add("prepareAttack", 1);
	self.anim:add("prepareDefense", 1);

	self.health = 10

	self.attack = 1
	self.timeAttacking = 4
	self.timeDefending = 4

	self.strength = 5

	self.description = "Внезапно, [username] столкнулась с летучей мышью. Маленькое, но мерзкое существо."
	self.attackDescription = "Летучая мышь начала кусать [username]"
	self.prepareAttackDescription = "Значит, летучая мышь готовилась к нападению!"
end


function Bat:update(dt)
	Bat.super.update(self, dt)
end


function Bat:draw()
	Bat.super.draw(self)
end


function Bat:__tostring()
	return lume.tostring(self, "Bat")
end

return Bat