local Marker1 = createMarker(83.952110290527, -149.50239562988, 2.5843658447266, "corona", 1.0, 0, 255, 0, 200) -- Eingangsmarker fuss
local Marker2 = createMarker(105.70580291748, -164.75183105469, 1.999484205246, "cylinder", 3.5, 0, 255, 0, 175) -- Eingangsmarker Auto
local Marker3 = createMarker(65.33081817627, -2126.8132324219, 1.0543750524521, "corona", 1.0, 0, 255, 0, 200) -- Drinne Markeer, Fuss
local Marker4 = createMarker(56.233264923096, -2132.0915527344, 0.76497513055801, "cylinder", 3.5, 0, 255, 0, 175) -- Drinne Marker, Auto
-- Vor dem Marker3: 64.434387207031, -2124.3723144531, 1.0543750524521
-- Vor Marker 1: 86.603591918945, -149.62016296387, 2.5831570625305
local Schranke1 = createObject(968, 111.48999786377, -167.86999511719, 1.5700000333786, 0, 268, 270) --
local Col1 = createColSphere(117.5858001709, -164.3659362793, 1.578125, 8) --
local Tor1auf = false

local rSpawns1 = { -- Rennen
	[1] = "42.414539337158, -2115.2897949219, 0.76350367069244",
	[2] = "37.954399108887, -2115.42578125, 0.76277655363083",
	[3] = "34.724586486816, -2115.3359375, 0.76199167966843",
	[4] = "31.572774887085, -2115.7795410156, 0.76271265745163",
	[5] = "28.66919708252, -2115.609375, 0.76186680793762",
	[6] = "36.216861724854, -2109.150390625, 0.76201784610748",
}
local rSpawns2 = { -- Vor
	[1] = "115.00617218018, -173.10559082031, 1.2832069396973",
	[2] = "115.09352874756, -169.53086853027, 1.2829669713974",
	[3] = "114.4861907959, -166.62442016602, 1.2833914756775",
	[4] = "114.30344390869, -163.7200012207, 1.2840849161148",
	[5] = "114.61765289307, -160.41189575195, 1.2839506864548",
	[6] = "115.93218994141, -157.35966491699, 1.283158659935",
}

addEventHandler("onColShapeHit", Col1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then
		if(Tor1auf == false) then
			Tor1auf = true
			moveObject(Schranke1, 1000, 111.48999786377, -167.86999511719, 1.5700000333786, 0, 92, 0, "InOutQuad")
			setTimer(setElementRotation, 1000, 1, Schranke1, 0, 0, 270)
		end
	end
end)

addEventHandler("onColShapeLeave", Col1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then
		if(Tor1auf == true) then
			if(#getElementsWithinColShape(Col1) > 2) then return end
			Tor1auf = false
			moveObject(Schranke1, 1000, 111.48999786377, -167.86999511719, 1.5700000333786, 0, -92, 0, "InOutQuad")
			setTimer(setElementRotation, 1000, 1, Schranke1, 0, 268, 270)
		end
	end
end)


addEventHandler("onMarkerHit", Marker4, 
function(hitElement)
	if(getElementType(hitElement) ~= "vehicle") then return end
	if(getVehicleOccupant(hitElement)) then
		setElementFrozen(hitElement, true)
		local playa = getVehicleOccupant(hitElement)
		toggleAllControls(playa, false)
		fadeCamera(playa, false)
		setTimer(
			function()
				local randomv = math.random(1, #rSpawns2)
				local rand = rSpawns2[randomv]
				local x1, y1, z1 = tonumber(gettok(rand, 1, ",")), tonumber(gettok(rand, 2, ",")), tonumber(gettok(rand, 3, ","))
				setElementPosition(hitElement, x1, y1, z1)
				local x, y, z = getElementRotation(hitElement)
				setElementRotation(hitElement, 0, 0, 270)
				fadeCamera(playa, true)
					setTimer( function()
					setElementFrozen(hitElement, false)
					end, 500, 1)
				toggleAllControls(playa, true)
				triggerClientEvent(getRootElement(), "onGhostmodeSet", playa, hitElement)
				triggerClientEvent(playa, "setWaterLevel", playa, 0)
			end, 1000, 1)
		
	end	
end)

addEventHandler("onMarkerHit", Marker2, 
function(hitElement)
	if(getElementType(hitElement) ~= "vehicle") then return end
	if(getVehicleOccupant(hitElement)) then
		setElementFrozen(hitElement, true)
		local playa = getVehicleOccupant(hitElement)
		toggleAllControls(playa, false)
		fadeCamera(playa, false)
		setTimer(
			function()
				local randomv = math.random(1, #rSpawns1)
				local rand = rSpawns1[randomv]
				local x1, y1, z1 = tonumber(gettok(rand, 1, ",")), tonumber(gettok(rand, 2, ",")), tonumber(gettok(rand, 3, ","))
				setElementPosition(hitElement, x1, y1, z1)
				local x, y, z = getElementRotation(hitElement)
				setElementRotation(hitElement, 0, 360, 360)
				fadeCamera(playa, true)
					setTimer( function()
					setElementFrozen(hitElement, false)
					end, 500, 1)
				toggleAllControls(playa, true)
				triggerClientEvent(getRootElement(), "onGhostmodeSet", playa, hitElement)
				triggerClientEvent(playa, "setWaterLevel", playa, -1)
			end, 1000, 1)
		
	end	
end)

addEventHandler("onMarkerHit", Marker3, 
function(hitElement)
	if(getElementType(hitElement) ~= "player") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 86.603591918945, -149.62016296387, 2.5831570625305, 0)
end)

addEventHandler("onMarkerHit", Marker1, 
function(hitElement)
	if(getElementType(hitElement) ~= "player") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 64.434387207031, -2124.3723144531, 1.0543750524521, 0)
end)