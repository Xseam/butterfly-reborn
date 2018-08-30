local Guivar = 0

function createShaderGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)

	local X, Y, Width, Height = getMiddleGuiPosition(264,189)
	local Fenster = guiCreateWindow(X, Y, Width, Height, "Shaders",false)
	local Label = guiCreateLabel(13,22,239,25,"Hier kannst du deine Shaders bestimmen!",false,Fenster)
	guiSetFont(Label,"default-bold-small")
	local ch1 = guiCreateCheckBox(15,45,176,33,"Roadshine Shader",false,false,Fenster)
	guiSetFont(ch1,"default-bold-small")
	local ch2 = guiCreateCheckBox(15,74,176,33,"Glow Shader",false,false,Fenster)
	guiSetFont(ch2,"default-bold-small")
	local ch3 = guiCreateCheckBox(15,103,176,33,"Contrast Shader",false,false,Fenster)
	guiSetFont(ch3,"default-bold-small")
	local Knopf = guiCreateButton(80,149,101,31,"Speichern",false,Fenster)
	local file = fileOpen("shaders.txt")
	local sets = fileRead(file, 50)
	local x1, x2, x3 = tonumber(gettok(sets, 1, "|")), tonumber(gettok(sets, 2, "|")),tonumber(gettok(sets, 3, "|"))
	if(x1 == 1) then guiCheckBoxSetSelected(ch1, true) end
	if(x2 == 1) then guiCheckBoxSetSelected(ch2, true) end
	if(x3 == 1) then guiCheckBoxSetSelected(ch3, true) end
	fileClose(file)
	addEventHandler("onClientGUIClick", Knopf,
	function()
		Guivar = 0
		showCursor(false)
		guiSetVisible(Fenster, false)
		local r1, r2, r3 = guiCheckBoxGetSelected(ch1), guiCheckBoxGetSelected(ch2), guiCheckBoxGetSelected(ch3)
		if(r1 == true) then r1 = 1 enableRoadshine3() else disableRoadshine3() r1 = 0 end
		if(r2 == true) then r2 = 1 enableBlurShader() else  disableBlurShader() r2 = 0 end
		if(r3 == true) then r3 = 1 enableContrast() else  disableContrast() r3 = 0 end
		local file = fileOpen("shaders.txt")
		fileWrite(file, "|"..r1.."|"..r2.."|"..r3.."|")
		fileFlush(file)
		fileClose(file)
	end, false)
end
addCommandHandler("shaders", createShaderGui)