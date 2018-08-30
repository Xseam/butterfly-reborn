--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]

function bindKeys()
	bindKey("lalt", "up", 
	function()
	if(canDoThis == false) then return end 
	showCursor(false)
	end)
	bindKey("lalt", "down", 
	function()
	if(canDoThis == false) then return end 
	showCursor(true)	
	end)
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	bindKeys()
	end
)

function canDoThis()
	if(getElementData(gMe, "inLogin") == 1) then
			return false;
		else
			return true;
		end
end

