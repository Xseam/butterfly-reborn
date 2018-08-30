ambientTable = {} 

for a = 1, 6, 1 do
ambientTable[a] = {}
end

ambientTable[1]["x"], ambientTable[1]["y"], ambientTable[1]["z"] = 1764.1175537109, -344.70550537109, 46.090362548828
ambientTable[2]["x"], ambientTable[2]["y"], ambientTable[2]["z"] = 1764.1175537109, -344.70550537109, 46.090362548828
ambientTable[3]["x"], ambientTable[3]["y"], ambientTable[3]["z"] = 873.76574707031, -16.981485366821, 63.0953125
ambientTable[4]["x"], ambientTable[4]["y"], ambientTable[4]["z"] = 1377.6494140625, 314.41830444336, 19.5546875
ambientTable[5]["x"], ambientTable[5]["y"], ambientTable[5]["z"] = 1044.3605957031, -303.35726928711, 73.09308013916
ambientTable[6]["x"], ambientTable[6]["y"], ambientTable[6]["z"] = 807.94940185547, -626.39471435547, 25.476650238037


local aSound = {}

addEventHandler("onClientResourceStart", getResourceRootElement(),
function()
local url
	for i = 1, 6, 1  do
		local rand = math.random(0, 3)
		if(rand == 0) then url = "ambient1" elseif(rand == 1) then url = "ambient2" elseif(rand == 2) then url = "ambient3" elseif(rand == 3) then url = "ambient4" end
		aSound[i] = playSound3D("sounds/ambient/"..url..".mp3", ambientTable[i]["x"], ambientTable[i]["y"], ambientTable[i]["z"], true)
		setSoundMaxDistance ( aSound[i], 400 )
		check_for_ambient_zeit()
	end
end)

function check_for_ambient_zeit()
local hour, mins = getTime()
	if(hour < 6) or (hour > 20) then
		for i = 1, 6, 1  do
			setSoundVolume(aSound[i], 0.8)
		end
		--outputChatBox(#aSound)
	else
		for i = 1, 6, 1  do
			setSoundVolume(aSound[i], 0)
		end
		--outputChatBox(#aSound.."1")
	end
end



setTimer(check_for_ambient_zeit, 60000, 0)
--[[
ambientTable = {}

ambientTable[1] = {}
ambientTable[2] = {}
ambientTable[3] = {}
ambientTable[4] = {}
ambientTable[5] = {}
ambientTable[6] = {}

ambientTable[1]["x"] = 1764.1175537109
ambientTable[1]["y"] = -344.70550537109
ambientTable[1]["z"] = 46.090362548828

ambientTable[2]["x"] = 1764.1175537109
ambientTable[2]["y"] = -344.70550537109
ambientTable[2]["z"] = 46.090362548828


ambientTable[3]["x"] = 873.76574707031
ambientTable[3]["y"] = -16.981485366821
ambientTable[3]["z"] = 63.0953125


ambientTable[4]["x"] = 1377.6494140625
ambientTable[4]["y"] = 314.41830444336
ambientTable[4]["z"] = 19.5546875

ambientTable[5]["x"] = 1044.3605957031
ambientTable[5]["y"] = -303.35726928711
ambientTable[5]["z"] = 73.09308013916

ambientTable[6]["x"] = 807.94940185547
ambientTable[6]["y"] = -626.39471435547
ambientTable[6]["z"] = 25.476650238037

local aSound = {}

addEventHandler("onClientResourceStart", getResourceRootElement(),
function()
	local shit = 0
	for index, i in pairs(ambientTable) do
		shit = shit+1
		local rand = math.random(0, 2)
		local url
		if(rand == 0) then url = "ambient1" elseif(rand == 1) then url = "ambient2" elseif(rand == 2) then url = "ambient3" end
		aSound[shit] = playSound3D("sounds/ambient/"..url..".mp3", ambientTable[shit]["x"], ambientTable[shit]["y"], ambientTable[shit]["z"])
		setSoundMaxDistance ( aSound[shit], 50 )
		check_for_ambient_zeit()
	end
end)

function check_for_ambient_zeit()
local hour, mins = 21, 21--getTime()
	if(hour < 6) or (hour > 20) then
		for index, i in pairs(aSound) do
			setSoundVolume(aSound[i], 0.8)
		end
	else
		for index, i in pairs(aSound) do
			setSoundVolume(aSound[i], 0)
		end
	end
end



setTimer(check_for_ambient_zeit, 60000, 0)--]]