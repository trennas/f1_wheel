require "scripts/mikes_custom_plugins/mike_all_custom_plugins"

keystrokeDelay = 200

quickMenuToggleButton = "NUMPAD8" -- also button 13 on simr-f1
quickMenuUp = "NUMPAD8"
quickMenuDn = "NUMPAD2"
quickMenuLeft = "NUMPAD4"
quickMenuRight = "NUMPAD6"
trackableDecrementButton = quickMenuLeft
trackableIncrementButton = quickMenuRight
customKeystrokeDelays = {}
customKeystrokeDelays[trackableDecrementButton] = 50
customKeystrokeDelays[trackableIncrementButton] = 50

multifunctionMap = {}

multifunctionMap[1] = {}
multifunctionMap[1]["name"] = "FUEL"
multifunctionMap[1]["enabled"] = true
multifunctionMap[1]["upDnSelectable"] = true
multifunctionMap[1]["upDnConfirmRequired"] = true
multifunctionMap[1]["defaultUpDnMode"] = 1
multifunctionMap[1]["currentUpDnMode"] = multifunctionMap[1]["defaultUpDnMode"]
multifunctionMap[1]["min"] = 0
multifunctionMap[1]["max"] = 2
multifunctionMap[1]["modes"] = {}
multifunctionMap[1]["modes"][0] = "LEAN"
multifunctionMap[1]["modes"][1] = "NORM"
multifunctionMap[1]["modes"][2] = "RICH"
--multifunctionMap[1]["confirmButtonMap"] = {}
multifunctionMap[1]["trackableButtonMap"] = {}
multifunctionMap[1]["trackableButtonMap"][0] = quickMenuToggleButton

multifunctionMap[2] = {}
multifunctionMap[2]["name"] = "TYRE"
multifunctionMap[2]["enabled"] = true
multifunctionMap[2]["upDnSelectable"] = true
multifunctionMap[2]["upDnConfirmRequired"] = true
multifunctionMap[2]["defaultUpDnMode"] = 2
multifunctionMap[2]["currentUpDnMode"] = multifunctionMap[2]["defaultUpDnMode"]
multifunctionMap[2]["min"] = 0
multifunctionMap[2]["max"] = 4
multifunctionMap[2]["modes"] = {}
multifunctionMap[2]["modes"][0] = "ULTR"
multifunctionMap[2]["modes"][1] = "OPTN"
multifunctionMap[2]["modes"][2] = "PRME"
multifunctionMap[2]["modes"][3] = "INTR"
multifunctionMap[2]["modes"][4] = "WETS"
multifunctionMap[2]["trackableButtonMap"] = {}
multifunctionMap[2]["trackableButtonMap"][0] = quickMenuToggleButton
multifunctionMap[2]["trackableButtonMap"][1] = quickMenuDn
multifunctionMap[2]["trackableButtonMap"][2] = quickMenuDn
multifunctionMap[2]["trackableButtonMap"][3] = quickMenuDn
multifunctionMap[2]["trackableButtonMap"][4] = quickMenuDn

multifunctionMap[3] = {}
multifunctionMap[3]["name"] = "AERO"
multifunctionMap[3]["enabled"] = true
multifunctionMap[3]["upDnSelectable"] = true
multifunctionMap[3]["upDnConfirmRequired"] = true
multifunctionMap[3]["defaultUpDnMode"] = 4
multifunctionMap[3]["currentUpDnMode"] = multifunctionMap[3]["defaultUpDnMode"]
multifunctionMap[3]["min"] = 0
multifunctionMap[3]["max"] = 9
multifunctionMap[3]["modes"] = {}
multifunctionMap[3]["modes"][0] = "1"
multifunctionMap[3]["modes"][1] = "2"
multifunctionMap[3]["modes"][2] = "3"
multifunctionMap[3]["modes"][3] = "4"
multifunctionMap[3]["modes"][4] = "5"
multifunctionMap[3]["modes"][5] = "6"
multifunctionMap[3]["modes"][6] = "7"
multifunctionMap[3]["modes"][7] = "8"
multifunctionMap[3]["modes"][8] = "9"
multifunctionMap[3]["modes"][9] = "10"
multifunctionMap[3]["trackableButtonMap"] = {}
multifunctionMap[3]["trackableButtonMap"][0] = quickMenuToggleButton
multifunctionMap[3]["trackableButtonMap"][1] = quickMenuDn
multifunctionMap[3]["trackableButtonMap"][2] = quickMenuDn
multifunctionMap[3]["trackableButtonMap"][3] = quickMenuDn

