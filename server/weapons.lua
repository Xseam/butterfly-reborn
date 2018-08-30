addEventHandler("onPlayerJoin", getRootElement(),
function()
	if not(source) then return end
	setPedStat ( source, 69, 40 )
	setPedStat ( source, 71, 999 )
	setPedStat ( source, 72, 999 )
	setPedStat ( source, 73, 999 )
	setPedStat ( source, 74, 999 )
	setPedStat ( source, 75, 999 )
	setPedStat ( source, 76, 999 )
	setPedStat ( source, 77, 999 )
	setPedStat ( source, 78, 999 )
	setPedStat ( source, 79, 999 )
	setPedStat ( source, 70, 999 )
end)

setWeaponProperty(31, "pro", "maximum_clip_ammo", 75)
setWeaponProperty(29, "pro", "maximum_clip_ammo",50)
setWeaponProperty(30, "pro", "maximum_clip_ammo",50)

setWeaponProperty ( "pistol", "poor", "damage", 50 )
setWeaponProperty ( "pistol", "std", "damage", 50 )
setWeaponProperty ( "pistol", "pro", "damage", 0 )

setWeaponProperty ( "desert_eagle", "poor", "damage", 40 )
setWeaponProperty ( "desert_eagle", "std", "damage", 40 )
setWeaponProperty ( "desert_eagle", "pro", "damage", 40 )
