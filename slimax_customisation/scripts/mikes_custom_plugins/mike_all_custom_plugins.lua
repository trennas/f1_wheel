require "scripts/mikes_custom_plugins/mike_multifunction_switch"
require "scripts/mikes_custom_plugins/mike_custom_displays"
require "scripts/mikes_custom_plugins/mike_utils"
require "scripts/mikes_custom_plugins/mike_one_switch"

function custom_controls_Event(deviceType, ctrlType, ctrlPos, value, funcIndex, targetDevice)
	local mult = multiControlsEvent(deviceType, ctrlType, ctrlPos, value)
	local oneSw = oneSwitchControlEvent(ctrlType, ctrlPos, value)
	if mult < oneSw then
		return mult
	else
		return oneSw
	end
end

function custom_left_Display_Event(swPosition)
	if customFunctionNamesTable ~= nil and (prevFunction == nil or prevFunction ~= swPosition) then
		prevFunction = swPosition
		display(customFunctionNamesTable[swPosition][0], customFunctionNamesTable[swPosition][1], myDevice, mDisplay_Info_Delay)
	end
	return dispEvent(0, swPosition)
end

function custom_right_Display_Event(swPosition)
	oneSwitchRightDisplayEvent(swPosition)
	return dispEvent(1, swPosition)
end

function dispEvent(side, swPosition)
	updateLeds()
	if not(customDisplayIsActive()) then		
		return customDisplayEventProcessing(swValue, side)
	else
		return 1
	end
end