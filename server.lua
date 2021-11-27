local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('ied', function(source)
    TriggerClientEvent("qb-carbomb:CheckVehicle", source)
end)

RegisterServerEvent('qb-carbomb:RemoveBombFromInv')
AddEventHandler('qb-carbomb:RemoveBombFromInv', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local item = Player.Functions.GetItemByName(Config.Item)

    if item.amount > 0 then
        Player.Functions.RemoveItem(Config.Item, 1)
    end
end)