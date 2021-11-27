local QBCore = exports['qb-core']:GetCoreObject()
local timer = 0
local armedVeh
local sleep = true

RegisterNetEvent('qb-carbomb:CheckVehicle', function()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local veh = QBCore.Functions.GetClosestVehicle(pCoords)
    local vCoords = GetEntityCoords(veh)
    local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, vCoords.x, vCoords.y, vCoords.z, true)
    local animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
    local anim = "weed_spraybottle_crouch_base_inspector"

    if not IsPedInAnyVehicle(ped, false) then
        if veh and (dist < 4.0) then
            loadAnimDict(animDict)
            Wait(1000)
            TaskPlayAnim(ped, animDict, anim, 3.0, 1.0, -1, 0, 1, 0, 0, 0)
            QBCore.Functions.Progressbar("carbomb_arming", "Arming Device...", Config.ArmingTime, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
                anim = "weed_spraybottle_crouch_base_inspector"
            }, {}, {}, function()
                ClearPedTasksImmediately(ped)
                TriggerServerEvent('qb-carbomb:RemoveBombFromInv')
                for k,v in pairs(Config.Detonation) do
                    if v.type == 0 then
                        QBCore.Functions.Notify('The device will explode in'..v.detonation..' seconds', 'success')
                        RunTimer(veh)
                    elseif v.type == 1 then
                        QBCore.Functions.Notify('The device will explode when the vehicle reaches '..v.speed..Config.Speed, 'success')
                        armedVeh = veh
                    elseif v.type == 2 then
                        QBCore.Functions.Notify('Detonate the device by pressing [G]', 'success')
                        armedVeh = veh
                    elseif v.type == 3 then
                        QBCore.Functions.Notify('The device will detonate '..v.detonation..' seconds after someone enters the vehicle', 'success')
                        armedVeh = veh
                    else
                        QBCore.Functions.Notify('The device will explode as soon as someone enters the drivers seat', 'success')
                    end
                end
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
        sleep = true
        if armedVeh then
            sleep = false
            for k,v in pairs(Config.Detonation) do
                if v.type == 1 and armedVeh then
                    local speed = GetEntitySpeed(armedVeh)
                    local SpeedKMH = speed * 3.6
                    local SpeedMPH = speed * 2.236936
                    
                    if Config.Speed == 'MPH' then
                        if SpeedMPH >= v.speed then
                            DetonateVehicle(armedVeh)
                        end
                    elseif Config.Speed == 'KPH' then
                        if SpeedKMH >= v.speed then
                            DetonateVehicle(armedVeh)
                        end
                    end
                elseif v.type == 2 and armedVeh then
                    if IsControlJustReleased(0, Config.TriggerKey) then
                        DetonateVehicle(armedVeh)
                    end
                elseif v.type == 3 and armedVeh then
                    if not IsVehicleSeatFree(armedVeh, -1)  then
                        RunTimer(armedVeh, v.detonation)
                    end
                elseif v.type == 4 and armedVeh then
                    if not IsVehicleSeatFree(armedVeh, -1) then
                        DetonateVehicle(armedVeh)
                    end
                end
            end
        end

        if sleep then
            Wait(1000)
        end
    end
end)

function RunTimer(veh, time)
    timer = time
    while timer > 0 do
        timer = timer - 1
        Wait(1000)
        if timer == 0 then
            DetonateVehicle(veh)
        end
    end
end

function DetonateVehicle(veh)
    local vCoords = GetEntityCoords(veh)
    if DoesEntityExist(veh) then
        armedVeh = nil
        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 2, 50.0, true, false, true)
    end
end