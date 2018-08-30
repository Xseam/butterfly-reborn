addEvent("onShopKaufen", true)
addEventHandler("onShopKaufen", getRootElement(),
function(var)
	if(var == 1) then
		giveWeapon(source, 43, 125, true)
	elseif(var == 2) then
		giveWeapon(source, 44, 1, true)
	end
end)