local candothis = 0

local warsound
local airplane
local col1 = createColSphere(-4.1747364997864, 1484.6151123047, 12.75, 3)
local col2 = createColSphere(-5.9961380958557, 1507.5778808594, 13.40461063385, 3)
local col3 = createColSphere(37.047073364258, 1466.8846435547, 14.637702941895, 3)
local endcol = createColSphere(86.141296386719, 1421.7982177734, 10.915714263916, 23)
local randPos = {
	[1] = "6.1049556732178, 1514.5559082031, 12.756023406982",
	[2] = "9.3679780960083, 1540.1910400391, 12.75",
	[3] = "36.921089172363, 1552.0897216797, 12.75",
	[4] = "45.727367401123, 1534.4305419922, 12.75",
	[5] = "2.0713794231415, 1512.7174072266, 12.756023406982",
	[6] = "-13.652574539185, 1489.5782470703, 12.75",
	[7] = "19.70036315918, 1492.7926025391, 12.75",
	[8] = "41.959232330322, 1496.1224365234, 12.75",
	[9] = "47.100608825684, 1515.5400390625, 12.75"
}
--[[
function intro_start_airplane()
	airplane = createVehicle(592, 108.07690429688, 1465.8385009766, 62.871967315674)
	setElementDimension(airplane, 1)
	setElementRotation(airplane, 359.9462890625, 0.0098876953125, -120.70556640625)
	setTimer(setElementVelocity, 1000, 1, airplane, 0, -1, 0)
	setTimer(destroyElement, 10000, 1, airplane)
	setElementFrozen(airplane, false)
end
--]]
local ped
local ped2
local font = guiCreateFont("data/impact.ttf", 15)
local label
function intro_func_normal2()
	label = guiCreateLabel(0.4635,0.3889,0.3646,0.1972,"Eine Woche spaeter...",true)
	guiSetFont(label, font)
	setTimer(intro_func_normal1, 5000, 1)
end
	
function intro_func_normal1()
	guiSetVisible(label, false)
	fadeCamera(true)
	smoothMoveCamera ( 232.7043762207, 28.128978729248, 2.4296875, 232.73434448242, 7.0488834381104, 2.4296875, 242.7536315918, -24.518636703491, 4.578125, 273.99853515625, -22.493202209473, 3.604840755463, 4000 )
	setTimer(
		function()
		fadeCamera(false)
		setElementData(gMe, "doingIntro", true)
		triggerServerEvent("onIntroFertig2", gMe)
	end, 5000, 1)
end

function intro_func_helper_done()
	fadeCamera(false)
	setTimer(destroyElement, 1000, 1, ped)
	setTimer(destroyElement, 1000, 1, ped2)
	setTimer(intro_func_normal2, 2000, 1)
end
function intro_func_helper()
	fadeCamera(true)
	ped = createPed(287, 82.819618225098, 1448.4969482422, 11.016447067261)
	ped2 = createPed(287, 80.77628326416, 1451.7037353516, 11.056635856628)
	setElementDimension(ped2, 1)
	setElementDimension(ped, 1)
	setPedRotation(ped, 299)
	setPedRotation(ped2, 162)
	setPedControlState(ped, "crouch", true)
	setPedControlState(ped2, "sprint", true)
	local x, y, z = getElementPosition(ped)
	setCameraMatrix(84.467422485352, 1449.4232177734, 9.992832183838, x, y, z)
	setTimer(intro_func_helper_done, 3000, 1)
	stopSound(warsound)
end
function intro_func_done()
	createExplosion(87.547355651855, 1415.4625244141, 10.871955871582, 7, true, -1.0, false)
	setElementHealth(gMe, 0)

	setTimer(
		function()
		candothis = 0
		fadeCamera(false)
		end, 5000, 1)
	triggerServerEvent("onPlayerIntroDone", gMe)
	setTimer(intro_func_helper, 6000, 1)
end

