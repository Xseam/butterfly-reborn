
local zonen = {
	[1] = "257.48291015625, -25.070278167725, 1.6449398994446, 30", -- Noobspawn
	[2] = "300.65679931641, -180.38478088379, 1.5284695625305, 30", -- Burger shot
	[3] = "2312.3706054688, -8.5026912689209, 26.7421875, 20", -- Bank
	[4] = "1211.0595703125, 153.95729064941, 26.028469085693, 30", -- Autohaus
}

local cols = {}
local hit = false

for i = 1, #zonen, 1 do
	local x, y, z, radius = tonumber(gettok(zonen[i], 1, ",")), tonumber(gettok(zonen[i], 2, ",")), tonumber(gettok(zonen[i], 3, ",")), tonumber(gettok(zonen[i], 4, ","))
	cols[i] = createColSphere(x, y, z, radius)

end

addEventHandler("onClientRender", getRootElement(),
function()
	local var = 0
	for i = 1, #zonen, 1 do
		if(isElementWithinColShape(gMe, cols[i]) == true) and (getPlayerFraktion(gMe) == 0) then
			var = 1
		end
	end
	if(var == 1) then
	local x, y = guiGetScreenSize()
		dxDrawText ( "Ruhige Zone.", 44, y - 41, x, y, tocolor ( 0, 200, 0, 255 ), 1.52, "default-bold" )
		toggleControl("fire", false)
	else
		toggleControl("fire", true)
	end
end)

