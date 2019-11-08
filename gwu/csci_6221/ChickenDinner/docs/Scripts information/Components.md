# Components
In don't starve every entity have different components, these component together consists of the feature of a character. For instance, a character(aka entity) would have health, hunger and brain (aka components). 

Functions in a component can control value of the component. So here lists some components and its functions and related event to help you use them. 

To use components' function in don't starve scripts, use inst.components.<b>(component you need)</b>:<b>(function of the component) </b>.  

for instance, 
```lua 
inst.components.health:SetMaxHealth(10)
```

To use components' event in don't starve, use inst:ListenForEvent("<b>your event</b>", <b>your function</b>). 

for instance,
```lua 
local function  on_health_val_change(inst, data)

end

inst:ListenForEvent("healthdelta", on_health_val_change)   
```

## Health
inst.components.health
### function
|function|description|
|---|---|
|StartRegen(amount, period, interruptcurrentregen)  |start regenerate health|
|StopRegen() |stop regenerate health|
|SetMaxHealth(amount) | set max health |
|SetAbsorbAmount(amount) | set absorb amount(game crush when use this funciton)|
|GetPercent()  |get currnet health percent|
|GetMaxHealth() |get max health value|
|Kill()||
### event
|event|description|
|---|---|
|death |self notice death|
|entity_death |notice world this entity dead|
|stopfiredamage|on stop fire damage|
|firedamage|on fire damage happening|
|startfiredamage|on fire damage start|
|respawn   | on re-spawn|
|healthdelta   |when health is changing|

## Hunger
inst.components.hunger
### function 
|function|description|
|---|---|
|IsStarving()   |judge if is starving, if is starving then begin hurt character|
|Pause()  |pause hunger|
|Resume()   |resume decline hunger value|
|SetKillRate(rate)  |set hunger hurt rate, this will cut character health|
|SetRate(rate)  |set hunger rate, this decide how hunger value decline|
|SetMax(amount) | Set hunger max val|
|SetPercent()| Set hunger value by percent|
|GetPercent()| get currnet hunger percent|

### event
|event|description|
|---|---|
|hungerdelta | on hunger value change|
|startstarving | on hunger value less than 0, and begin starving (hurt character)|
|stopstarving |on hunger value more than 0, and stop starving (hurt character)|

## Sanity
inst.component.sanity
### function
|function|description|
|---|---|
|IsSane() | is character sane|
|IsCrazy() |is character Crazy|
|SetPercent(per)| set san value by percent|
|SetMax(amount)| set max san value|
|GetPenaltyPercent()| get penalty percent|
|GetMaxSanity() |get max san value|
|GetPercent(usepenalty)|get current san percent, consider penalty or not (usepenalty is bool value) |

### event
|event|description|
|---|---|
|sanitydelta| on san value changing|
|goinsane| on character went crazy|
|gosane| on character went sane|

