Character Card with abillity system

Requirments:
<a href="https://github.com/mitlight/es_extended">
  - es_extended  </a>
  - <a href="https://github.com/overextended/oxmysql">oxmysql</a> / <a href="https://github.com/brouznouf/fivem-mysql-async">mysql-async</a>
  
  Getting Skill Level [Client]
````
  -- Skill Types - drugs, handlarz
  ESX.TriggerServerCallback('nh_kp:getLevel', function(res)
    local skillLevel = res
  end, 'drugs') -- Replace drugs with your skilltype
````

EXP Giving Trigger
````
TriggerServerEvent("nh_kp:giveEXP", skillname, chance, expCount)
````

SQL Code

````

CREATE TABLE user_skills(
  identifier varchar(50) DEFAULT '' NOT NULL,
  drugslvl int(11) DEFAULT 1 NOT NULL,
  drugsexp int(11) DEFAULT 0 NOT NULL,
  handlarzlvl int(11) DEFAULT 1 NOT NULL,
  handlarzexp int(11) DEFAULT 0 NOT NULL,
  napadylvl int(11) DEFAULT 1 NOT NULL,
  napadyexp int(11) DEFAULT 0 NOT NULL
)
````
