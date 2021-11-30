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
    if Config.JobDisarm then
        if Player.PlayerData.job.name == Config.PoliceJob then
            TriggerClientEvent('qb-carbomb:disarmBomb', source)
        else
            TriggerClientEvent('QBCore:Notify', source, 'You can\'t disarm a vehicle...', 'error')
        end
    else
        TriggerClientEvent('qb-carbomb:disarmBomb', source)
    end
end)

QBCore.Commands.Add('inspect', 'Inspect the vehicle for a bomb', {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.JobInspect then
        if Player.PlayerData.job.name == Config.PoliceJob then
            TriggerClientEvent('qb-carbomb:inspectBomb', source)
        else
            TriggerClientEvent('QBCore:Notify', source, 'You can\'t inspect a vehicle...', 'error')
        end
    else
        TriggerClientEvent('qb-carbomb:inspectBomb', source)
    end
end)