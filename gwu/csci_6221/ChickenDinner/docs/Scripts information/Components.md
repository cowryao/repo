# Components
In don't starve every entity have different components, these component together consists of the feature of a character. For instance, a character(aka entity) would have health, hunger and brain (aka components). Functions in a components can control value of components. So here listed some components and it's function to help you use it. 

To use components in don't starve scripts, use inst.components.<b>(component you need)</b>:<b>(function of the component) </b>

## Health
### function
StartRegen(amount, period, interruptcurrentregen)  //start regenerate health
StopRegen() //stop regenerate health
SetMaxHealth(amount) // set max health 
SetAbsorbAmount(amount) // set absorb amount(game crush when use this funciton)
GetPercent()
GetMaxHealth()
Kill()
### event
death  //self notice death
entity_death //notice world this entity dead
stopfiredamage
firedamage
startfiredamage
respawn   // on respaen
healthdelta   //health is changing

## Hunger