require "scripts/mikes_custom_plugins/mike_utils"

--------------------------------------------------
-- Set These Values To The Buttons You Want To Use
local multiFunctionSwitchId = 3

local setValueSwitchId = 1
--------------------------------------------------
local overtakeButton = 10
local overtakeLedPatterns = {}
overtakeLedPatterns[0] = 128
overtakeLedPatterns[1] = 64
local resetLedPattern = 56	-- 1,2,3 = 111000
currentMultifunction = nil

local selectDelay = 600
local multiSelectDelay = 500
local encoderIncrement = 10
local resetMultiFunctionName = "RSET"
local overtakeEngaged = false
local autoMixActiveBeforeOvertakeButton = false

function multiControlsEvent(deviceType, ctrlType, ctrlPos, value)
	if deviceType == myDevice then
--print("ctrlType: " .. ctrlType .. ", ctrlPos: " .. ctrlPos .. ", value: " .. value .. ".\n")
		if ctrlType == switch and ctrlPos == multiFunctionSwitchId then
			if multifunctionMap[value] ~= nil then
				currentMultifunction = multifunctionMap[value]
				local left = "MULT"
				local right = currentMultifunction["name"]
				if currentMultifunction["enabled"] and currentMultifunction["upDnSelectable"] then
					if currentMultifunction["name"] ~= "OSP" then
						left = currentMultifunction["name"]
						right = currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]]
					else
						left = "OSP "
						right = string.format(" %03d  ", GetContextInfo("osp_factor"))
					end
				end
				if currentMultifunction["enabled"] or currentMultifunction["display"] then
					display(left, right, multiSelectDelay)
				end
				return 1
			end

		elseif currentMultifunction ~= nil and currentMultifunction["enabled"] then
			-- Overtake Button
			if ctrlType == pushbutton and ctrlPos == overtakeButton and value == buttonReleaseValue
			  and currentMultifunction["enabled"] and currentMultifunction["name"] ~= resetMultiFunctionName
			   and currentMultifunction["name"] ~= "autoMixMultifunctionName" then
				if overtakeButtonEnabled  and mSessionEnter == 1 and not(m_is_sim_idle) then
					toggleOvertakeMode(true)
				end
			elseif ctrlType == pushbutton and value == buttonReleaseValue and currentMultifunction["name"] ~= resetMultiFunctionName then
				-- Multifunction Up/Dn
				if currentMultifunction["upDnSelectable"] then
					if ctrlPos == upButton or ctrlPos == upEncoder then
						if currentMultifunction["name"] == "OSP" then
							local ospf = GetContextInfo("osp_factor")
							local inc = 1
							if ctrlPos == upEncoder then
								inc = encoderIncrement
							end
							ospf = ospf + inc
							if ospf > 999 then
								ospf = 999
							end
							SetOSPFactor(ospf)
							display("OSP ", string.format(" %03d  ", ospf), confirmDelay)
						elseif currentMultifunction["currentUpDnMode"] < currentMultifunction["max"] then
							currentMultifunction["currentUpDnMode"] = currentMultifunction["currentUpDnMode"] + 1
							if currentMultifunction["upDnConfirmRequired"] then
								display(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], selectDelay)
							else
								confirmSelection(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], getButtonMap(currentMultifunction), true)
							end
						else
							if currentMultifunction["wrap"] then
								currentMultifunction["currentUpDnMode"] = currentMultifunction["min"]
							end

							if currentMultifunction["upDnConfirmRequired"] then
								display(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], selectDelay)
							else
								confirmSelection(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], getButtonMap(currentMultifunction), true)
							end
						end
						return 1
					elseif ctrlPos == downButton or ctrlPos == downEncoder then
						if currentMultifunction["name"] == "OSP" then
							local ospf = GetContextInfo("osp_factor")
							local inc = 1
							if ctrlPos == downEncoder then
								inc = encoderIncrement
							end
							ospf = ospf - inc
							if ospf < 0 then
								ospf = 0
							end
							SetOSPFactor(ospf)
							display("OSP ", string.format(" %03d  ", ospf), confirmDelay)						
						elseif currentMultifunction["currentUpDnMode"] > currentMultifunction["min"] then
							currentMultifunction["currentUpDnMode"] = currentMultifunction["currentUpDnMode"] - 1
							if currentMultifunction["upDnConfirmRequired"] then
								display(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], selectDelay)
							else
								confirmSelection(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], getButtonMap(currentMultifunction), true)
							end
						else
							if currentMultifunction["wrap"] then
								currentMultifunction["currentUpDnMode"] = currentMultifunction["max"]
							end

							if currentMultifunction["upDnConfirmRequired"] then
								display(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], selectDelay)
							else
								confirmSelection(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], getButtonMap(currentMultifunction), true)
							end
						end
						return 1
					elseif ctrlPos == confirmButton and currentMultifunction["name"] ~= "OSP" then
						confirmSelection("CONF", currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], getButtonMap(currentMultifunction), true)
						return 1
					end
				elseif currentMultifunction["name"] == autoDiffMultifunctionName then
					processAutoDiffButtonEvent(ctrlPos)
				elseif currentMultifunction["name"] == autoMixMultifunctionName then
					processAutoMixButtonEvent(ctrlPos)
				elseif currentMultifunction["name"] == "DATA" then
					processFuelDataButtonEvent(ctrlPos)
				
				-- Multifunction Single Confirm (For non Up-Dn Modes)
				elseif ctrlPos == confirmButton then
					confirmSelection(currentMultifunction["name"], "CONF", getButtonMap(currentMultifunction), true)
					return 1
				end

			elseif currentMultifunction["name"] ~= resetMultiFunctionName and ctrlType == switch and ctrlPos == setValueSwitchId and currentMultifunction["upDnSelectable"] then
				upDnValue = value - 1
				if upDnValue >= currentMultifunction["min"] and upDnValue <= currentMultifunction["max"] then
					currentMultifunction["currentUpDnMode"] = upDnValue
					display(currentMultifunction["name"], currentMultifunction["modes"][currentMultifunction["currentUpDnMode"]], selectDelay)
				end
				return 1

			elseif currentMultifunction["name"] == resetMultiFunctionName and value == buttonReleaseValue then
				if ctrlPos == confirmButton then
					setDefaultModes()
					if mSessionEnter == 1 and not(m_is_sim_idle) then
						activateBlinkingLed(resetLedPattern, 45, 100, false)
						display(currentMultifunction["name"], "DATA", selectDelay)
					end
				end
			end
		end
	end

	return 2
