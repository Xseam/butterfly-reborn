--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		local file, settings
		if not(fileExists("shaders.txt")) then fileCreate("shaders.txt") end
		file = fileOpen("shaders.txt")
		local settings = fileRead(file, 50)
		local set1 = gettok(settings, 3, "|")
		if not(set1) then 
			fileWrite(file, "|0|0|0|")
			fileFlush(file)
		else
			if(tonumber(set1) == 1) then
				enableContrast()
			else
				
			end
		end
		fileClose(file)
	end
)

--------------------------------
-- Command handler
--		Toggle via command
--------------------------------

--------------------------------
-- Switch effect on or off
--------------------------------
function switchContrast( bOn )
	if bOn then
		enableContrast()
	else
		disableContrast()
	end
end
addEvent( "switchContrast", true )
addEventHandler( "switchContrast", resourceRoot, switchContrast )



