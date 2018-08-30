local URL = "http://listen.technobase.fm/dsl.asx"

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	sound1 = playSound3D(URL, 1368.0999755859, -26, 999.90002441406, true) 
	setSoundVolume(sound1, 0.7)
	setElementInterior(sound1, 1)

end)