ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('hypex:getTwojStarySharedTwojaStaraObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('kp', function(source)
    TriggerServerEvent('nh_kp:serverCheck')
end)


RegisterNetEvent('nh_kp:OpenCharacterCard', function(par)
    OpenCardMenu(par)
end)

OpenCardMenu = function(par)
    print(json.encode(par))
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'card_menu',
        {
            align    = 'center',
            title    = 'Karta Postaci [' .. par['Char_Fullname'] .. ']',
            elements = {
                {label = '[💉] Wytwarzanie Narkotyków [' .. par['LVL_Drug'] ..'] [' .. par['EXP_Drug'] .. '/' .. Config.ExpReq[par.LVL_Drug] .. 'xp]',  value = 'drugs'},
                {label = '[💉] Handlarz Bronią [' .. par['LVL_Handlarz'] ..'] [' .. par['EXP_Handlarz'] .. '/' .. Config.ExpReq[par.LVL_Handlarz] .. 'xp]',  value = 'handlarz'},
            }
        },
        function(data, menu)
            TriggerServerEvent('nh_kp:LevelUP', data.current.value)
        end,
        function(data, menu)
            menu.close()
        end
    )
end