local QBCore = exports['qb-core']:GetCoreObject()
local timer = 0
local armedVeh

RegisterNetEvent('qb-carbomb:CheckVehicle', function()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local veh = QBCore.Functions.GetClosestVehicle(pCoords)
    local vCoords = GetEntityCoords(veh)
    local dist = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, vCoords.x, vCoords.y, vCoords.z, true)

    if not IsPedInAnyVehicle(ped, false) then
        if veh and (dist < 4.0) then
            QBCore.Functions.Progressbar("carbomb_arming", "Arming Device...", Config.TimeToArm, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
                anim = "weed_spraybottle_crouch_base_inspector"
            }, {}, {}, function()
                ClearPedTasksImmediately(ped)
                for k,v in pairs(Config.Detonation) do
                    if k == Config.DetonationType then
                        results = v
                        if Config.DetonationType == 1 then
                            QBCore.Functions.Notify('The device will explode in '..results.detonation..' seconds', 'success')
                            RunTimer(veh, results.detonation)
                        elseif Config.DetonationType == 2 then
                            QBCore.Functions.Notify('The device will explode when the vehicle reaches '..results.speed..' '..Config.Speed, 'success')
                        elseif Config.DetonationType == 3 then
                            QBCore.Functions.Notify('Detonate the device by pressing [G]', 'success')
                        elseif Config.DetonationType == 4 then
                            QBCore.Functions.Notify('The device will detonate '..results.detonation..' seconds after someone enters the vehicle', 'success')
                        elseif Config.DetonationType == 5 then
                            QBCore.Functions.Notify('The device will explode as soon as someone enters the drivers seat', 'success')
                        end
                    end
                    break
                end
                armedVeh = veh
                TriggerServerEvent('qb-carbomb:RemoveBombFromInv')
            end)
        else
            QBCore.Functions.Notify("You are not near any vehicles", "error")
        end
    else
        QBCore.Functions.Notify("You can't use that in a vehicle", "error")
    end
end)


CreateThread(function()
    while true do
        if armedVeh then
            for k,v in pairs(Config.Detonation) do
                if k == Config.DetonationType then
                    results = v
                    if Config.DetonationType == 1 and armedVeh then
                        RunTimer(armedVeh, results.detonation)
                    elseif Config.DetonationType == 2 and armedVeh then
                        local speed = GetEntitySpeed(armedVeh)
                        local SpeedKMH = speed * 3.6
                        local SpeedMPH = speed * 2.236936
                        
                        if results.display == 'mph' then
                            if SpeedMPH >= results.speed then
                                DetonateVehicle(armedVeh)
                            end
                        elseif results.display == 'kmh' then
                            if SpeedKMH >= results.speed then
                                DetonateVehicle(armedVeh)
                            end
                        end
                    elseif Config.DetonationType == 3 and armedVeh then
                        if IsControlJustReleased(0, results.key) then
                            DetonateVehicle(armedVeh)
                        end
                    elseif Config.DetonationType == 4 and armedVeh then
                        if not IsVehicleSeatFree(armedVeh, -1)  then
                            RunTimer(armedVeh, results.detonation)
                        end
                    elseif Config.DetonationType == 5 and armedVeh then
                        if not IsVehicleSeatFree(armedVeh, -1) then
                            DetonateVehicle(armedVeh)
                        end
                    end
                end
            end
        end
        Wait(3)
    end
end)

function RunTimer(veh, time)
    timer = time
    while timer > 0 do
        timer = timer - 1
        Wait(1000)
        if timer == 0 then
            DetonateVehicle(veh)
            armedVeh = nil
        end
    end
end

function DetonateVehicle(veh)
    local vCoords = GetEntityCoords(veh)
    if DoesEntityExist(veh) then
        armedVeh = nil
        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 50.0, true, false, true)
    end
end
