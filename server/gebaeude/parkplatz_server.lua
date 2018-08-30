local Schranke1 = createObject(968, 193.58000183105, -323.19000244141, 1.5700000524521, 0, 268, 270) -- Zu Dillimore hin, Rotation auf: 0, 0, 270
local Col1 = createColSphere(194.08476257324, -319.99905395508, 1.5723714828491, 9) -- zu Schranke 1
local Schranke2 = createObject(968, 80.040000915527, -220.9700012207,  1.5800000429153, 0, 92, 179.5) -- Zu Yakuzabase hin, Rotation auf: 0, 0, 179.5
local Col2 = createColSphere(76.542495727539, -221.6683807373, 1.578125, 9) -- Zu Schranke 2
local Tor1auf = false
local Tor2auf = false

addEventHandler("onColShapeHit", Col1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then
		if(Tor1auf == false) then
			Tor1auf = true
			moveObject(Schranke1, 1000, 193.58000183105, -323.19000244141, 1.5700000524521, 0, 92, 0, "InOutQuad")
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
			moveObject(Schranke1, 1000, 193.58000183105, -323.19000244141, 1.5700000524521, 0, -92, 0, "InOutQuad")
			setTimer(setElementRotation, 1000, 1, Schranke1, 0, 268, 270)
		end
	end
end)

addEventHandler("onColShapeHit", Col2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then
		if(Tor2auf == false) then
			Tor2auf = true
			moveObject(Schranke2, 1000, 80.040000915527, -220.9700012207,  1.5800000429153, 0, -92, 0, "InOutQuad")
			setTimer(setElementRotation, 1000, 1, Schranke2, 0, 0, 179.5)
		end
	end
end)

addEventHandler("onColShapeLeave", Col2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then
		if(Tor2auf == true) then
			if(#getElementsWithinColShape(Col2) > 2) then return end
			Tor2auf = false
			moveObject(Schranke2, 1000, 80.040000915527, -220.9700012207,  1.5800000429153, 0, 92,0, "InOutQuad")
			setTimer(setElementRotation, 1000, 1, Schranke2, 0, 92, 179.5)
		end
	end
end)
