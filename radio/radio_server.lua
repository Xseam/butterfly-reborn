addEvent("onRadioCreate", true)
addEventHandler("onRadioCreate", getRootElement(),
function(x, y, z, rotx, roty, rotz, int, dim)
	outputChatBox("Radio Erstellt! Du kannst es Anklicken, und Bearbeiten.", source, 0, 200, 0)
	local radio = createObject(2103, x, y, z, rotx, roty, rotz)
	setElementInterior(radio, int)
	setElementDimension(radio, dim)
	setElementData(radio, "radio", true)
	setElementData(radio, "radio.owner", getPlayerName(source))
	setElementData(radio, "radio.looped", false)
	addEventHandler("onElementClicked", radio,
	function(button, state,thePlayer)
		if(button == "left") and (state == "down") then
			if(getElementData(thePlayer, "Clicked") == 1) then return end
			if(getElementData(source, "radio.owner") == getPlayerName(thePlayer)) or (getPlayerAdminlevel(thePlayer) > 0) then
				triggerClientEvent(thePlayer, "onPlayerRadioClick", thePlayer, source)
			else
				outputChatBox("Info: Du kannst mit diesem Radio nicht Kontaktieren.", thePlayer, 0, 200, 200)
			end
		end
	end)
end)

addEvent("onRadioURLChange", true)
addEventHandler("onRadioURLChange", getRootElement(),
function(radio, url, looped)
	setElementData(radio, "radio.url", url)
	setElementData(radio, "radio.looped", looped)
	outputChatBox("Radio versucht Stream abzuspielen.", source, 0, 200, 0)
	triggerClientEvent(getRootElement(),"onRadioSoundStart",source, radio)
end)
addEvent("onRadioStop", true)
addEventHandler("onRadioStop", getRootElement(),
function(theRadio)
	outputChatBox("Du hast das Radio gestoppt.", source, 0, 200, 0)
	triggerClientEvent(getRootElement(), "onRadioSoundStop", source, theRadio)
	removeElementData(theRadio, "radio.url")
end)
addEvent("onRadioDestroy", true)
addEventHandler("onRadioRedestroy", getRootElement(),
function(theRadio)
	outputChatBox("Du hast das Radio Entfernt!", source, 0, 200, 0)
	triggerClientEvent(getRootElement(), "onRadioSoundStop", source, theRadio)
	destroyElement(theRadio)
end)
addEvent("onRadioAufheb", true)
addEventHandler("onRadioAufheb", getRootElement(),
function(theRadio)
	setElementData(source, "pRadios", tonumber(getElementData(source, "pRadios"))+1)
	outputChatBox("Du hast das Radio aufgehoben.", source, 0, 200, 0)
	triggerClientEvent(getRootElement(), "onRadioSoundStop", source, theRadio)
	destroyElement(theRadio)
end)