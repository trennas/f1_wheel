require "scripts/mike_multifunction_f1_2015"
require "scripts/mike_custom_displays"


function custom_init_Event(scriptfile)	
end

function custom_controls_Event(deviceType, ctrlType, ctrlPos, value, funcIndex, targetDevice)
	return f1ControlsEvent(deviceType, ctrlType, ctrlPos, value, funcIndex, targetDevice)
end

function custom_left_Display_Event(swValue)
	return customDisplayEventProcessing(swValue, 0)
end

function custom_right_Display_Event(swValue)
	return customDisplayEventProcessing(swValue, 1)
end