end

function toggleOvertakeMode(showDisplay)
	if overtakeEngaged then
		overtakeEngaged = false
		
		if autoMixActiveBeforeOvertakeButton then
			autoMixActiveBeforeOvertakeButton = false
			autoMixOn()
		end
		
		local multiFunctionBak = currentMultifunction
		currentMultifunction = fuelMultiFunction			
		confirmSelection("OVTK", " END", getButtonMap(currentMultifunction), showDisplay)			
		currentMultifunction = multiFunctionBak
		
		if showDisplay then
			deactivateAlternateBlinkingLeds("overtake")
		end

		if ospBak ~= nil then
			SetOSPFactor(ospBak)
		end
	else
		overtakeEngaged = true
		
		autoMixActiveBeforeOvertakeButton = isAutoMixActive()
		if autoMixActiveBeforeOvertakeButton then
			autoMixOff()
		end

		local multiFunctionBak = currentMultifunction
		currentMultifunction = fuelMultiFunction
		local fuelModeBak = currentMultifunction["currentUpDnMode"]
		currentMultifunction["currentUpDnMode"] = currentMultifunction["max"]
		confirmSelection("OVER", "TAKE", getButtonMap(currentMultifunction), showDisplay)
		currentMultifunction["currentUpDnMode"] = fuelModeBak
		currentMultifunction = multiFunctionBak
		
		if showDisplay then
			activateAlternateBlinkingLeds("overtake", overtakeLedPatterns, nil, false, 0)
		end

		if overtakeOspOverdrive then
			ospBak = GetContextInfo("osp_factor")
			SetOSPFactor(GetContextInfo("osp_overdrive"))
		end
	end
end

function setDefaultModes()
	for key, value in pairs(multifunctionMap) do
		if value["defaultUpDnMode"] ~= nil then
			value["currentUpDnMode"] = value["defaultUpDnMode"]
		else
			value["currentUpDnMode"] = nil
		end
		value["currentPosition"] = nil
	end

	overtakeEngaged = false
	resetAutoMixData()
	resetFuelData()
	resetLeds()
	resetAutoDiff()
end