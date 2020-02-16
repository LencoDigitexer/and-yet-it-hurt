local GroceryStore = File:extend()

function GroceryStore:new()
	GroceryStore.super.new(self, "grocery store")
	Art.new(self, "grocery_store")
	self.anim:add("open", 2)
	self.anim:add("closed", 1)
	
	if self.isOpen then
		Events.sawStore = true
	end

    self:setText([[[username] стояла перед дверью продуктового магазина. Табличка говорила, что она закрыт.]])

	self:setOptions({
		{
			text = [[Постучать.]],
			default = true,
			func = F(self, "checkOpen")
		},
		{
            text = [[Крикнуть "Тут кто-нибудь есть?"]],
            response = [["Тут кто-нибудь есть?" прокричала [username]. Ответа на крик не последовало.]]
		}
	})
end


function GroceryStore:checkOpen()
	self:setText([[[username] постучалась в дверь. Ответа не было.]])
	if self.rContent:find("OPEN") then
		self.anim:set("open")
		self:setText("Внезапно, на табличке стало написано 'ОТКРЫТО'. Но дверь все еще закрыта")
	end
end

return GroceryStore