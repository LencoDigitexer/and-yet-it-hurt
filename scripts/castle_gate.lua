local CastleGate = File:extend()

function CastleGate:new()
	CastleGate.super.new(self, "castle gate")
	-- self:init()

	Art.new(self, "gate")
	self.anim:add("open", 2)
	self.anim:add("closed", 1)

	if self.isOpen then
		Events.sawCastleGate = true
	end

	if Events.castleUnlocked then
		self.anim:set("open")
		self:setText([[[username] подошла к другим воротам, ведущим в замок. На этот раз стражи не было.]])
		self:setOptions({
			{
				text = "Идти через ворота.",
				func = F(self, "enter")
			}
		})
	else
		self:setOnItems({
			{
				request = "castleGateKey",
				event = "gateUnlocked",
				response ="[username] попыталась отпереть калитку ключом, и она открылась.",
				anim = "open",
				options = {
					{
						text = "Идти через ворота.",
						func = F(self, "enter")
					}
				}
			}
		})

		self:setText([[[username] подошла к другим воротам, ведущим в замок. На этот раз стражи не было.]])
		self:setOptions({
			{
				text = "Открыть ворота",
				response = "[username] попыталась открыть калитку, но она была заперта."
			}
		})
	end
end


function CastleGate:enter()
	self:setOptions({})
	self.deleteOnClose = true
	Game:removeFile("smith")
	Game:removeFile("eastown gate")
	Game:removeFile("armor shop")
	Game:addFile(require("castle")())
end

return CastleGate