multifunctionMap[4] = {}
multifunctionMap[4]["name"] = "BIAS"
multifunctionMap[4]["enabled"] = true
multifunctionMap[4]["upDnSelectable"] = true
multifunctionMap[4]["upDnConfirmRequired"] = true
multifunctionMap[4]["defaultUpDnMode"] = 25
multifunctionMap[4]["currentUpDnMode"] = multifunctionMap[4]["defaultUpDnMode"]
multifunctionMap[4]["min"] = 0
multifunctionMap[4]["max"] = 50
multifunctionMap[4]["modes"] = {}
multifunctionMap[4]["modes"][0] = "0%"
multifunctionMap[4]["modes"][1] = "2%"
multifunctionMap[4]["modes"][2] = "4%"
multifunctionMap[4]["modes"][3] = "6%"
multifunctionMap[4]["modes"][4] = "8%"
multifunctionMap[4]["modes"][5] = "10%"
multifunctionMap[4]["modes"][6] = "12%"
multifunctionMap[4]["modes"][7] = "14%"
multifunctionMap[4]["modes"][8] = "16%"
multifunctionMap[4]["modes"][9] = "18%"
multifunctionMap[4]["modes"][10] = "20%"
multifunctionMap[4]["modes"][11] = "22%"
multifunctionMap[4]["modes"][12] = "24%"
multifunctionMap[4]["modes"][13] = "26%"
multifunctionMap[4]["modes"][14] = "28%"
multifunctionMap[4]["modes"][15] = "30%"
multifunctionMap[4]["modes"][16] = "32%"
multifunctionMap[4]["modes"][17] = "34%"
multifunctionMap[4]["modes"][18] = "36%"
multifunctionMap[4]["modes"][19] = "38%"
multifunctionMap[4]["modes"][20] = "40%"
multifunctionMap[4]["modes"][21] = "42%"
multifunctionMap[4]["modes"][22] = "44%"
multifunctionMap[4]["modes"][23] = "46%"
multifunctionMap[4]["modes"][24] = "48%"
multifunctionMap[4]["modes"][25] = "50%"
multifunctionMap[4]["modes"][26] = "52%"
multifunctionMap[4]["modes"][27] = "54%"
multifunctionMap[4]["modes"][28] = "56%"
multifunctionMap[4]["modes"][29] = "58%"
multifunctionMap[4]["modes"][30] = "60%"
multifunctionMap[4]["modes"][31] = "62%"
multifunctionMap[4]["modes"][32] = "64%"
multifunctionMap[4]["modes"][33] = "66%"
multifunctionMap[4]["modes"][34] = "68%"
multifunctionMap[4]["modes"][35] = "70%"
multifunctionMap[4]["modes"][36] = "72%"
multifunctionMap[4]["modes"][37] = "74%"
multifunctionMap[4]["modes"][38] = "76%"
multifunctionMap[4]["modes"][39] = "78%"
multifunctionMap[4]["modes"][40] = "80%"
multifunctionMap[4]["modes"][41] = "82%"
multifunctionMap[4]["modes"][42] = "84%"
multifunctionMap[4]["modes"][43] = "86%"
multifunctionMap[4]["modes"][44] = "88%"
multifunctionMap[4]["modes"][45] = "90%"
multifunctionMap[4]["modes"][46] = "92%"
multifunctionMap[4]["modes"][47] = "94%"
multifunctionMap[4]["modes"][48] = "96%"
multifunctionMap[4]["modes"][49] = "98%"
multifunctionMap[4]["modes"][50] = "100%"
multifunctionMap[4]["trackableButtonMap"] = {}
multifunctionMap[4]["trackableButtonMap"][0] = quickMenuToggleButton
multifunctionMap[4]["trackableButtonMap"][1] = quickMenuDn

multifunctionMap[5] = {}
multifunctionMap[5]["name"] = "DIFF"
multifunctionMap[5]["enabled"] = true
multifunctionMap[5]["upDnSelectable"] = true
multifunctionMap[5]["upDnConfirmRequired"] = true
multifunctionMap[5]["defaultUpDnMode"] = 10
multifunctionMap[5]["currentUpDnMode"] = multifunctionMap[5]["defaultUpDnMode"]
multifunctionMap[5]["currentPosition"] = nil
multifunctionMap[5]["min"] = 0
multifunctionMap[5]["max"] = 20
multifunctionMap[5]["modes"] = {}
multifunctionMap[5]["modes"][0] = " 0%"
multifunctionMap[5]["modes"][1] = "5%"
multifunctionMap[5]["modes"][2] = "10%"
multifunctionMap[5]["modes"][3] = "15%"
multifunctionMap[5]["modes"][4] = "20%"
multifunctionMap[5]["modes"][5] = "25%"
multifunctionMap[5]["modes"][6] = "30%"
multifunctionMap[5]["modes"][7] = "35%"
multifunctionMap[5]["modes"][8] = "40%"
multifunctionMap[5]["modes"][9] = "45%"
multifunctionMap[5]["modes"][10] = "50%"
multifunctionMap[5]["modes"][11] = "55%"
multifunctionMap[5]["modes"][12] = "60%"
multifunctionMap[5]["modes"][13] = "65%"
multifunctionMap[5]["modes"][14] = "70%"
multifunctionMap[5]["modes"][15] = "75%"
multifunctionMap[5]["modes"][16] = "80%"
multifunctionMap[5]["modes"][17] = "85%"
multifunctionMap[5]["modes"][18] = "90%"
multifunctionMap[5]["modes"][19] = "95%"
multifunctionMap[5]["modes"][20] = "100%"
multifunctionMap[5]["trackableButtonMap"] = {}
multifunctionMap[5]["trackableButtonMap"][0] = quickMenuToggleButton
multifunctionMap[5]["trackableButtonMap"][1] = quickMenuDn
multifunctionMap[5]["trackableButtonMap"][2] = quickMenuDn

multifunctionMap[6] = {}
multifunctionMap[6]["name"] = "L"
multifunctionMap[7] = {}
multifunctionMap[7]["name"] = "D"
multifunctionMap[8] = {}
multifunctionMap[8]["name"] = "WET"
multifunctionMap[9] = {}
multifunctionMap[9]["name"] = "INT"
multifunctionMap[10] = {}
multifunctionMap[10]["name"] = "PRI"
multifunctionMap[11] = {}
multifunctionMap[11]["name"] = "OPT"

multifunctionMap[12] = {}
multifunctionMap[12]["name"] = "RSET"
multifunctionMap[12]["enabled"] = true

-- Used by the overtake button
fuelMultiFunction = multifunctionMap[1]
overtakeButtonEnabled = true

function custom_init_Event(scriptfile)	
end
