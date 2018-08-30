addEvent("onSelfmenueSkinChange", true)
addEventHandler("onSelfmenueSkinChange", getRootElement(),function()
	executeCommandHandler("setcurskin", source)
end)