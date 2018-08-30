function gluePlayer(vehicle, x, y, z, rotX, rotY, rotZ)
	if source == client then
		attachElements(source, vehicle, x, y, z, rotX, rotY, rotZ)
		setPedWeaponSlot(source, 0)

	end
end
addEvent("gluePlayer",true)
addEventHandler("gluePlayer",getRootElement(),gluePlayer)

function ungluePlayer()
	if source == client then
		detachElements(source)

	end
end
addEvent("ungluePlayer",true)
addEventHandler("ungluePlayer",getRootElement(),ungluePlayer)