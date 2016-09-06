quickMenuToggleButton = 13
quickMenuToggleKey = "M"
quickMenuUp = "NUMPAD8"
quickMenuDn = "NUMPAD2"
quickMenuLeft = "NUMPAD4"
quickMenuRight = "NUMPAD6"
radioKey = "T"
prevCameraKey = "X"
nextCameraKey = "C"

extraDelay = 300
openMenuDelay = 400

buttonTrackerMap = {}
buttonTrackerMap[quickMenuToggleButton] = 0

function getVoiceMenuButtons(currentMultifunction)
	local index = 0
	local buttonMap = {}

	delayMap = {}
	delayMap[0] = extraDelay
	
	buttonMap[index] = radioKey
	index = index + 1

	for i = 1, currentMultifunction["voiceMenuPage"] - 1 do
		buttonMap[index] = quickMenuToggleKey
		delayMap[index] = 30
		index = index + 1
	end
	
	if currentMultifunction["voiceMenuRows"][currentMultifunction["currentUpDnMode"]] > 1 then
		for i = 1, currentMultifunction["voiceMenuRows"][currentMultifunction["currentUpDnMode"]] - 1 do
			buttonMap[index] = quickMenuDn
			index = index + 1
		end
	else
		delayMap[index - 1] = 100
	end

	buttonMap[index] = quickMenuRight
	return buttonMap
end

function getTrackableQuickMenuSettingButtons(currentMultifunction)
	-- Trackable up/dn modes. Eg in F1 2016, the quick-menu keeps track of what is currently
	-- selected, therefore the button maps will need to change on the fly.
	local index = 0
	local buttonMap = {}
	local numQuickMenuChanges = 0
	local numRowChanges = 0

	delayMap = {}

	-- Open the quick menu to the required menu page, taking into account what page
	-- (if any) is currently being shown
	local openMenuButtons = getOpenMenuButtons(currentMultifunction["menu"])
	for key, value in pairs(openMenuButtons) do
		buttonMap[index] = value
		index = index + 1
		numQuickMenuChanges = numQuickMenuChanges + 1
	end

	-- Scroll down to the required row.
	local selectRowButtons = getSelectRowButtons(currentMultifunction["row"] - 1)
	for key, value in pairs(selectRowButtons) do
		buttonMap[index] = value
		index = index + 1
		numRowChanges = numRowChanges + 1
	end

	if trackSelections == false or currentMultifunction["currentPosition"] == nil then
		-- We don't know what's currently selected. Therefore move the selector
		-- all the way to the bottom so we know the 'min' mode is selected
		for i = currentMultifunction["min"], currentMultifunction["max"] - 1 do
			buttonMap[index] = quickMenuLeft
			index = index + 1
		end
		-- Now we know the currently selected mode so store it
		currentMultifunction["currentPosition"] = currentMultifunction["min"]
	end

	-- Now increment or decrement to reach the requested mode (currentUpDnMode)
	local keyPress = quickMenuRight
	local step = 1
	local loopStartIndex = currentMultifunction["currentPosition"] + 1
	if currentMultifunction["currentPosition"] > currentMultifunction["currentUpDnMode"] then
		keyPress = quickMenuLeft
		loopStartIndex = currentMultifunction["currentPosition"] - 1
		step = -1
	end
	for i = loopStartIndex, currentMultifunction["currentUpDnMode"], step do
		buttonMap[index] = keyPress
		index = index + 1
	end
	-- Update the current position to match what we have selected.
	currentMultifunction["currentPosition"] = currentMultifunction["currentUpDnMode"]

	-- Finally, we want to return the quick menu to the previously selected one, if any.
	if numQuickMenuChanges > 0 then
		for i = 0, (numMenus - numQuickMenuChanges) do
			buttonMap[index] = quickMenuToggleKey
			buttonTrackerMap[quickMenuToggleButton] = buttonTrackerMap[quickMenuToggleButton] + 1
			delayMap[index] = extraDelay
			index = index + 1
		end
	elseif numRowChanges > 0 and trackSelections then
		-- We were already on the correct menu, so return the row to the top
		for i = 0, (numRowChanges - 1) do
			buttonMap[index] = quickMenuUp
			index = index + 1
		end
	end

	return buttonMap
end

function getOpenMenuButtons(chosenMenu)
	local buttons = {}	
	if trackMenus and currentMenu ~= chosenMenu then
		local currentMenu = getCurrentMenu()
		if chosenMenu < currentMenu then
			local closeMenuClicks = (numMenus + 1) - currentMenu
			for i = 0, closeMenuClicks + chosenMenu - 1 do
				buttons[i] = quickMenuToggleKey
				buttonTrackerMap[quickMenuToggleButton] = buttonTrackerMap[quickMenuToggleButton] + 1
			end
		else
			for i = 0, chosenMenu - currentMenu - 1 do
				buttons[i] = quickMenuToggleKey
				buttonTrackerMap[quickMenuToggleButton] = buttonTrackerMap[quickMenuToggleButton] + 1
			end
		end

		if currentMenu == 0 then
			delayMap = {}
			delayMap[0] = openMenuDelay
		end
	else
		for i = 0, chosenMenu - 1 do
			buttons[i] = quickMenuToggleKey
			buttonTrackerMap[quickMenuToggleButton] = buttonTrackerMap[quickMenuToggleButton] + 1
		end
		delayMap = {}
		delayMap[0] = openMenuDelay
	end
	return buttons
end

function getCurrentMenu()
	return buttonTrackerMap[quickMenuToggleButton] % (numMenus + 1)
end

function getSelectRowButtons(chosenRow)
	local buttons = {}
	for i = 0, chosenRow - 1 do
		buttons[i] = quickMenuDn
	end
	return buttons
end

customFunctionNamesTable = {}
customFunctionNamesTable[1] = {}
customFunctionNamesTable[1][0] = "POS"
customFunctionNamesTable[1][1] = "LAPS"
customFunctionNamesTable[2] = {}
customFunctionNamesTable[2][0] = "LAPS"
customFunctionNamesTable[2][1] = "COMP"
customFunctionNamesTable[3] = {}
customFunctionNamesTable[3][0] = "SPED"
customFunctionNamesTable[3][1] = "PREV"
customFunctionNamesTable[4] = {}
customFunctionNamesTable[4][0] = "CURR"
customFunctionNamesTable[4][1] = "BEST"
customFunctionNamesTable[5] = {}
customFunctionNamesTable[5][0] = "DELT"
customFunctionNamesTable[5][1] = "TIME"
customFunctionNamesTable[6] = {}
customFunctionNamesTable[6][0] = "SECT"
customFunctionNamesTable[6][1] = "TIME"
customFunctionNamesTable[7] = {}
customFunctionNamesTable[7][0] = "TIME"
customFunctionNamesTable[7][1] = "REMN"
customFunctionNamesTable[8] = {}
customFunctionNamesTable[8][0] = "ACCL"
customFunctionNamesTable[8][1] = "BRKE"
customFunctionNamesTable[9] = {}
customFunctionNamesTable[9][0] = "WATR"
customFunctionNamesTable[9][1] = " OIL"
customFunctionNamesTable[10] = {}
customFunctionNamesTable[10][0] = "FUEL"
customFunctionNamesTable[10][1] = "TANK"
customFunctionNamesTable[11] = {}
customFunctionNamesTable[11][0] = "FUEL"
customFunctionNamesTable[11][1] = "LAPS"
customFunctionNamesTable[12] = {}
customFunctionNamesTable[12][0] = "FUEL"
customFunctionNamesTable[12][1] = "TARG"