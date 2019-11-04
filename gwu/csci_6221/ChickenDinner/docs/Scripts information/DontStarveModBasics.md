# Don’t starve mod Basics
# Source Code Architecture
Source codes are in the don’t starve/data/scripts folder
Including Behaviours, Brains, Cameras, Components, Languages, Map, Nis, Prefabs, Scenarios, Screens, StateGraphs, Widgets, and Main files.

## Prefabs:
Prefabs which can generate in the game listed in the Prefab folder. Such as beefalo

## Components:
components for a game entity such as  player control, health, hunger<br>
Use AddComponent(“filename.lua”) to add a component to an entity<br>
Then visit it by entity.components.filename

## Main Files
### Constant: 
some Keys, Resulations defined in the constants.lua



# Mod Architecture 
## Three main lua code files
modmain.lua <br>
modinfo.lua <br>
modworldgenmain.lua
