local SwagSwap = CreateFrame("Frame")
local queueset = queueset
	
SwagSwap:RegisterEvent("ADDON_LOADED")		
SwagSwap:RegisterEvent("PLAYER_REGEN_DISABLED")
SwagSwap:RegisterEvent("PLAYER_REGEN_ENABLED")						


local function DoEquip(combatMode) -- equip function

	if combatMode == 1 then
		if ssname ~= nil then
			local icon, setID, isEquipped, numItems, equippedItems, availableItems, missingItems, ignoredSlots = GetEquipmentSetInfoByName(ssname)
			if not isEquipped then
				UseEquipmentSet(ssname)
			end
		end
		return;	
	end
	
	if ssname2 ~= nil then
		local icon, setID, isEquipped, numItems, equippedItems, availableItems, missingItems, ignoredSlots = GetEquipmentSetInfoByName(ssname2)
		if not isEquipped then
			UseEquipmentSet(ssname2)
		end
	end
end

local function eventHandler(self, event, ...)

if event == "ADDON_LOADED" then
local addon = ...
	if addon == "SwagSwap" then
		if not ssname and not ssname2 then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00SwagSwap:|r No sets chosen. Please choose sets in the settings tab.")
			if ssenable == nil then
				myCheckButton_GlobalName:SetChecked(false)
			end
		else -- Set Stored Options
			if ssenable == true then
				myCheckButton_GlobalName:SetChecked(true)
			elseif ssenable == nil then
				myCheckButton_GlobalName:SetChecked(true)
			else
				myCheckButton_GlobalName:SetChecked(false)
			end
			if ssname then
				UIDropDownMenu_SetText(Mydropdown, ssname)
			end
			if ssname2 then
				UIDropDownMenu_SetText(Secondary, ssname2)
			end
		end
	end

elseif event == "PLAYER_REGEN_DISABLED" then -- entered combat, equip a weapon if no suitable weapon
	if ssenable == false then
		return;
	else
		DoEquip(0)
	end
	
elseif event == "PLAYER_REGEN_ENABLED" then -- OUT OF COMBAT
	if ssenable == false then
		return;
	else
		DoEquip(1)
	end
end
end
SwagSwap:SetScript("OnEvent", eventHandler)
