
function getOpenMenuButtons(chosenMenu)
	local buttons = {}
	local currentMenu = buttonTrackerMap[quickMenuToggleButton] % (numMenus + 1)
	if currentMenu ~= chosenMenu then
		local closeMenuClicks = 0
		if chosenMenu < currentMenu then
			closeMenuClicks = (numMenus + 1) - currentMenu
		end
		for i = currentMenu, (chosenMenu - 1 + closeMenuClicks) do
			buttons[i] = quickMenuToggleKey
		end
	end	
	return buttons
end