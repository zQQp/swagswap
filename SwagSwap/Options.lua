
SwagSwapOptions = {};
SwagSwapOptions.panel = CreateFrame( "Frame", "MyAddonPanel", UIParent );
SwagSwapOptions.panel.name = "Swag Swap";
InterfaceOptions_AddCategory(SwagSwapOptions.panel);
 
local Title = SwagSwapOptions.panel:CreateFontString("Title", "ARTWORK", "GameFontNormalLarge")
Title:SetPoint("TOPLEFT", SwagSwapOptions.panel, "TOPLEFT", 10, -10)
Title:SetText("SwagSwap")

local Tree1 = SwagSwapOptions.panel:CreateFontString("Tree1", "ARTWORK", "GameFontNormal")
Tree1:SetPoint("RIGHT", SwagSwapOptions.panel, "RIGHT", -300, 210)
Tree1:SetText("Out of Combat Set")

local Tree2 = SwagSwapOptions.panel:CreateFontString("Tree2", "ARTWORK", "GameFontNormal")
Tree2:SetPoint("RIGHT", SwagSwapOptions.panel, "RIGHT", -170, 210)

Tree2:SetText("In Combat Set")

SwagSwapOptions.panel:SetScript("OnShow", TitleText)

local myCheckButton = CreateFrame("CheckButton", "myCheckButton_GlobalName", SwagSwapOptions.panel, "ChatConfigCheckButtonTemplate");
myCheckButton:SetPoint("TOPLEFT", 20, -30);
myCheckButton_GlobalNameText:SetText("Enable");
myCheckButton.tooltip = "This will enable or disable all equipment swaps.";
 
 myCheckButton:SetScript("OnClick", 
  function()
    if myCheckButton:GetChecked() then
	ssenable = true
	else
	ssenable = false
	end
  end)
  
local info = {}
 --First Dropdown 
local function SetSelection(button, arg1, arg2)
	UIDropDownMenu_SetText(Mydropdown, arg2)
	ssname = arg2
end 
local Mydropdown = CreateFrame("Frame", "Mydropdown", SwagSwapOptions.panel, "UIDropDownMenuTemplate")
Mydropdown.initialize = function(self, level) end
Mydropdown:SetPoint("TOPRIGHT", -405, -80);

Mydropdown.initialize = function(self, level)
  
	
	if not level then return end
    wipe(info)
    if level == 1 then
		info.text = "None"
		--info.icon = icon
		info.func = SetSelection 
		--info.arg1 = i
		info.arg2 = nil
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		for i = 1, GetNumEquipmentSets() do
		local name, icon, setID, isEquipped, totalItems, equippedItems, inventoryItems, missingItems, ignoredSlots = GetEquipmentSetInfo(i)
		info.text = name
		info.icon = icon
		info.func = SetSelection 
		info.arg1 = i
		info.arg2 = name
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		end
    end
end

--Second Dropdown
local function SecondarySelection(button, arg1, arg2)
	UIDropDownMenu_SetText(Secondary, arg2)
	ssname2 = arg2
end 

local Secondary = CreateFrame("Frame", "Secondary", SwagSwapOptions.panel, "UIDropDownMenuTemplate")
Secondary.initialize = function(self, level) end
Secondary:SetPoint("TOPRIGHT", -275, -80);

Secondary.initialize = function(self, level)
  
	
	if not level then return end
    wipe(info)
    if level == 1 then
		info.text = "None"
		--info.icon = icon
		info.func = SecondarySelection 
		--info.arg1 = i
		info.arg2 = nil
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		for i = 1, GetNumEquipmentSets() do
		local name, icon, setID, isEquipped, totalItems, equippedItems, inventoryItems, missingItems, ignoredSlots = GetEquipmentSetInfo(i)
		info.text = name
		info.icon = icon
		info.func = SecondarySelection 
		info.arg1 = i
		info.arg2 = name
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		end
    end
end
