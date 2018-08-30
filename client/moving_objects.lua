
addEvent("getObjectGroundPosition", true)
addEventHandler("getObjectGroundPosition", getRootElement(),
function(element)
	local x, y, z = getElementPosition(element)
	local Z = getGroundPosition(x, y, z)
	triggerServerEvent("getObjectGroundPositionBack", gMe, element, Z)
end)
local showing = true
addCommandHandler("objekticons",
function()
	showing = not showing
	local kacke
	if(showing == true) then kacke = "angezeigt" else kacke = "nicht mehr angezeigt" end
	outputChatBox("Die Icons von Objekten werden nun "..kacke..".", 0, 200, 255)
end)

local scX, scY = guiGetScreenSize();
local l_w      = 32;
local l_h      = 32;
local l_ratio  = l_w / l_h;
local lscale_w = 1920 / scX;
l_w            = l_w / lscale_w;
l_h            = l_w / l_ratio;



addEventHandler( 'onClientRender', root, function()
if(showing == false) then return end
  for i, v in ipairs( getElementsByType( 'object', getResourceRootElement(), true ) ) do
    if getElementData( v, "O_MOVEABLE" ) == true or getElementData( v, "O_PICKUPABLE") == true then
      local x, y, z = getElementPosition( v );
      local cx, cy, cz = getCameraMatrix();
      if isLineOfSightClear( cx, cy, cz, x, y, z, true, false, false, false, false, false, false, v ) then
        local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
        if dist >= 5 and dist <= 35 then
          local px, py = getScreenFromWorldPosition( x, y, z, 0.06 );
          if px then
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h, 'data/images/dyncursor.png', 0, 0, 0 )

			  
			end
        end
      end
	 end
	 if getElementData( v, "SAMMELOBJEKT" ) == true then
      local x, y, z = getElementPosition( v );
      local cx, cy, cz = getCameraMatrix();
      if isLineOfSightClear( cx, cy, cz, x, y, z, true, false, false, false, false, false, false, v ) then
        local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );
        if dist >= 5 and dist <= 35 then
          local px, py = getScreenFromWorldPosition( x, y, z, 0.06 );
          if px then
              dxDrawImage( px-l_w/2, py - scY/17, l_w, l_h, 'data/images/trophy.png', 0, 0, 0 )

			  
			end
        end
      end
    end
    end
 
end )

--[[
local colshapes = {}
local candothis = 0
setTimer(function()
	for index, player in pairs(getElementsByType("player")) do
		if(colshapes[player]) then destroyElement(colshapes[player]) end
			local x, y, z = getElementPosition(player)
			colshapes[player] = createColSphere(x, y, z, 1.5)
			attachElements(colshapes[player], player)
			setElementData(colshapes[player], "player", player)
			addEventHandler("onClientColShapeHit", colshapes[player],
			function(hitElement)
				if(hitElement ~= getLocalPlayer()) then return end
				if(candothis == 0) then return end
				local playa = getElementData(source, "player")
				-- Dein Code Trigger Event bla
			end)
		end
end, 5000, 0)


bindKey("x", "down",
function()
	candothis = 1
end)

bindKey("x", "up", 
function()
	candothis = 0
end)
--]]

