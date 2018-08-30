local fernseherSpawns = { -- ID: 1748
	[1] = "259.3896484375, -22.6298828125, 3.4800000190735, 0, 0, 39",
	[2] = "244.19000244141, -57.330001831055, 0.5799999833107, 0, 0, 39",
	[3] = "122.44999694824, -146.89999389648, 2.5799999237061, 0, 0, 39",
	[4] = "249.64999389648, -191.05000305176, 0.5799999833107, 0, 0, 329",
	[5] = "763.03002929688, -157.36000061035, 18.979999542236, 0, 0, 329",
	[6] = "1023.5999755859, -315.48001098633, 72.98999786377, 0, 0, 329",
	[7] = "1281.0400390625, 165.58999633789, 19.35000038147, 0, 0, 219",
	[8] = "1355.6600341797, 375.36999511719, 18.549999237061, 0, 0, 219",
	[9] = "1357.4499511719, 205.30999755859, 22.229999542236, 0, 0, 219",
	[10] = "1413.5400390625, 277.36999511719, 19.559999465942, 0, 0, 329",
	[11] = "1386.2399902344, 457.55999755859, 19.39999961853, 0, 0, 69",
	[12] = "1247.1099853516, 203.71000671387, 22.049999237061, 0, 0, 200",
	[13] = "2282.7399902344, 18.889999389648, 27.479999542236, 0, 0, 139",
	[14] = "2234.1398925781, -55.220001220703, 26.909999847412, 0, 0, 229",
	[15] = "2304.6999511719, 102.04000091553, 28.89999961853, 0, 0, 329",
	[16] = "2132.3898925781, 98.569999694824, 32.939998626709, 0, 0, 69",
	[17] = "848.72998046875, -598.11999511719, 17.420000076294, 0, 0, 159",
	[18] = "705.34997558594, -643.53002929688, 15.460000038147, 0, 0, 199",
	[19] = "626.98999023438, -552.20001220703, 16.940000534058, 0, 0, 69",
	[20] = "672.96002197266, -465.0299987793, 16.540000915527, 0, 0, 309"
}

addEvent("onSammelObjekteErstell", true)
addEventHandler("onSammelObjekteErstell", getRootElement(),
function()
	local sammel = getElementData(gMe, "pSFernseher")
	for i = 1, #fernseherSpawns, 1 do
		local done = tonumber(gettok(sammel, i, "|"))
		if(done == 0) then
			local fernsehr = createObject(1748, gettok(fernseherSpawns[i], 1, ","), gettok(fernseherSpawns[i], 2, ","), gettok(fernseherSpawns[i], 3, ","), gettok(fernseherSpawns[i], 4, ","), gettok(fernseherSpawns[i], 5, ","), gettok(fernseherSpawns[i], 6, ","))
			setElementData(fernsehr, "SAMMELOBJEKT", true)
			setElementData(fernsehr, "ID", i)
				
		end
	end
	addEventHandler ( "onClientClick", getRootElement(),
	function(button, state, X, Y, wx, wy, wz, element)
		if(button == "left") and (state == "down") then
			if(element) then
				if(getElementData(element, "SAMMELOBJEKT") == true) then
					outputChatBox(tostring(getElementData(element, "ID")))
				end
			end
		end
	end)
end)


--[[
function addLabelOnClick ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
        --if an element was clicked on screen
        if ( clickedElement ) then
                --retreive the element type
                local elementType = getElementType ( clickedElement )
                --change the label text to that element type
                guiSetText ( myLabel, elementType )
                --and place it in the position of where the element is
                guiSetPosition ( myLabel, absoluteX, absoluteY, false )
                --hide the text by passing an empty string 5 seconds later
                setTimer ( guiSetText, 5000, 1, myLabel, "" )
        end
end
addEventHandler ( "onClientClick", getRootElement(), addLabelOnClick )
--]]