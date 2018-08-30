local Zone = createColSphere(872.47943115234, 89.113647460938, 68.092018127441, 850)

local Blueberry = createRadarArea(137.98602294922, -4.2453947067261, 255, -285, 255, 255, 255, 100)
local Montgomery = createRadarArea(1215.3057861328, 430.8662414550, 255, -285, 255, 255, 255, 100)
local Palomio = createRadarArea(2204.4431152344, -117.6601791381, 370, 370, 255, 255, 255, 100)
local RedCountry = createRadarArea(577.2578125, -618.2448120117, 200, 200, 255, 255, 255, 100)

--[[
addEventHandler ( "onColShapeLeave", Zone,
function( thePlayer )
	if(getElementType(thePlayer) == "player") then
   outputChatBox(getPlayerName(thePlayer).." hat die Zone verlassen.", root, 255, 255, 0, false)
   elseif(getElementType(thePlayer) == "vehicle") then
   outputChatBox(getVehicleName(thePlayer).." hat die Zone verlassen.", root, 255, 255, 0, false)   
   end
end)
--]]