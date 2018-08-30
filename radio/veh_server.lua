addEvent("onVehicleRadioSwitch", true)
addEventHandler("onVehicleRadioSwitch", getRootElement(),function(lol) triggerClientEvent(source, "onVehicleRadioSwitchBack", source, lol) end)
