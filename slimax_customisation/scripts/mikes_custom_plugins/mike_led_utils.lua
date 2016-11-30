require "scripts/mikes_custom_plugins/mike_utils"

activeBlinkingLeds = {}
activeAlternateBlinkingLeds = {}
activePermanentLeds = {}
defaultBlinkDelay = 500
alternateLedBlinkDelay = 500
ledOn = 1
ledOff = 0

function updateLeds()
	updateBlinkingLeds()
	updateActivePermanentLeds()
	updateAlternateBlinkingLeds()
end

function updateBlinkingLeds()
	for key, value in pairs(activeBlinkingLeds) do
		if mSessionEnter == 1 and not(m_is_sim_idle) then
			updateBlinkingLed(value, key)
		else
			SetPatternLed(key, ledOff)
		end
	end	
end

function updateAlternateBlinkingLeds()
	for key, value in pairs(activeAlternateBlinkingLeds) do		
		updateAlternateBlinkingLed(value)
	end	
end

function updateActivePermanentLeds()
	for key, value in pairs(activePermanentLeds) do
		updatePermLed(key, value)
	end	
end

function updateBlinkingLed(ledInfo, pattern)
	if ledInfo["duration"] > 0 and getTks() > ledInfo["duration"] then
		deactivateBlinkingLed(pattern)
	print("duration end")
	else
		if getTks() >= ledInfo["nextChange"] then
			ledInfo["nextChange"] = getTks() + ledInfo["delay"]
			if ledInfo["state"] == ledOn then
				ledInfo["state"] = ledOff
			else
				ledInfo["state"] = ledOn
			end
		end

		local state = ledOff
		if not(not(ledInfo["enabledWhenIdle"]) and mSessionEnter ~= 1 and m_is_sim_idle) then
			state = ledInfo["state"]
		end
		SetPatternLed(pattern, state)
	end
end

function updateAlternateBlinkingLed(ledInfo) 
	if getTks() >= ledInfo["nextChange"] then
		ledInfo["nextChange"] = getTks() + ledInfo["delay"]
		
		if ledInfo["currentPatternIndex"] < tablelength(ledInfo["patterns"])-1 then
			ledInfo["currentPatternIndex"] = ledInfo["currentPatternIndex"] + 1
		else
			ledInfo["currentPatternIndex"] = 0
		end
	end
	
	for key, value in pairs(ledInfo["patterns"]) do
		local ledState = ledOff
		if key == ledInfo["currentPatternIndex"] and not(not(ledInfo["enabledWhenIdle"]) and mSessionEnter ~= 1 and m_is_sim_idle) then
			ledState = ledOn
		end
		SetPatternLed(value, ledState)
	end
end

function updatePermLed(pattern, ledInfo)
	if not(ledInfo["enabledWhenIdle"]) and mSessionEnter ~= 1 and m_is_sim_idle then
		SetPatternLed(pattern, ledOff)
	elseif ledInfo["nextChange"] == 0 or getTks() <= ledInfo["nextChange"] then
		SetPatternLed(pattern, ledOn)
	else
		deactivatePermanentLed(pattern)
	end
end

function activateBlinkingLed(pattern, delay, duration, enabledWhenIdle)
	if activeBlinkingLeds[pattern] == nil then
		if delay == nil then
			delay = defaultBlinkDelay
		end
		activeBlinkingLeds[pattern] = {}
		activeBlinkingLeds[pattern]["delay"] = delay
		
		local dur = 0
		if duration > 0 then
			dur = getTks() + duration
		end		 
		
		activeBlinkingLeds[pattern]["duration"] = dur
		activeBlinkingLeds[pattern]["state"] = ledOn
		activeBlinkingLeds[pattern]["nextChange"] = getTks() + delay
		activeBlinkingLeds[pattern]["enabledWhenIdle"] = enabledWhenIdle
		SetPatternLed(pattern, ledOn)
	end
end

function activateAlternateBlinkingLeds(id, patterns, delay, enabledWhenIdle)
	if activeAlternateBlinkingLeds[id] == nil then
		if delay == nil then
			delay = alternateLedBlinkDelay
		end
		activeAlternateBlinkingLeds[id] = {}
		activeAlternateBlinkingLeds[id]["delay"] = delay
		activeAlternateBlinkingLeds[id]["nextChange"] = getTks() + delay
		activeAlternateBlinkingLeds[id]["currentPatternIndex"] = 0
		activeAlternateBlinkingLeds[id]["patterns"] = patterns
		activeAlternateBlinkingLeds[id]["enabledWhenIdle"] = enabledWhenIdle
	end
end

function activatePermanentLed(pattern, delay, enabledWhenIdle)
	if activePermanentLeds[pattern] == nil then
		local nextChange = 0
		if delay > 0 then
			nextChange = getTks() + delay
		end
		
		activePermanentLeds[pattern] = {}
		activePermanentLeds[pattern]["nextChange"] = nextChange
		activePermanentLeds[pattern]["enabledWhenIdle"] = enabledWhenIdle
		SetPatternLed(pattern, ledOn)
	end
end

function deactivatePermanentLed(pattern)
	if activePermanentLeds[pattern] ~= nil then
		activePermanentLeds[pattern] = nil
		SetPatternLed(pattern, ledOff)
	end
end

function deactivateBlinkingLed(pattern)
	if activeBlinkingLeds[pattern] ~= nil then
		activeBlinkingLeds[pattern] = nil
		SetPatternLed(pattern, ledOff)
	end
end

function deactivateAlternateBlinkingLeds(id)
	if activeAlternateBlinkingLeds[id] ~= nil then
		for key, value in pairs(activeAlternateBlinkingLeds[id]["patterns"]) do
			SetPatternLed(value, ledOff)
		end
		activeAlternateBlinkingLeds[id] = nil
	end
end
