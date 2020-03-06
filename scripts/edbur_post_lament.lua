local EdburPostLament = File:extend()

function EdburPostLament:new(first, revive)
	EdburPostLament.super.new(self, "weapon shop")
	Art.new(self, "weapon_shop")
	self.anim:add("blush", 6)
    self.anim:add("idle", 4)

    if revive then
        self.revived = revive
    end

    if self.revived then
        self:room(self.revived)
        return
    end

	self:setOnItems({
	{
		request =  Player.pronoun .. "NoteEdbur",
		response = [[Эдубр покраснел. "Н-не читай его! Просто отдать Фердану."]],
		anim = "blush",
	}})

    if Events.passedForest then
        self.anim:add("naked", 7)
        self:setText([["Рад видеть, что ты еще жива, [username]!"]])
        self:setOptions({
            {
                text = [["Я немного застряла на своем приключении."]],
                func = F(self, "advice"),
            },
            {
                text = [["Почему ты без одежды?"]],
                response = [["Я случайно порвал рубашку, а твои родители были единственными, кто шил одежду в этом городе. Так что никакой рубашки у меня нет."]],
                remove = true
            },
            {
                text = [[Иди в свою комнату.]],
                func = F(self, "room")
            }
        })
    else
        if not self.inited and not first then
            self:setText([["ад видеть, что ты еще жива, [username]!"]])
        end

        if first and type(first) == "string" then
            self:setText(first)
        else
            self:setOptions({
                {
                    text = [["Я немного застряла на своем приключении."]],
                    func = F(self, "advice"),
                    anim = "idle"
                },
                {
                    text = [[Иди в свою комнату.]],
                    func = F(self, "room")
                }
            })
        end
    end

    self.inited = true
end


function EdburPostLament:advice()
    self:setText([["Творческое мышление- это ключ! Иногда вам просто нужно представить мир по- другому, чтобы найти правильный путь."]])
    self:setOptions({
        {
            text = [["Что ты имеешь в виду?"]],
            response = [["Ну, скажем так. Точно так же, как мы боремся, удаляя и добавляя что-то, мы можем использовать эту технику, чтобы манипулировать миром вокруг нас."]],
            options = {
                {
                    text = [["Это все очень непонятно"]],
                    response = [[¯\_(ツ)_/¯   ]],
                    func = F(self, "new")
                },
                {
                    text = [["Я думаю, что понимаю."]],
                    response = [["Хорошо!"]],
                    func = F(self, "new")
                }
            }
        }
    })
end


function EdburPostLament:room(revive)
    Art.new(self, "room")

    if revive then
        if revive == 9 then
            self:setText([[[username] проснулась. Она хорошо отдохнула и была готова продолжить своё приключение.]])
        else
            self:setText([[Внезапно, [username] проснулась вся в поту. Неужели всё это было сном? Возможно, это предупреждение, чтобы быть осторожней. Она встала и надела свою одежду.]])
        end
        if self.isOpen then
            self.player:regainHealth()
            self.revived = false
            Game:addFile(require("elli")())
            Game:addFile(require("dragonhill_gate")())
            Game:addFile(require("westown_gate")())
        end
    else
        self:setText([["Это так мило со стороны Эда, что он позволяет мне остаться здесь с ним," сказала [username].]])
    end

    self:setOptions({
        {
            text = "Проверить шкаф.",
            response = [[[username] заглянула в шкаф. Она увидела странный камень, коробку с конфетами, и нашла 10 золотых на верхней полке. [username] взялп золото и положилп его в карман.]],
            condition = function () return not Events.searchedCloset end,
            event = "searchedCloset",
            gold = 10,
            remove = true
        },
        {
            text = [[Горевать.]],
            response = [["Я скучаю по тебе, мама, папа," сказала [username].
Все ещё больно..]],
        },
        {
            text = "Назад.",
            func = function () self.revived = false self:new(nil) end
        }
    })
end

function EdburPostLament:update(dt)
	EdburPostLament.super.update(self, dt)
end


function EdburPostLament:draw()
	EdburPostLament.super.draw(self)
end


function EdburPostLament:__tostring()
	return lume.tostring(self, "EdburPost")
end

return EdburPostLament