addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	local sound = playSound3D("http://server02.stream-login.eu/tunein.php/kn1093/playlist.asx", 873.56860351563, -26.370595932007, 64.836143493652) -- Johnnys Haus
	setSoundMaxDistance(sound, 10)
end)