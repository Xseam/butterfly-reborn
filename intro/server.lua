local pedPos = {
	[1] = "-49.477096557617, 1534.5153808594, 12.75, 173",
	[2] = "-25.722051620483, 1511.9028320313, 14.289491653442, 274",
	[3] = "5.1729278564453, 1544.3654785156, 12.756023406982, 286",
	[4] = "2.5921459197998, 1524.3149414063, 12.75, 175",
	[5] = "-9.1312780380249, 1515.8485107422, 14.754943847656, 60",
	[6] = "-43.386966705322, 1526.3023681641, 18.857828140259, 165",
	[7] = "-1.2687528133392, 1551.7456054688, 12.756023406982, 2.3",
	[8] = "37.595684051514, 1468.6909179688, 14.328092575073, 137"
}
local peds = {}

addEvent("onPlayerIntroStart", true)
function build_player_peds()
	local thePlayer = source
	peds[thePlayer] = {}
	for i = 1, #pedPos, 1 do
		local x, y, z, rot = tonumber(gettok(pedPos[i], 1, ",")), tonumber(gettok(pedPos[i], 2, ",")), tonumber(gettok(pedPos[i], 3, ",")), tonumber(gettok(pedPos[i], 4, ","))
		peds[thePlayer][i] = createPed(287, x, y, z)
		setPedRotation(peds[thePlayer][i], rot)
		setElementDimension(peds[thePlayer][i], 1)
		setElementVisibleTo(peds[thePlayer][i], getRootElement(), false)
		setElementVisibleTo(peds[thePlayer][i], thePlayer, true)
		giveWeapon(peds[thePlayer][i], 31, 999999,  true)
		setPedStat(peds[thePlayer][i], 78, 999)
	end
	triggerClientEvent(thePlayer, "onPlayerIntroPedWeapon", thePlayer, peds[thePlayer][1],peds[thePlayer][2],peds[thePlayer][3],peds[thePlayer][4],peds[thePlayer][5],peds[thePlayer][6],peds[thePlayer][7],peds[thePlayer][8])
	setTimer(
		function()
			local airplane = createVehicle(592, -59.262954711914, 1527.3851318359, 70.411575317383)
			setElementDimension(airplane, 1)
			setElementRotation(airplane, 0.0938720703125, 0.13140869140625, 272.63684082031)
			setElementVelocity(airplane, 1, 0, 0)
			setElementVisibleTo(airplane, getRootElement(), false)
			setElementVisibleTo(airplane, thePlayer, true)
			setTimer(destroyElement, 30000, 1, airplane)
		end, 5000, 1)
end
addEventHandler("onPlayerIntroStart", getRootElement(), build_player_peds)
addEvent("onPlayerIntroDone", true)
addEventHandler("onPlayerIntroDone", getRootElement(),
function()
	for i = 1, #pedPos, 1 do
		destroyElement(peds[source][i])
	end

	
end)


addEvent("onIntroFertig2", true)
addEventHandler("onIntroFertig2", getRootElement(),
function()
	spawnPlayer(source, 0, 0, 0) 
	setElementHealth(source, 100) 
	setElementDimension(source, 0)
	setElementData(source, "inIntro", false)
	setElementModel(source, 0)
	triggerEvent("onXPSpawn", source)
	fadeCamera(source, true)
	triggerClientEvent(source, "startWillkommenMenue", source)
end)
