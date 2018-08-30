local maxheight = 2.5
local add = 0.1


local SizeVal = 2998

local southWest_X = -SizeVal
local southWest_Y = -SizeVal
local southEast_X = SizeVal
local southEast_Y = -SizeVal
local northWest_X = -SizeVal
local northWest_Y = SizeVal
local northEast_X = SizeVal
local northEast_Y = SizeVal

wetterNamen = {}
wetterNamen = { 
[0]="Scheiss wedda",
[1]="Bewoelkt",
[2]="Bewoelkt",
[3]="Bewoelkt",
[4]="Bewoelkt",
[5]="Bewoelkt",
[6]="Bewoelkt",
[7]="Bewoelkt",
[8]="Sturm",
[9]="Neblig und Bewoelkt",
[10]="Blauer Himmel",
[11]="Hitzewelle",
[12]="Grau und trist",
[13]="Grau und trist",
[14]="Grau und trist",
[15]="Grau und trist",
[16]="Bewoelkt und verregnet",
[17]="Leichte Hitze",
[18]="Leichte Hitze",
[19]="Sandsturm",
[20]="Neblig und Bewoelkt",
[21]="Dunkler Himmel",
[22]="Dunkler Himmel",
[23]="Sonnig und Warm",
[24]="Sonnig und Warm",
[25]="Sonnig und Warm",
[26]="Sonnig und Warm",
[27]="Bewoelkt",
[28]="Blauer Himmel",
[29]="Blauer Himmel",
[30]="Bewoelkt",
[31]="Bewoelkt",
[32]="Starker Nebel",
[33]="Leichte Hitze",
[34]="Blauer Himmel",
[35]="Grau und Trist",
[36]="Grau und Trist",
[37]="Sonnig und Warm",
[38]="Bewoelkt",
[39]="Bewoelkt",
[40]="Leichte Hitze",
[41]="Leichte Hitze",
[42]="Sandsturm",
[43]="Bewoelkt",
[44]="Schwarzer Himmel",
[45]="Schwarzer Himmel",
[46]="Sonnig",
[47]="Sonnig",
[48]="Sonnig",
[49]="Dunkel"
 }
local abweichungen = {
	[0] = "0.1",
	[1] = "0.2",
	[2] = "0.3",
	[3] = "0.4",
	[4] = "0.5",
	[5] = "0.6",
	[6] = "0.7",
	[7] = "0.8",
	[8] = "0.9"
}
local temperaturen = {
	[0] = "28",
	[1] = "29",
	[2] = "22",
	[3] = "24",
	[4] = "23",
	[5] = "26",
	[6] = "25",
	[7] = "20",
	[8] = "15",
	[9] = "11",
	[10] = "27",
	[11] = "32",
	[12] = "22",
	[13] = "21",
	[14] = "19",
	[15] = "22",
	[16] = "15",
	[17] = "28",
	[18] = "29",
	[19] = "18",
	[20] = "16",
	[21] = "15",
	[22] = "17",
	[23] = "28",
	[24] = "27",
	[25] = "28",
	[26] = "29",
	[27] = "25",
	[28] = "26",
	[29] = "26",
	[30] = "22",
	[31] = "24",
	[32] = "11",
	[33] = "24",
	[34] = "28",
	[35] = "25",
	[36] = "25",
	[37] = "27",
	[38] = "22",
	[39] = "23",
	[40] = "29",
	[41] = "29",
	[42] = "22",
	[43] = "26",
	[44] = "17",
	[45] = "15",
	[46] = "25",
	[47] = "26",
	[48] = "26",
	[49] = "12"
}

local randomWA = math.random(5000, 10000)
local maVar = 5000

--wind = 2

local wetter = 0
local wellenhoehe = 0
local ueberschwemmung = false
local wasser
local curheight = 0
function setWeatherToFluten()
	ueberschwemmung = false
	wasser = createWater ( southWest_X, southWest_Y, maxheight, southEast_X, southEast_Y, maxheight, northWest_X, northWest_Y, maxheight, northEast_X, northEast_Y, maxheight )
	setWaterLevel(wasser, 0)
	setWaterLevel(0)
	curheight = 0
	setTimer( function()
		local height = curheight
		if(height > maxheight) then
			setTimer( function()
				local height = curheight
				if(height < 0.1) then resetWaterLevel() if(isElement(wasser)) then destroyElement(water) end return end
				curheight = curheight-add
				setWaterLevel(curheight)
			end, math.random(10, 20)*1000, 8)
		end
		curheight = curheight+add
		setWaterLevel(curheight)
	end, math.random(10000, 20000), 8)
end
	
function wetterAenderung_func (id)
	setWaveHeight(wellenhoehe)
	setWeather( wetter )
	if not(id) then
		wetter = math.random(0, 49)
	else
		wetter = tonumber(id)
	end
	if(ueberschwemmung == true) then
		setWeatherToFluten()
	end
	
	if(wetter < 8) then
		--wind = math.random(0, 5)
		wellenhoehe = math.random(0, 2)
	end
	if(wetter == 8) then
		--wind = math.random(4, 6)
		wellenhoehe = math.random(1, 6)
	end
	if(wetter > 8) then
		--wind = math.random(0, 6)
		wellenhoehe = math.random(0, 4)
	end

	local hour, mins = getTime()
	if(hour < 20) then else
	local rand = math.random(0, 1)
	if (rand == 0) then
		wetter = math.random(0, 3)
	else
		local rand2 = math.random(0,5)
		if(rand2 == 5) then
			wetter = rand2
		else
			wetter = math.random(0, 3)
		end
	end
	end
	if(wetter == 8) then
		local rand = math.random(0, 10)
		if(rand == 5) and (ueberschwemmung == false) then -- Ueberschwemmung
			ueberschwemmung = true
			wellenhoehe = math.random(3, 7)
		end
	end	
	outputDebugString("Weatherchange zu ID: "..wetter..", Wellenhoehe: "..wellenhoehe..", Temp: "..(tonumber(temperaturen[wetter])+tonumber(abweichungen[math.random(1, #abweichungen)])).."'C", 3, 255, 255, 0)
	outputDebugString("Ueberschwemmung: "..tostring(ueberschwemmung), 3, 255, 255, 0)
	setTimer(function()
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		
		for index, spieler in pairs(getElementsByType("player")) do
			if(getPlayerFraktion(spieler) == 5) then
				outputChatBox("Wetterinfos fuer den "..day.."."..month.."."..year.." um "..hour..":"..minute..":", spieler, 0, 240, 140)
				outputChatBox("In ca. 5 Minuten wird sich das Wetter so veraendert: "..wetterNamen[wetter]..", "..(tonumber(temperaturen[wetter])+tonumber(abweichungen[math.random(1, #abweichungen)])).." 'C und Wellenhoehe von ca. "..wellenhoehe.." Metern!", spieler, 0, 250, 150)
				if(ueberschwemmung == true) then
					outputChatBox("INFO: Eine Sturmfront kommt auf die Staedte zu. Es wird mit Ueberschwemmungen gerechnet!", spieler, 0, 255, 0)
				
				end
			end
		end
	end, 300*maVar+randomWA-(5*60*1000), 1)
end
setTimer ( wetterAenderung_func, 300*maVar+randomWA, 0 )

addCommandHandler("changethiswetter",
function(thePlayer, cmd, id)
local name = getPlayerName(thePlayer)
if not(name == "MuLTi") then return end
wetterAenderung_func(id)
end)