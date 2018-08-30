local penner1 = createPed(137, 272.21215820313, -21.473524093628, 1.5896952629089)
setElementRotation(penner1, -0, 0, 43.995056152344)
setElementHealth(penner1, 1000)
setElementFrozen(penner1, true)


addEventHandler("onClientPedDamage", getRootElement(),
function()
if(source == penner1) then
setElementHealth(penner1, 1000)
end
end)