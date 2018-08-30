--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]

setTimer(
function()
	local players = getElementsByType ( "player" )
	for key, index in pairs ( players ) do
		setPlayerNametagShowing ( index, false )
	end
end, 1000, 0)

addEventHandler ( "onClientPlayerJoin", getRootElement(),
	function ()
		setPlayerNametagShowing ( source, false )
	end
)



function getNearbyPlayers()
	local nPlayers = 0
	for index, player in pairs(getElementsByType("player")) do
		local x, y, z = getElementPosition(gMe)
		local x1, y1, z1 = getElementPosition(player)
		if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) < 20) then
			nPlayers = nPlayers+1
		end
		
	end
	return nPlayers;
end

local x, y = guiGetScreenSize()

function nameTagRender ()
	local x, y, z, x1, y1, z1, sx, sy, sx2, sy2, sx3, sy3, sx4, sy4, sx5, sy5
	local name, status, fraktion, fraktionnr
	local r, g, b, armor, fr, fg, fb
	local images, drawn
	for index, key in pairs ( getElementsByType("player") ) do
		if(key ~= gMe) then
			x, y, z = getElementPosition(key)
			if(x) and (y) and (z) then
				x1, y1, z1 = getElementPosition(gMe)
				local distance = getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
				if(distance < 20) then
					sx, sy = getScreenFromWorldPosition ( x, y, z + 1.2, 800, true )
					sx5, sy5 = getScreenFromWorldPosition ( x, y, z + 1.5, 1200, true )
					sx4, sy4 = getScreenFromWorldPosition ( x, y, z + 1.2, 800, true )
					sx2, sy2 = getScreenFromWorldPosition ( x, y, z + 1.0, 1200, true )
					sx3, sy3 = getScreenFromWorldPosition ( x, y, z + 1.25, 800, true )
					
					if sx and sy and sx5 and sy5 and sx4 and sy4 and sx3 and sy3 and sx2 and sy2 then
						local bilder, seite = 0, 0
						sx = (sx-x/13/2+distance/2)
						sy = (sy+y/27.2-distance/3)
						sx5 = (sx5-x/13/2+distance/2)
						sy5 = (sy5+y/27.2-distance/3)
						sx4 = (sx4-x/13/2+distance/2)
						sy4 = (sy4+y/27.2-distance/3)
						sx3 = (sx3-x/13/2+distance/2)
						sy3 = (sy3+y/27.2-distance/3)
						sx2 = (sx2-x/13/2+distance/2)
						sy2 = (sy2+y/27.2-distance/3)
						name = getPlayerName(key)
						if not(name) then name = "N/A" end
						status = getElementData(key, "pStatus")
						fraktionnr = tonumber(getElementData(key, "pFraktion"))
						if(fraktionnr == nil) then fraktion = "Zivilist" else
						fraktion = fraktionNamen[fraktionnr]
						if(fraktion == nil) then fraktion = "Unknow" end
						end
						if(status == nil) or not(status) then status = "Status: N/A" end
						if(fraktionnr == 0) then fr, fg, fb = 255, 255, 200
						elseif(fraktionnr == 1) then fr, fg, fb = 200, 0, 255
						elseif(fraktionnr == 2) then fr, fg, fb = 255, 0, 0						
						elseif(fraktionnr == 3) then fr, fg, fb = 255, 255, 0
						elseif(fraktionnr == 4) then fr, fg, fb = 0, 255, 0
						elseif(fraktionnr == 5) then fr, fg, fb = 0, 255, 200
						elseif(fraktionnr == 6) then fr, fg, fb = 200, 50, 0
						else fr, fg, fb = 255, 255, 255 end
						local add = 20
						
						if(distance < 10) then
						-- Fraktion
						--dxDrawText ( "Fraktion: "..fraktion, sx2 + 2, sy2 + 2, sx2, sy2, tocolor ( 0, 0, 0, 255 ), 0.6, Font2, "center", "center" )
						--dxDrawText ( "Fraktion: "..fraktion, sx2, sy2, sx2, sy2, tocolor ( fr, fg, fb, 255 ), 0.6, Font2, "center", "center" )
						-- Bilder --
						
						if(getElementData(key, "idle") == true) then
							seite = seite+add
							bilder = bilder+1
							dxDrawImage ( sx5, sy5-(seite*(bilder/2)) + ((seite/add)*bilder), 30, 30, "data/images/idle.png" )
							
						end
						if(getElementData(key, "writing") == true) then
							seite = seite+add
							bilder = bilder+1
							dxDrawImage ( sx5, sy5-(seite*(bilder/2)) + ((seite/add)*bilder), 30, 30, "data/images/writing.png" )
						end
						-- Status
						dxDrawText ( status, sx2 + 2, sy2 + 2, sx2, sy2, tocolor ( 0, 0, 0, 255 ), 0.6, Font2, "center", "center" )
						dxDrawText ( status, sx2, sy2, sx2, sy2, tocolor ( 255, 255, 255, 255 ), 0.6, Font2, "center", "center" )
						end
						-- Name
						if(getPedArmor(key) > 0) then r, g, b = 200, 200, 200 else r, g, b = 255, 255, 255 end
						dxDrawText ( name, sx, sy, sx, sy, tocolor ( 0, 0, 0, 255 ), 0.8, Font2, "center", "center" )
						dxDrawText ( name, sx- 4, sy - 4, sx, sy, tocolor ( fr, fg, fb, 255 ), 0.8, Font2, "center", "center" )	
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), nameTagRender )


Font = dxCreateFont( "data/nFont.ttf", 20 )   
Font2 = dxCreateFont( "data/agency.ttf", 22 )   
