data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("vesgoboy_barber:SaveHair")
AddEventHandler("vesgoboy_barber:SaveHair", function(index)
	local _item = item
	local _source = source

	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local identifier = user.getIdentifier()
		local charid = user.getSessionVar("charid")
		local price = 4
			
		if user.getMoney() >= price then
			user.removeMoney(price)
			MySQL.query("SELECT skin FROM skins WHERE identifier=(@identifier) AND charid=(@characterid)", {['@identifier'] = identifier, ['@characterid'] = charid}, function(data)
			local skin = {}

			skin = json.decode(data[1].skin)
			skin['hair'] = tostring(index)

			MySQL.update("UPDATE skins SET skin=(@skin) WHERE identifier=(@identifier) AND charid=(@characterid)", {['@identifier'] = identifier, ['@skin'] = json.encode(skin), ['@characterid'] = charid})
		end)
			TriggerClientEvent('redem_roleplay:ShowTopNotification', _source, "Novo Corte", "Você Cortou o Cabelo por $"..price.." Dólares", 4000)
		else
			TriggerClientEvent('redem_roleplay:Tip', _source, "Você (~e~Não~t~) tem dinheiro!", 4000)
		end
	end)
end)

RegisterServerEvent("vesgoboy_barber:SaveBeard")
AddEventHandler("vesgoboy_barber:SaveBeard", function(index)
	local _item = item
	local _source = source
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local identifier = user.getIdentifier()
		local charid = user.getSessionVar("charid")
		local price = 2
		
		if user.getMoney() >= price then
			user.removeMoney(price)
			MySQL.query("SELECT skin FROM skins WHERE identifier=(@identifier) AND charid=(@characterid)", {['@identifier'] = identifier, ['@characterid'] = charid}, function(data)
			local skin = {}

			skin = json.decode(data[1].skin)
			skin['beard'] = tostring(index)

			MySQL.update("UPDATE skins SET skin=(@skin) WHERE identifier=(@identifier) AND charid=(@characterid)", {['@identifier'] = identifier, ['@skin'] = json.encode(skin), ['@characterid'] = charid})
			end)

			TriggerClientEvent('redem_roleplay:ShowTopNotification', _source, "Novo Corte", "Você Fez a Barba por $"..price.." Dólares", 4000) 
		else
			TriggerClientEvent('redem_roleplay:Tip', _source, "Você (~e~Não~t~) tem dinheiro!", 4000)
		end
	end)
end)