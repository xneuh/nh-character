ESX = nil
TriggerEvent('hypex:getTwojStarySharedTwojaStaraObject', function(obj) ESX = obj end)

RegisterServerEvent('nh_kp:serverCheck', function()
    local src = source 
    local data = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT * FROM user_skills WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier
    }, function(res)
        if(res[1]) then 
            par = {
                ['Char_Fullname'] = data.character.firstname .. ' ' .. data.character.lastname,
                ['LVL_Drug'] = res[1].drugslvl,
                ['EXP_Drug'] = res[1].drugsexp,
                ['LVL_Handlarz'] = res[1].handlarzlvl,
                ['EXP_Handlarz'] = res[1].handlarzexp,
                ['LVL_Napady'] = res[1].napadylvl,
                ['EXP_Napady'] = res[1].napadyexp
            }
            TriggerClientEvent('nh_kp:OpenCharacterCard', src, par)
        else
            MySQL.Async.execute('INSERT INTO user_skills VALUES (@identifier, 1, 0, 1, 0, 1, 0)', {
                ['@identifier'] = data.identifier
            }, function(res)
                data.showNotification('~b~Pomyślnie Utworzono Karte Postaci ~r~[' .. data.character.firstname .. ' ' .. data.character.lastname .. ']')
            end)
        end
    end)
end)

RegisterServerEvent('nh_kp:giveEXP', function(_type, x, y)
    local src = source 
    local data = ESX.GetPlayerFromId(src)
    if(x) then 
        chance = 1
    else
        chance = math.random(1,10)
    end

    if(y) then 
        expCount = y
    else
        expCount = 1
    end
    skillType = _type .. 'exp'
    _skillType = _type .. 'lvl'
    MySQL.Async.fetchAll('SELECT * FROM user_skills WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier
    }, function(res)
        if(res[1][skillType] == Config.ExpReq[res[1][_skillType]]) then 
            data.showNotification('~b~Posiadasz Dostępny LVL-UP ~r~[' .. Config.TypeNames[_type] .. ']')
        end

        if(chance == 1) then 
            MySQL.Async.execute('UPDATE user_skills SET ' .. skillType .. ' = ' .. skillType .. ' + ' .. expCount, {
            }, function()
                data.showNotification('~b~Pozyskano ~r~[1XP]~b~ Umiejętność ~r~[' .. Config.TypeNames[_type] .. ']')
            end)
        end
    end)
end)

RegisterServerEvent('nh_kp:LevelUP', function(skill)
    local src = source 
    local data = ESX.GetPlayerFromId(src)
    skillType = skill .. 'lvl'
    _skillType = skill .. 'exp'

    MySQL.Async.fetchAll('SELECT * FROM user_skills WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier
    }, function(res)
        if(res[1]) then 
            if(res[1][_skillType] >= Config.ExpReq[res[1][skillType]]) then 
                MySQL.Async.execute('UPDATE user_skills SET ' .. _skillType .. ' = ' .. _skillType .. ' - ' .. Config.ExpReq[res[1][skillType]] .. ' WHERE identifier = @identifier', {['@identifier'] = data.identifier})
                MySQL.Async.execute('UPDATE user_skills SET ' .. skillType .. ' = ' .. skillType .. ' + 1 WHERE identifier = @identifier', {['@identifier'] = data.identifier})
                data.showNotification('~b~Pomyslnie Podniesiono Poziom Umiejętności ~r~[' .. Config.TypeNames[skill] .. '] [' .. res[1][skillType] .. ' -> ' .. res[1][skillType] + 1 .. ']')
            end
        end
    end)
end)

ESX.RegisterServerCallback('nh_kp:getLevel', function(source,cb,skill)
    local src = source 
    local data = ESX.GetPlayerFromId(src)

    skillType = skill .. 'lvl'
    print(skillType)
    if(src ~= nil) then
        print(src) 
        MySQL.Async.fetchAll('SELECT * FROM user_skills WHERE identifier = @identifier', {
            ['@identifier'] = data.identifier
        }, function(res)
            if(res[1]) then
                print(res[1][skillType]) 
                cb(res[1][skillType])
            end
        end)
    end
end)