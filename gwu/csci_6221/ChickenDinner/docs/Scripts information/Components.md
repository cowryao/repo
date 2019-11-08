# Components
In don't starve every entity have different components, these component together consists of the feature of a character. For instance, a character(aka entity) would have health, hunger and brain (aka components). Functions in a components can control value of components. So here listed some components and it's function to help you use it. 

To use components in don't starve scripts, use inst.components.<b>(component you need)</b>:<b>(function of the component) </b>.  for instance, inst.components.health:SetMaxHealth(10)

## Health
### function
|function|description|
|--------|-----------|
|StartRegen(amount, period, interruptcurrentregen)  |start regenerate health|
|StopRegen() |stop regenerate health|
|SetMaxHealth(amount) | set max health |
|SetAbsorbAmount(amount) | set absorb amount(game crush when use this funciton)|
|GetPercent()  |get currnet health percent|
|GetMaxHealth() |get max health value|

Kill()
### event
|death  |self notice death|
|entity_death |notice world this entity dead|
|stopfiredamage|---|
|firedamage|---|
|startfiredamage|----|
|respawn   | on re-spawn|
|healthdelta   |when health is changing|

## Hunger
### function 
|IsStarving()   |judge if is starving, if is starving then begin hurt character|
|Pause()  |pause hunger|
|Resume()   |resume decline hunger value|
|SetKillRate(rate)  |set hunger hurt rate, this will cut character health|
|SetRate(rate)  |set hunger rate, this decide how hunger value decline|
|SetMax(amount) | Set hunger max val|


