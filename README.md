Character Card with abillity system

Requirments:
<a href="https://github.com/mitlight/es_extended">
  - es_extended  </a>
  - <a href="https://github.com/overextended/oxmysql">oxmysql</a> / <a href="https://github.com/brouznouf/fivem-mysql-async">mysql-async</a>
  
  
Getting Skill Level [Client]
  -- Skill Types - drugs, handlarz
  ESX.TriggerServerCallback('nh_kp:getLevel', function(res)
    local skillLevel = res
  end, 'drugs') -- Replace drugs with your skilltype
