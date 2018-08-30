local bankrobsound = false
addEvent("onBankraubStart", true)
addEventHandler("onBankraubStart", getRootElement(),
function()
	if(bankrobsound ~= false) then return end 
	bankrobsound = playSound3D("sounds/bankrob.mp3", 2306.0490722656, -17.315645217896, 28.749565124512, true)
	setSoundMaxDistance(bankrobsound, 65)
	setSoundVolume(bankrobsound, 1)
end)

addEvent("onBankraubStop", true)
addEventHandler("onBankraubStop", getRootElement(),
function()
	if not(bankrobsound) then return end
	destroyElement(bankrobsound)
end)