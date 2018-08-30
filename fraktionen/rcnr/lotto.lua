local Objekt = createObject(1286, 256.31210327148, -53.039894104004, 1.5703125)
setElementData(Objekt, "LOTTOAUTOMAT", true)
function check_lotto_click_func( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
        if (getElementType(source) == "object") then
			if(getElementData(source, "LOTTOAUTOMAT") ~= true) then return end
			if(source ~= Objekt) then return end
			if(tonumber(getElementData(thePlayer, "Clicked")) == 1) then return end
			local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
			triggerClientEvent(thePlayer, "onLottoClicksys", thePlayer, source)
			setElementData(thePlayer, "Clicked", 1)
			
		end
	end
end	
		
addEventHandler( "onElementClicked", getRootElement(), check_lotto_click_func ) 