local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('ied', function(source)
    local src = source
    TriggerClientEvent("qb-carbomb:CheckVehicle", src)
end)

RegisterServerEvent('qb-carbomb:RemoveBombFromInv')
AddEventHandler('qb-carbomb:RemoveBombFromInv', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local item = Player.Functions.GetItemByName(Config.Item)

    if item.amount > 0 then
        Player.Functions.RemoveItem(Config.Item, 1)
    end
end)

QBCore.Commands.Add('disarm', 'Disarm a car bomb', {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-carbomb:disarmBomb', source)
end)

QBCore.Commands.Add('inspect', 'Inspect the vehicle for a bomb', {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-carbomb:inspectBomb', source)
end)