function intro_func_bomb()
	local rand = math.random(1, #randPos)
	local x, y, z = tonumber(gettok(randPos[rand], 1, ",")), tonumber(gettok(randPos[rand], 2, ",")), tonumber(gettok(randPos[rand], 3, ","))+10
	createProjectile(gMe, 21, x, y, z, 1, nil, 0, 0, 0, 0, 0, -0.5)
	local rand = math.random(1, 2)
	setTimer(playSound3D, 3000, 1, "sounds/war/explo"..rand..".mp3", x, y, z)
end
addEventHandler("onClientColShapeHit", endcol,
function(hitElement, dim)
	if(dim ~= false) then return end
	if(hitElement ~= gMe) then return end
	destroyElement(endcol)
	local sound = playSound("sounds/war/rocket.mp3",false)
	setSoundMaxDistance(sound, 300)
	setTimer(intro_func_done, 1600, 1)
	candothis = 1
	setSoundVolume(sound, 1)
end)

addEventHandler("onClientColShapeHit", col3,
function(hitElement, dim)
	if(dim ~= false) then return end
	if(hitElement ~= gMe) then return end
	destroyElement(col3)
	createExplosion(74.183082580566, 1467.6145019531, 12.338369369507, 7, true, -1.0, false)
end)

addEventHandler("onClientColShapeHit", col1,
function(hitElement, dim)
	if(dim ~= false) then return end
	if(hitElement ~= gMe) then return end
	destroyElement(col1)
	createExplosion(20.401487350464, 1482.8930664063, 12.75, 1, true, -1.0, false)
end)

addEventHandler("onClientColShapeHit", col2,
function(hitElement, dim)
	if(dim ~= false) then return end
	if(hitElement ~= gMe) then return end
	destroyElement(col2)
	createExplosion(-5.6155476570129, 1528.9896240234, 12.75, 1, true, -1.0, false)
end)

addEventHandler("onClientPedDamage", gMe,
function()
	if(getElementData(gMe, "inIntro") == true) then cancelEvent() end
end)

function intro_func_start()
	fadeCamera(true)
	warsound = playSound3D("sounds/war/war1.mp3", -7.9856119155884, 1523.6502685547, 13.893202781677, true)
	setSoundMaxDistance(warsound, 500)
	setSoundVolume(warsound, 1)
	setElementDimension(warsound, 1)
	intro_func_bomb()
	setTimer(intro_func_bomb, 3500, 30)
	outputChatBox("Soldat, du musst hier umbedingt raus! Finde einen Ausgang nach draussen, auf der Rechten Seite!", 0, 200, 0, false)
end


addEvent("startPlayerIntro", true)
addEventHandler("startPlayerIntro", getRootElement(),
function()
	fadeCamera(false)
	setWeather(39)
	setTime(6, 0)
	setTimer(intro_func_start, 1200, 1)
	triggerServerEvent("onPlayerIntroStart", gMe)
end)

addEvent("onPlayerIntroPedWeapon", true)
addEventHandler("onPlayerIntroPedWeapon", getRootElement(),
function(ped1, ped2, ped3, ped4, ped5, ped6, ped7, ped8)
	--setPedControlState(ped1, "fire", true)
	setPedControlState(ped2, "crouch", true)
	setPedControlState(ped3, "fire", true)
	setPedControlState(ped4, "fire", true)
	setPedControlState(ped5, "fire", true)
	setPedControlState(ped6, "fire", true)
	setPedControlState(ped7, "fire", true)
	setPedControlState(ped8, "fire", true)
	setPedControlState(ped8, "aim_weapon", true)
	setPedControlState(ped7, "aim_weapon", true)
	setPedControlState(ped6, "aim_weapon", true)
	setPedControlState(ped5, "aim_weapon", true)
	setPedControlState(ped4, "aim_weapon", true)
	setPedControlState(ped3, "aim_weapon", true)
	--setPedControlState(ped2, "aim_weapon", true)
	--setPedControlState(ped1, "aim_weapon", true)
end)


local sx, sy = guiGetScreenSize()
local interface_d_k = {}
local images = {}

local effectStates = {cl=1,sxx,syy,state=false}

function d_k_render()
	
		if candothis == 1 then
			if effectStates.cl > 0.1 then
			 effectStates.cl = effectStates.cl - 0.01
			end
		 dxUpdateScreenSource(d_k_screen)
		 dxDrawImage(0,0,sx,sy,interface_d_k.shader)
		 effectStates.realState = true
		elseif effectStates.realState then
			if effectStates.cl < 1 then
			 effectStates.cl = effectStates.cl + 0.01
			else
			 effectStates.realState = false
			end
		 dxUpdateScreenSource(d_k_screen)
		 dxDrawImage(0,0,sx,sy,interface_d_k.shader)
		end
	local tick = getTickCount()
	dxSetShaderValue(interface_d_k.shader,'pX',1/sx*math.random(0,10)/12*(1/effectStates.cl)+sx*tick%30/10)
	dxSetShaderValue(interface_d_k.shader,'pY',1/sy*math.random(0,10)/12*(1/effectStates.cl)+sy*tick%30/10)
	--dxSetShaderValue(interface_d_k.shader,'cr',effectStates.cl)
	dxSetShaderValue(interface_d_k.shader,'cb',effectStates.cl)
	dxSetShaderValue(interface_d_k.shader,'cg',effectStates.cl)

	
end

addEventHandler('onClientResourceStart',resourceRoot,function()
	interface_d_k.shader = dxCreateShader('client/choke/shad.fx')
	d_k_screen = dxCreateScreenSource(sx,sy)
	dxUpdateScreenSource(d_k_screen)
	dxSetShaderValue(interface_d_k.shader,'screenSource',d_k_screen)
	dxSetShaderValue(interface_d_k.shader,'cr',1)
	dxSetShaderValue(interface_d_k.shader,'cg',1)
	dxSetShaderValue(interface_d_k.shader,'cb',1)
	dxSetShaderValue(interface_d_k.shader,'pX',1/sx)
	dxSetShaderValue(interface_d_k.shader,'pY',1/sy)
	addEventHandler('onClientHUDRender',root,d_k_render)
end)