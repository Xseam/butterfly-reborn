addEvent("onNewsReporterInterviewEinlad", true)
addEventHandler("onNewsReporterInterviewEinlad", getRootElement(),
function(player)
if not(player) then return end	
		if(getElementData(player, "LIVEM") == true) then outputChatBox("Du kannst kein Interviewmaster vom Gespraech entfernen!", source, 255, 0, 0, false) return end
	if(getElementData(player, "LIVE") == true) then
		setElementData(player, "LIVE", false)
		outputChatBox("Der Interviewmaster hat dich aus dem Gespraech geworfen.", player, 0, 200, 0, false)
		outputChatBox("Du hast "..getPlayerName(player).." Aus dem Gespraech geworfen.", source, 0, 200, 0, false)
	elseif(getElementData(player, "LIVE") == false) or (getElementData(player, "LIVE") == nil) then
		setElementData(player, "LIVE", true)
		outputChatBox("Du bist nun in einem Gespraech mit "..getPlayerName(source)..". Nutze /end um aus dem Gespraech zu kommen.", player, 0, 255, 0, false)
		outputChatBox("Du bist nun mit "..getPlayerName(player).." in einem Gespraech/hast ihn eingeladen.", source, 0, 255, 0, false)
	end
end)

addEvent("onNewsChatPost", true)
addEventHandler("onNewsChatPost", getRootElement(),
function(text) executeCommandHandler("news", source, text) end)

addEvent("onFraktionsNewsChatPost", true)
addEventHandler("onFraktionsNewsChatPost", getRootElement(),
function(text) executeCommandHandler("t", source, text) end)

local kVar = {}

addEvent("onFraktionsNewsKameraAnforder", true)
addEventHandler("onFraktionsNewsKameraAnforder", getRootElement(),
function()
	if(getPlayerFraktion(source) ~= 5) then return end
	if(kVar[source] == 1) then outputChatBox("Bitte warte eine Minute.", source, 255, 0, 0, false) return end
	outputChatBox("Lieferung erfolgt!", source, 0, 200, 0, false)
	kVar[source] = 1
	local playa = source
	setTimer(function() kVar[playa] = 0 end, 60000, 1)
	local x, y, z = getElementPosition(source)
	local fallschirm = createObject ( 2903, x, y, z+6.3+15 )
	moveObject ( fallschirm, 9000, x, y, z+6.3 )
	setTimer ( destroyElement, 10000, 1, fallschirm )
	setTimer(
	function()
	local karton = createObject ( 2912, x, y, z-0.5)
		addEventHandler( "onElementClicked",karton, 
		function(mouse, button, thePlayer)	
			if(mouse == "left") and (button == "down") then
				if(getPlayerFraktion(thePlayer) ~= 5) then return end
				destroyElement(karton)
				giveWeapon(thePlayer, 43, 100, true)
				outputChatBox("Lieferung erhalten!", thePlayer, 0, 200, 0, false)
			end
		end) 
	end, 10000, 1)
end
)