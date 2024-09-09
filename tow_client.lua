-- tow_client.lua
-- County Tow Script for FiveM
-- This script deletes the vehicle you are in when executing the command /tow

RegisterCommand("tow", function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        if (IsPedSittingInAnyVehicle(ped)) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                local vehicleModel = GetEntityModel(vehicle)
                local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)

                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"Tow Service", "County Tow Enroute for vehicle " .. vehicleName}
                })

                Citizen.Wait(20000) -- Wait for 20 seconds

                DeleteVehicle(vehicle)

                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"Tow Service", vehicleName .. " has been towed!"}
                })
            else
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"Tow Service", "You must be in the driver's seat!"}
                })
            end
        else
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                multiline = true,
                args = {"Tow Service", "You must be in a vehicle to tow it."}
            })
        end
    end
end, false)

TriggerEvent("chat:addSuggestion", "/tow", "Tows the vehicle you are in")

function DeleteVehicle(veh)
    SetEntityAsMissionEntity(veh, true, true)
    DeleteEntity(veh)

    if (DoesEntityExist(veh)) then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Tow Service", "Failed to delete vehicle."}
        })
    end
end
