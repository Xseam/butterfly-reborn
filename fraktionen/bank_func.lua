local Object = createObject(1454, 2315.5, 0.5, 25, 0, 0, 270) -- Bombenobjektda

local ATM1 = createObject(2942, 2316.6999511719, -4.6999998092651, 26.39999961853, 0, 0, 270)
local ATM2 = createObject(2942, 2316.6999511719, -7.4000000953674, 26.39999961853, 0, 0, 270)
local ATM3 = createObject(2942, 2316.6999511719, -10.60000038147, 26.39999961853, 0, 0, 270)
local ATM4 = createObject(2942, 2316.6999511719, -13.60000038147, 26.39999961853, 0, 0, 270)

function createPed1()
	if(BankPed1) then destroyElement(BankPed1) end
	local BankPed1 = createPed(17, 2310.7661132813, -11.012133598328, 26.7421875)
	setElementHealth(BankPed1, 1000)
	setElementFrozen(BankPed1, true)
	setElementRotation(BankPed1, 0, 0, 180)
end

function createPed2()
	if(BankPed2) then destroyElement(BankPed2) end
	local BankPed2 = createPed(141, 2306.5319824219, -1.4296736717224, 26.7421875)
	setElementHealth(BankPed2, 1000)
	setElementFrozen(BankPed2, true)
	setElementRotation(BankPed2, -0, 0, 228)
end

createPed1()
createPed2()

setTimer(createPed1, 5000000, 0)
setTimer(createPed2, 5000000, 0)