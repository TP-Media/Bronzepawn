-- BronzePawn created by MeuchelManni
-- 
-- © 2006-2010 MeuchelManni.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.
--
-- User interface code
------------------------------------------------------------



------------------------------------------------------------
-- Globals
------------------------------------------------------------

BronzePawnUICurrentScale = nil
BronzePawnUICurrentTabNumber = nil
BronzePawnUICurrentListIndex = 0
BronzePawnUICurrentStatIndex = 0

-- An array with indices 1 and 2 for the left and right compare items, respectively; each one is of the type returned by GetItemData.
local BronzePawnUIComparisonItems = {}
-- An array with indices 1 and 2 for the first and second left side shortcut items.
local BronzePawnUIShortcutItems = {}

local BronzePawnUITotalScaleLines = 0
local BronzePawnUITotalComparisonLines = 0
local BronzePawnUITotalGemLines = 0

------------------------------------------------------------
-- "Constants"
------------------------------------------------------------

local BronzePawnUIScaleLineHeight = 16 -- each scale line is 16 pixels tall
local BronzePawnUIScaleSelectorPaddingBottom = 5 -- add 5 pixels of padding to the bottom of the scrolling area

local BronzePawnUIStatsListHeight = 18 -- the stats list contains 12 items
local BronzePawnUIStatsListItemHeight = 16 -- each item is 16 pixels tall

local BronzePawnUIComparisonLineHeight = 20 -- each comparison line is 20 pixels tall
local BronzePawnUIComparisonAreaPaddingBottom = 10 -- add 10 pixels of padding to the bottom of the scrolling area

local BronzePawnUIGemLineHeight = 17 -- each comparison line is 17 pixels tall
local BronzePawnUIGemAreaPaddingBottom = 0 -- add no padding to the bottom of the scrolling area

local BronzePawnUIFrameNeedsScaleSelector = { true, true, true, true, false, false, false }


-- The 1-based indes of the stat headers for gems.
BronzePawnUIStats_RedSocketIndex = 8
BronzePawnUIStats_YellowSocketIndex = 9
BronzePawnUIStats_BlueSocketIndex = 10
BronzePawnUIStats_MetaSocketIndex = 11
BronzePawnUIStats_MetaSocketEffectIndex = 12
BronzePawnUIStats_SocketBonusBefore = 13




local function BronzePawnUIApplyPhaseOneStyle()
	if BronzePawnUIHeader then BronzePawnUIHeader:SetTextColor(1.0, 0.82, 0.42) end
	if BronzePawnUIFrame_AboutHeaderLabel then BronzePawnUIFrame_AboutHeaderLabel:SetTextColor(1.0, 0.82, 0.42) end
	if BronzePawnInterfaceOptionsFrame_AboutHeaderLabel then BronzePawnInterfaceOptionsFrame_AboutHeaderLabel:SetTextColor(1.0, 0.82, 0.42) end
	if BronzePawnUIFrame_ReadmeLabel then BronzePawnUIFrame_ReadmeLabel:SetTextColor(0.95, 0.88, 0.72) end
	if BronzePawnUIFrame_WebsiteLabel then BronzePawnUIFrame_WebsiteLabel:SetTextColor(0.95, 0.82, 0.48) end
	if BronzePawnUIFrame_GettingStartedLabel then BronzePawnUIFrame_GettingStartedLabel:SetTextColor(0.95, 0.88, 0.72) end
end

------------------------------------------------------------
-- Inventory button
------------------------------------------------------------

-- Moves the BronzePawn inventory sheet button and inspect button to the location specified by the user's current preferences.
function BronzePawnUI_InventoryBronzePawnButton_Move()
	if BronzePawnCommon.ButtonPosition == BronzePawnButtonPositionRight then
		BronzePawnUI_InventoryBronzePawnButton:ClearAllPoints()
		BronzePawnUI_InventoryBronzePawnButton:SetPoint("TOPRIGHT", "CharacterTrinket1Slot", "BOTTOMRIGHT", -1, -8)
		BronzePawnUI_InventoryBronzePawnButton:Show()
		if BronzePawnUI_InspectBronzePawnButton then
			BronzePawnUI_InspectBronzePawnButton:ClearAllPoints()
			BronzePawnUI_InspectBronzePawnButton:SetPoint("TOPRIGHT", "InspectTrinket1Slot", "BOTTOMRIGHT", -1, -8)
			BronzePawnUI_InspectBronzePawnButton:Show()
		end
		if BronzePawnUI_SocketingBronzePawnButton then
			BronzePawnUI_SocketingBronzePawnButton:ClearAllPoints()
			BronzePawnUI_SocketingBronzePawnButton:SetPoint("TOPRIGHT", "ItemSocketingFrame", "TOPRIGHT", -18, -46)
			BronzePawnUI_SocketingBronzePawnButton:Show()
		end
	elseif BronzePawnCommon.ButtonPosition == BronzePawnButtonPositionLeft then
		BronzePawnUI_InventoryBronzePawnButton:ClearAllPoints()
		BronzePawnUI_InventoryBronzePawnButton:SetPoint("TOPLEFT", "CharacterWristSlot", "BOTTOMLEFT", 1, -8)
		BronzePawnUI_InventoryBronzePawnButton:Show()
		if BronzePawnUI_InspectBronzePawnButton then
			BronzePawnUI_InspectBronzePawnButton:ClearAllPoints()
			BronzePawnUI_InspectBronzePawnButton:SetPoint("TOPLEFT", "InspectWristSlot", "BOTTOMLEFT", 1, -8)
			BronzePawnUI_InspectBronzePawnButton:Show()
		end
	else
		BronzePawnUI_InventoryBronzePawnButton:Hide()
		if BronzePawnUI_InspectBronzePawnButton then
			BronzePawnUI_InspectBronzePawnButton:Hide()
		end
		if BronzePawnUI_SocketingBronzePawnButton then
			BronzePawnUI_SocketingBronzePawnButton:Hide()
		end
	end
end

function BronzePawnUI_InventoryBronzePawnButton_OnEnter(this)
	-- Even if there are no scales, we'll at least display this much.
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine("BronzePawn", 1, 1, 1, 1)
	GameTooltip:AddLine(BronzePawnUI_InventoryBronzePawnButton_Tooltip, nil, nil, nil, 1)

	-- If the user has at least one scale and at least one type of value is enabled, calculate a total of all equipped items' values.
	BronzePawnUI_AddInventoryTotalsToTooltip(GameTooltip, "player")
	
	-- Finally, display the tooltip.
	GameTooltip:Show()
end

function BronzePawnUI_InspectBronzePawnButton_OnEnter(this)
	-- Even if there are no scales, we'll at least display this much.
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine("BronzePawn", 1, 1, 1, 1)

	-- If the user has at least one scale and at least one type of value is enabled, calculate a total of all equipped items' values.
	BronzePawnUI_AddInventoryTotalsToTooltip(GameTooltip, "playertarget")
	
	-- Finally, display the tooltip.
	GameTooltip:Show()
end

function BronzePawnUI_SocketingBronzePawnButton_OnEnter(this)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine("BronzePawn", 1, 1, 1, 1)
	GameTooltip:AddLine(BronzePawnUI_SocketingBronzePawnButton_Tooltip)
	
	-- Finally, display the tooltip.
	GameTooltip:Show()
end

function BronzePawnUI_AddInventoryTotalsToTooltip(Tooltip, Unit)
	if BronzePawnCommon.ShowUnenchanted or BronzePawnCommon.ShowEnchanted then
		-- Get the total stats for all items.
		local ItemValues, Count, EpicItemLevel = BronzePawnGetInventoryItemValues(Unit)
		if Count > 0 then
			Tooltip:AddLine(" ")
			Tooltip:AddLine(BronzePawnUI_InventoryBronzePawnButton_Subheader, 1, 1, 1, 1)
			BronzePawnAddValuesToTooltip(Tooltip, ItemValues, true)
			if BronzePawnCommon.AlignNumbersRight then
				Tooltip:AddDoubleLine(BronzePawnLocal.AverageItemLevelTooltipLine,  EpicItemLevel, VgerCore.Color.OrangeR, VgerCore.Color.OrangeG, VgerCore.Color.OrangeB, VgerCore.Color.OrangeR, VgerCore.Color.OrangeG, VgerCore.Color.OrangeB)
			else
				Tooltip:AddLine(BronzePawnLocal.AverageItemLevelTooltipLine .. ":  " .. EpicItemLevel, VgerCore.Color.OrangeR, VgerCore.Color.OrangeG, VgerCore.Color.OrangeB)
			end
		end
	end
end

function BronzePawnUI_InspectBronzePawnButton_Attach()
	-- It's possible that this will happen before the main initialization code, so we need to ensure that the
	-- default BronzePawn options have been set already.  Doing this multiple times is harmless.
	BronzePawnInitializeOptions()

	VgerCore.Assert(InspectPaperDollFrame ~= nil, "InspectPaperDollFrame should be loaded by now!")
	CreateFrame("Button", "BronzePawnUI_InspectBronzePawnButton", InspectPaperDollFrame, "BronzePawnUI_InspectBronzePawnButtonTemplate")
	BronzePawnUI_InspectBronzePawnButton:SetParent(InspectPaperDollFrame)
	BronzePawnUI_InventoryBronzePawnButton_Move()
end

function BronzePawnUI_SocketingBronzePawnButton_Attach()
	-- It's possible that this will happen before the main initialization code, so we need to ensure that the
	-- default BronzePawn options have been set already.  Doing this multiple times is harmless.
	BronzePawnInitializeOptions()

	-- Attach the socketing button.
	VgerCore.Assert(ItemSocketingFrame ~= nil, "ItemSocketingFrame should be loaded by now!")
	CreateFrame("Button", "BronzePawnUI_SocketingBronzePawnButton", ItemSocketingFrame, "BronzePawnUI_SocketingBronzePawnButtonTemplate")
	BronzePawnUI_SocketingBronzePawnButton:SetParent(ItemSocketingFrame)
	BronzePawnUI_InventoryBronzePawnButton_Move()
	
	-- Hook the item update event.
	VgerCore.HookInsecureFunction(ItemSocketingDescription, "SetSocketedItem", BronzePawnUI_OnSocketUpdate)
end

------------------------------------------------------------
-- Scale selector events
------------------------------------------------------------

function BronzePawnUIFrame_ScaleSelector_Refresh()
	-- First, delete the existing scale lines.
	for i = 1, BronzePawnUITotalScaleLines do
		local LineName = "BronzePawnUIScaleLine" .. i
		local Line = getglobal(LineName)
		if Line then Line:Hide() end
		setglobal(LineName, nil)
	end
	BronzePawnUITotalScaleLines = 0

	-- Get a sorted list of scale data and display it all.
	local NewSelectedScale, FirstScale, ScaleData, LastHeader
	for _, ScaleData in pairs(BronzePawnGetAllScalesEx()) do
		local ScaleName = ScaleData.Name
		if ScaleName == BronzePawnUICurrentScale then NewSelectedScale = ScaleName end
		if not FirstScale then FirstScale = ScaleName end
		-- Add the header if necessary.
		if ScaleData.Header ~= LastHeader then
			LastHeader = ScaleData.Header
			BronzePawnUIFrame_ScaleSelector_AddHeaderLine(LastHeader)
		end
		-- Then, list the scale.
		BronzePawnUIFrame_ScaleSelector_AddScaleLine(ScaleName, ScaleData.LocalizedName, ScaleData.IsVisible)
	end
	
	BronzePawnUIScaleSelectorScrollContent:SetHeight(BronzePawnUIScaleLineHeight * BronzePawnUITotalScaleLines + BronzePawnUIScaleSelectorPaddingBottom)

	-- If the scale that they previously selected isn't in the list, or they didn't have a previously-selected
	-- scale, just select the first visible one, or the first one if there's no visible scale.
	BronzePawnUICurrentScale = NewSelectedScale or FirstScale or BronzePawnUINoScale
	BronzePawnUI_HighlightCurrentScale()
	
	-- Also refresh a few other related UI elements.
	BronzePawnUIUpdateHeader()
	BronzePawnUIFrame_ShowScaleCheck_Update()
end

function BronzePawnUIFrame_ScaleSelector_AddHeaderLine(Text)
	local Line = BronzePawnUIFrame_ScaleSelector_AddLineCore(Text)
	Line:Disable()
end

function BronzePawnUIFrame_ScaleSelector_AddScaleLine(ScaleName, LocalizedName, IsActive)
	local ColoredName
	--if IsActive then
	--	ColoredName = BronzePawnGetScaleColor(ScaleName) .. ScaleName
	--else
		ColoredName = LocalizedName
	--end
	local Line = BronzePawnUIFrame_ScaleSelector_AddLineCore(" " .. ColoredName)
	if not IsActive then
		Line:SetNormalFontObject("BronzePawnFontSilver")
	end
	Line.ScaleName = ScaleName
end

function BronzePawnUIFrame_ScaleSelector_AddLineCore(Text)
	BronzePawnUITotalScaleLines = BronzePawnUITotalScaleLines + 1
	local LineName = "BronzePawnUIScaleLine" .. BronzePawnUITotalScaleLines
	local Line = CreateFrame("Button", LineName, BronzePawnUIScaleSelectorScrollContent, "BronzePawnUIFrame_ScaleSelector_ItemTemplate")
	Line:SetPoint("TOPLEFT", BronzePawnUIScaleSelectorScrollContent, "TOPLEFT", 0, -BronzePawnUIScaleLineHeight * (BronzePawnUITotalScaleLines - 1))
	Line:SetText(Text)
	return Line, LineName
end

function BronzePawnUIFrame_ScaleSelector_OnClick(this)
	BronzePawnUI_SelectScale(this.ScaleName)
end

-- Selects a scale in CurrentScaleDropDown.
function BronzePawnUI_SelectScale(ScaleName)
	-- Close popup UI as necessary.
	BronzePawnUIStringDialog:Hide()
	ColorPickerFrame:Hide()
	-- Select the scale.
	BronzePawnUICurrentScale = ScaleName
	BronzePawnUI_HighlightCurrentScale()
	-- After selecting a new scale, update the rest of the UI.
	BronzePawnUIFrame_ShowScaleCheck_Update()
	BronzePawnUIUpdateHeader()
	if BronzePawnUIScalesTabPage:IsVisible() then
		BronzePawnUI_ScalesTab_Refresh()
	end
	if BronzePawnUIValuesTabPage:IsVisible() then
		BronzePawnUI_ValuesTab_Refresh()
	end
	if BronzePawnUICompareTabPage:IsVisible() then
		BronzePawnUI_CompareItems()
	end
	if BronzePawnUIGemsTabPage:IsVisible() then
		BronzePawnUI_ShowBestGems()
	end
end

function BronzePawnUI_HighlightCurrentScale()
	BronzePawnUIFrame_ScaleSelector_HighlightFrame:ClearAllPoints()
	BronzePawnUIFrame_ScaleSelector_HighlightFrame:Hide()
	for i = 1, BronzePawnUITotalScaleLines do
		local LineName = "BronzePawnUIScaleLine" .. i
		local Line = getglobal(LineName)
		if Line and Line.ScaleName == BronzePawnUICurrentScale then
			BronzePawnUIFrame_ScaleSelector_HighlightFrame:SetPoint("TOPLEFT", "BronzePawnUIScaleLine" .. i, "TOPLEFT", 0, 0)
			BronzePawnUIFrame_ScaleSelector_HighlightFrame:Show()
			break
		end
	end
end

------------------------------------------------------------
-- Scales tab events
------------------------------------------------------------

function BronzePawnUI_ScalesTab_Refresh()
	BronzePawnUIFrame_ScaleColorSwatch_Update()
	
	if BronzePawnUICurrentScale ~= BronzePawnUINoScale then
		BronzePawnUIFrame_ScaleNameLabel:SetText(BronzePawnGetScaleColor(BronzePawnUICurrentScale) .. BronzePawnGetScaleLocalizedName(BronzePawnUICurrentScale))
		if BronzePawnScaleIsReadOnly(BronzePawnUICurrentScale) then
			BronzePawnUIFrame_ScaleTypeLabel:SetText(BronzePawnUIFrame_ScaleTypeLabel_ReadOnlyScaleText)
			BronzePawnUIFrame_RenameScaleButton:Disable()
			BronzePawnUIFrame_DeleteScaleButton:Disable()
		else
			BronzePawnUIFrame_ScaleTypeLabel:SetText(BronzePawnUIFrame_ScaleTypeLabel_NormalScaleText)
			BronzePawnUIFrame_RenameScaleButton:Enable()
			BronzePawnUIFrame_DeleteScaleButton:Enable()
		end
		BronzePawnUIFrame_CopyScaleButton:Enable()
		BronzePawnUIFrame_ExportScaleButton:Enable()
	else
		BronzePawnUIFrame_ScaleNameLabel:SetText(BronzePawnUINoScale)
		BronzePawnUIFrame_CopyScaleButton:Disable()
		BronzePawnUIFrame_RenameScaleButton:Disable()
		BronzePawnUIFrame_DeleteScaleButton:Disable()
		BronzePawnUIFrame_ExportScaleButton:Disable()
	end
end

------------------------------------------------------------
-- Values tab events
------------------------------------------------------------

function BronzePawnUI_ValuesTab_Refresh()
	BronzePawnUIFrame_StatsList_Update()
	BronzePawnUIFrame_StatsList_SelectStat(BronzePawnUICurrentStatIndex)
	local Scale
	if BronzePawnUICurrentScale ~= BronzePawnUINoScale then Scale = BronzePawnCommon.Scales[BronzePawnUICurrentScale] end
	
	if BronzePawnUICurrentScale == BronzePawnUINoScale then
		BronzePawnUIFrame_ValuesWelcomeLabel:SetText(BronzePawnUIFrame_ValuesWelcomeLabel_NoScalesText)
	elseif BronzePawnScaleIsReadOnly(BronzePawnUICurrentScale) then
		BronzePawnUIFrame_ValuesWelcomeLabel:SetText(BronzePawnUIFrame_ValuesWelcomeLabel_ReadOnlyScaleText)
		BronzePawnUIFrame_NormalizeValuesCheck:Disable()
	else
		BronzePawnUIFrame_ValuesWelcomeLabel:SetText(BronzePawnUIFrame_ValuesWelcomeLabel_NormalText)
		BronzePawnUIFrame_NormalizeValuesCheck:Enable()
	end
	if Scale then
		BronzePawnUIFrame_NormalizeValuesCheck:SetChecked(Scale.NormalizationFactor and Scale.NormalizationFactor > 0)
		BronzePawnUIFrame_NormalizeValuesCheck:Show()
	else
		BronzePawnUIFrame_NormalizeValuesCheck:Hide()
	end
end

function BronzePawnUIFrame_ImportScaleButton_OnClick()
	BronzePawnUIImportScale()
end

function BronzePawnUIFrame_NewScaleButton_OnClick()
	BronzePawnUIGetString(BronzePawnLocal.NewScaleEnterName, "", BronzePawnUIFrame_NewScale_OnOK)
end

function BronzePawnUIFrame_NewScale_OnOK(NewScaleName)
	-- Does this scale already exist?
	if NewScaleName == BronzePawnUINoScale then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleEnterName, "", BronzePawnUIFrame_NewScale_OnOK)
		return
	elseif strfind(NewScaleName, "\"") then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleNoQuotes, NewScaleName, BronzePawnUIFrame_NewScale_OnOK)
	elseif BronzePawnDoesScaleExist(NewScaleName) then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleDuplicateName, NewScaleName, BronzePawnUIFrame_NewScale_OnOK)
		return
	end
	
	-- Add and select the scale.
	BronzePawnAddEmptyScale(NewScaleName)
	BronzePawnUIFrame_ScaleSelector_Refresh()
	BronzePawnUI_SelectScale(NewScaleName)
	BronzePawnUISwitchToTab(BronzePawnUIValuesTabPage)
end

function BronzePawnUIFrame_NewScaleFromDefaultsButton_OnClick()
	BronzePawnUIGetString(BronzePawnLocal.NewScaleEnterName, "", BronzePawnUIFrame_NewScaleFromDefaults_OnOK)
end

function BronzePawnUIFrame_NewScaleFromDefaults_OnOK(NewScaleName)
	-- Does this scale already exist?
	if NewScaleName == BronzePawnUINoScale then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleEnterName, "", BronzePawnUIFrame_NewScaleFromDefaults_OnOK)
		return
	elseif strfind(NewScaleName, "\"") then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleNoQuotes, NewScaleName, BronzePawnUIFrame_NewScaleFromDefaults_OnOK)
	elseif BronzePawnDoesScaleExist(NewScaleName) then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleDuplicateName, NewScaleName, BronzePawnUIFrame_NewScaleFromDefaults_OnOK)
		return
	end
	
	-- Add and select the scale.
	BronzePawnAddDefaultScale(NewScaleName)
	BronzePawnUIFrame_ScaleSelector_Refresh()
	BronzePawnUI_SelectScale(NewScaleName)
	BronzePawnUISwitchToTab(BronzePawnUIValuesTabPage)
end

function BronzePawnUIFrame_ExportScaleButton_OnClick()
	BronzePawnUIExportScale(BronzePawnUICurrentScale)
end

function BronzePawnUIFrame_RenameScaleButton_OnClick()
	BronzePawnUIGetString(format(BronzePawnLocal.RenameScaleEnterName, BronzePawnUICurrentScale), BronzePawnUICurrentScale, BronzePawnUIFrame_RenameScale_OnOK)
end

function BronzePawnUIFrame_CopyScaleButton_OnClick()
	BronzePawnUIGetString(format(BronzePawnLocal.CopyScaleEnterName, BronzePawnGetScaleLocalizedName(BronzePawnUICurrentScale)), "", BronzePawnUIFrame_CopyScale_OnOK)
end

-- Shows a dialog where the user can copy a scale tag for a given scale to the clipboard.
-- Immediately returns true if successful, or false if not.
function BronzePawnUIExportScale(ScaleName)
	local ScaleTag = BronzePawnGetScaleTag(ScaleName)
	if ScaleTag then
		BronzePawnUIShowCopyableString(format(BronzePawnLocal.ExportScaleMessage, BronzePawnGetScaleLocalizedName(BronzePawnUICurrentScale)), ScaleTag)
		return true
	else
		return false
	end
end

-- Exports all custom scales as a series of scale tags.
function BronzePawnUIExportAllScales()
	local ScaleTags, ScaleName, Scale
	ScaleTags = ""
	for ScaleName in pairs(BronzePawnCommon.Scales) do
		if not BronzePawnScaleIsReadOnly(ScaleName) then ScaleTags = ScaleTags .. BronzePawnGetScaleTag(ScaleName) .. "    " end
	end
	if ScaleTags and ScaleTags ~= "" then
		BronzePawnUIShowCopyableString(BronzePawnLocal.ExportAllScalesMessage, ScaleTags)
		return true
	else
		return false
	end
end

-- Shows a dialog where the user can paste a scale tag from the clipboard.
-- Immediately returns.
function BronzePawnUIImportScale()
	BronzePawnUIGetString(BronzePawnLocal.ImportScaleMessage, "", BronzePawnUIImportScaleCallback)
end

-- Callback function for BronzePawnUIImportScale.
function BronzePawnUIImportScaleCallback(ScaleTag)
	-- Try to import the scale.  If successful, we don't need to do anything else.
	local Status, ScaleName = BronzePawnImportScale(ScaleTag, true) -- allow overwriting a scale with the same name
	if Status == BronzePawnImportScaleResultSuccess then
		if BronzePawnUIFrame_ScaleSelector_Refresh then
			-- Select the new scale if the UI is up.
			BronzePawnUIFrame_ScaleSelector_Refresh()
			BronzePawnUI_SelectScale(ScaleName)
			BronzePawnUISwitchToTab(BronzePawnUIValuesTabPage)
		end
		return
	end
	
	-- If there was a problem, show an error message or reshow the dialog as appropriate.
	if Status == BronzePawnImportScaleResultAlreadyExists then
		VgerCore.Message(VgerCore.Color.Salmon .. format(BronzePawnLocal.ImportScaleAlreadyExistsMessage, ScaleName))
		return
	end
	if Status == BronzePawnImportScaleResultTagError then
		-- Don't use the tag that was pasted as the default value; it makes it harder to paste.
		BronzePawnUIGetString(BronzePawnLocal.ImportScaleTagErrorMessage, "", BronzePawnUIImportScaleCallback)
		return
	end
	
	VgerCore.Fail("Unexpected BronzePawnImportScaleResult value: " .. tostring(Status))
end

function BronzePawnUIFrame_RenameScale_OnOK(NewScaleName)
	-- Did they change anything?
	if NewScaleName == BronzePawnUICurrentScale then return end
	
	-- Does this scale already exist?
	if NewScaleName == BronzePawnUINoScale then
		BronzePawnUIGetString(format(BronzePawnLocal.RenameScaleEnterName, BronzePawnUICurrentScale), BronzePawnUICurrentScale, BronzePawnUIFrame_RenameScale_OnOK)
		return
	elseif strfind(NewScaleName, "\"") then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleNoQuotes, NewScaleName, BronzePawnUIFrame_RenameScale_OnOK)
	elseif BronzePawnDoesScaleExist(NewScaleName) then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleDuplicateName, BronzePawnUICurrentScale, BronzePawnUIFrame_RenameScale_OnOK)
		return
	end
	
	-- Rename and select the scale.
	BronzePawnRenameScale(BronzePawnUICurrentScale, NewScaleName)
	BronzePawnUIFrame_ScaleSelector_Refresh()
	BronzePawnUI_SelectScale(NewScaleName)
end

function BronzePawnUIFrame_CopyScale_OnOK(NewScaleName)
	-- Does this scale already exist?
	if NewScaleName == BronzePawnUINoScale then
		BronzePawnUIGetString(BronzePawnLocal.CopyScaleEnterName, "", BronzePawnUIFrame_CopyScale_OnOK)
		return
	elseif strfind(NewScaleName, "\"") then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleNoQuotes, NewScaleName, BronzePawnUIFrame_CopyScale_OnOK)
	elseif BronzePawnDoesScaleExist(NewScaleName) then
		BronzePawnUIGetString(BronzePawnLocal.NewScaleDuplicateName, NewScaleName, BronzePawnUIFrame_CopyScale_OnOK)
		return
	end
	
	-- Create the new scale.
	BronzePawnDuplicateScale(BronzePawnUICurrentScale, NewScaleName)
	BronzePawnUIFrame_ScaleSelector_Refresh()
	BronzePawnUI_SelectScale(NewScaleName)
	BronzePawnUISwitchToTab(BronzePawnUIValuesTabPage)
end

function BronzePawnUIFrame_DeleteScaleButton_OnClick()
	if IsShiftKeyDown() then
		-- If the user held down the shift key when clicking the Delete button, just do it immediately.
		BronzePawnUIFrame_DeleteScaleButton_OnOK(DELETE_ITEM_CONFIRM_STRING)
	else
		BronzePawnUIGetString(format(BronzePawnLocal.DeleteScaleConfirmation, BronzePawnUICurrentScale, DELETE_ITEM_CONFIRM_STRING), "", BronzePawnUIFrame_DeleteScaleButton_OnOK)
	end
end

function BronzePawnUIFrame_DeleteScaleButton_OnOK(ConfirmationText)
	-- If they didn't type "DELETE" (ignoring case), just exit.
	if strlower(ConfirmationText) ~= strlower(DELETE_ITEM_CONFIRM_STRING) then return end
	
	BronzePawnDeleteScale(BronzePawnUICurrentScale)
	BronzePawnUICurrentScale = nil
	BronzePawnUIFrame_ScaleSelector_Refresh()
	BronzePawnUI_ScalesTab_Refresh()
end

function BronzePawnUIFrame_StatsList_Update()
	if not BronzePawnStats then return end
	
	-- First, update the control and get our new offset.
	FauxScrollFrame_Update(BronzePawnUIFrame_StatsList, #BronzePawnStats, BronzePawnUIStatsListHeight, BronzePawnUIStatsListItemHeight) -- list, number of items, number of items visible per page, item height
	local Offset = FauxScrollFrame_GetOffset(BronzePawnUIFrame_StatsList)
	
	-- Then, update the list items as necessary.
	local ThisScale
	if BronzePawnUICurrentScale ~= BronzePawnUINoScale then ThisScale = BronzePawnGetAllStatValues(BronzePawnUICurrentScale) end
	local i
	for i = 1, BronzePawnUIStatsListHeight do
		local Index = i + Offset
		BronzePawnUIFrame_StatsList_UpdateStatItem(i, Index, ThisScale)
	end
	
	-- After the user scrolled, we need to adjust their selection.
	BronzePawnUIFrame_StatsList_MoveHighlight()
	
end

-- Updates a single stat in the list based on its index into the BronzePawnStats table.
function BronzePawnUIFrame_StatsList_UpdateStat(Index)
	local Offset = FauxScrollFrame_GetOffset(BronzePawnUIFrame_StatsList)
	local i = Index - Offset
	if i <= 0 or i > BronzePawnUIStatsListHeight then return end
	
	BronzePawnUIFrame_StatsList_UpdateStatItem(i, Index, BronzePawnGetAllStatValues(BronzePawnUICurrentScale))	
end

-- Updates a single stat in the list.
function BronzePawnUIFrame_StatsList_UpdateStatItem(i, Index, ThisScale)
	local Title = BronzePawnStats[Index][1]
	local ThisStat = BronzePawnStats[Index][2]
	local Line = getglobal("BronzePawnUIFrame_StatsList_Item" .. i)
	
	if Index <= #BronzePawnStats then
		if not ThisStat then
			-- This is a header row.
			Line:SetText(Title)
			Line:Disable()
		elseif ThisScale and ThisScale[ThisStat] then
			-- This is a stat that's in the current scale.
			Line:SetText("  " .. Title .. " = " .. format("%g", ThisScale[ThisStat]))
			Line:SetNormalFontObject("GameFontHighlight")
			Line:Enable()
		else
			-- This is a stat that's not in the current scale.
			Line:SetText("  " .. Title)
			Line:SetNormalFontObject("BronzePawnFontSilver")
			Line:Enable()
		end
		Line:Show()
	else
		Line:Hide()
	end
end

-- Adjusts BronzePawnUICurrentListIndex and the position of the highlight based on BronzePawnUICurrentStatIndex.
function BronzePawnUIFrame_StatsList_MoveHighlight()
	-- If no stat is selected, just hide the highlight.
	if not BronzePawnUICurrentStatIndex or BronzePawnUICurrentStatIndex == 0 then
		BronzePawnUICurrentListIndex = 0
		BronzePawnUIFrame_StatsList_HighlightFrame:Hide()
		return
	end
	
	-- Otherwise, see if we need to draw a highlight.  If the selected stat isn't visible, we shouldn't draw anything.
	local Offset = FauxScrollFrame_GetOffset(BronzePawnUIFrame_StatsList)
	local i = BronzePawnUICurrentStatIndex - Offset
	if i <= 0 or i > BronzePawnUIStatsListHeight then
		BronzePawnUICurrentListIndex = 0
		BronzePawnUIFrame_StatsList_HighlightFrame:Hide()
		return
	end
	
	-- If we made it this far, then we need to draw a highlight.
	BronzePawnUICurrentListIndex = i
	BronzePawnUIFrame_StatsList_HighlightFrame:ClearAllPoints()
	BronzePawnUIFrame_StatsList_HighlightFrame:SetPoint("TOPLEFT", "BronzePawnUIFrame_StatsList_Item" .. i, "TOPLEFT", 0, 0)
	BronzePawnUIFrame_StatsList_HighlightFrame:Show()
end

-- This is the click handler for list item #i.
function BronzePawnUIFrame_StatsList_OnClick(i)
	if not i or i <= 0 or i > BronzePawnUIStatsListHeight then return end
	
	local Offset = FauxScrollFrame_GetOffset(BronzePawnUIFrame_StatsList)
	local Index = i + Offset
	
	BronzePawnUIFrame_StatsList_SelectStat(Index)
end

function BronzePawnUIFrame_StatsList_SelectStat(Index)
	-- First, make sure that the stat is in the correct range.
	if not Index or Index < 0 or Index > #BronzePawnStats then
		Index = 0
	end
	
	-- Then, find out what they've clicked on.
	local Title, ThisStat, ThisDescription, ThisPrompt
	if Index > 0 then
		Title = BronzePawnStats[Index][1]
		ThisStat = BronzePawnStats[Index][2]
		if ThisStat then
			-- This is a stat, not a header row.
		else
			-- This is a header row, or empty space.
			Index = 0
		end
	end
	BronzePawnUICurrentStatIndex = Index
		
	-- Show, move, or hide the highlight as appropriate.
	BronzePawnUIFrame_StatsList_MoveHighlight()
	
	-- Finally, change the UI to the right.
	local ThisScale
	if BronzePawnUICurrentScale ~= BronzePawnUINoScale then ThisScale = BronzePawnGetAllStatValues(BronzePawnUICurrentScale) end
	if Index > 0 and ThisScale then
		-- They've selected a stat.
		ThisDescription = BronzePawnStats[Index][3]
		BronzePawnUIFrame_DescriptionLabel:SetText(ThisDescription)
		ThisPrompt = BronzePawnStats[Index][4]
		if ThisPrompt then
			BronzePawnUIFrame_StatNameLabel:SetText(ThisPrompt)
		else
			BronzePawnUIFrame_StatNameLabel:SetText(format(BronzePawnLocal.StatNameText, Title))
		end
		BronzePawnUIFrame_StatNameLabel:Show()
		local ThisScaleValue = ThisScale[ThisStat]
		local ThisScaleValueUneditable = ThisScaleValue
		if not ThisScaleValueUneditable then ThisScaleValueUneditable = "0" end
		if not ThisScaleValue or ThisScaleValue == 0 then ThisScaleValue = "" else ThisScaleValue = tostring(ThisScaleValue) end
		BronzePawnUIFrame_StatValueBox.SettingValue = (BronzePawnUIFrame_StatValueBox:GetText() ~= ThisScaleValue)
		BronzePawnUIFrame_StatValueBox:SetText(ThisScaleValue)
		BronzePawnUIFrame_StatValueLabel:SetText(ThisScaleValueUneditable)
		BronzePawnUIFrame_ScaleSocketOptionsList_UpdateSelection()
	elseif BronzePawnUICurrentScale == BronzePawnUINoScale then
		-- They don't have any scales.
		BronzePawnUIFrame_DescriptionLabel:SetText(BronzePawnLocal.NoScalesDescription)
		BronzePawnUIFrame_StatNameLabel:Hide()
		BronzePawnUIFrame_StatValueBox:Hide()
		BronzePawnUIFrame_StatValueLabel:Hide()
		BronzePawnUIFrame_ClearValueButton:Hide()
		BronzePawnUIFrame_ScaleSocketOptionsList:Hide()
	else
		-- They haven't selected a stat.
		BronzePawnUIFrame_DescriptionLabel:SetText(BronzePawnLocal.NoStatDescription)
		BronzePawnUIFrame_StatNameLabel:Hide()
		BronzePawnUIFrame_StatValueBox:Hide()
		BronzePawnUIFrame_StatValueLabel:Hide()
		BronzePawnUIFrame_ClearValueButton:Hide()
		BronzePawnUIFrame_ScaleSocketOptionsList:Hide()
	end

end

function BronzePawnUIFrame_StatValueBox_OnTextChanged()
	if BronzePawnScaleIsReadOnly(BronzePawnUICurrentScale) then return end
	
	local NewString = gsub(BronzePawnUIFrame_StatValueBox:GetText(), ",", ".")
	local NewValue = tonumber(NewString)
	if NewValue == 0 then NewValue = nil end
	
	if NewValue then
		BronzePawnUIFrame_ClearValueButton:Enable()
	else
		BronzePawnUIFrame_ClearValueButton:Disable()
	end
	
	-- If other code is setting this value, we should ignore this event and not set any values.
	if BronzePawnUIFrame_StatValueBox.SettingValue then
		BronzePawnUIFrame_StatValueBox.SettingValue = false
		return
	end
	BronzePawnSetStatValue(BronzePawnUICurrentScale, BronzePawnStats[BronzePawnUICurrentStatIndex][2], NewValue)
	BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUICurrentStatIndex)
	
	-- If the user edited a non-socket value and smart socketing is on, update the sockets too.
	-- (The socket values were already updated in BronzePawnSetStatValue.)
	if BronzePawnUICurrentStatIndex and
		BronzePawnUICurrentStatIndex ~= BronzePawnUIStats_RedSocketIndex and
		BronzePawnUICurrentStatIndex ~= BronzePawnUIStats_YellowSocketIndex and
		BronzePawnUICurrentStatIndex ~= BronzePawnUIStats_BlueSocketIndex and
		BronzePawnUICurrentStatIndex ~= BronzePawnUIStats_MetaSocketIndex and
		BronzePawnUICurrentStatIndex ~= BronzePawnUIStats_MetaStatsSocketIndex then
		if BronzePawnCommon.Scales[BronzePawnUICurrentScale].SmartGemSocketing then
			BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_RedSocketIndex)
			BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_YellowSocketIndex)
			BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_BlueSocketIndex)
		end
		if BronzePawnCommon.Scales[BronzePawnUICurrentScale].SmartMetaGemSocketing then
			BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_MetaSocketIndex)
		end
	end
end

function BronzePawnUIFrame_ClearValueButton_OnClick()
	BronzePawnUIFrame_StatValueBox:SetText("")
end

function BronzePawnUIFrame_GetCurrentScaleColor()
	local r, g, b
	if BronzePawnUICurrentScale and BronzePawnUICurrentScale ~= BronzePawnUINoScale then r, g, b = VgerCore.HexToRGB(BronzePawnCommon.Scales[BronzePawnUICurrentScale].Color) end
	if not r then
		r, g, b = VgerCore.Color.BlueR, VgerCore.Color.BlueG, VgerCore.Color.BlueB
	end
	return r, g, b
end

function BronzePawnUIFrame_ScaleColorSwatch_OnClick()
	-- Get the color of the current scale.
	local r, g, b = BronzePawnUIFrame_GetCurrentScaleColor()
	ColorPickerFrame.func = BronzePawnUIFrame_ScaleColorSwatch_OnChange
	ColorPickerFrame.cancelFunc = BronzePawnUIFrame_ScaleColorSwatch_OnCancel
	ColorPickerFrame.previousValues = { r, g, b }
	ColorPickerFrame.hasOpacity = false
	ColorPickerFrame:SetColorRGB(r, g, b)
	ColorPickerFrame:SetFrameStrata("HIGH")
	ColorPickerFrame:Show()
end

function BronzePawnUIFrame_ScaleColorSwatch_OnChange()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	BronzePawnUIFrame_ScaleColorSwatch_SetColor(r, g, b)
end

function BronzePawnUIFrame_ScaleColorSwatch_OnCancel(rgb)
	local r, g, b = unpack(rgb)
	BronzePawnUIFrame_ScaleColorSwatch_SetColor(r, g, b)
end

function BronzePawnUIFrame_ScaleColorSwatch_SetColor(r, g, b)
	BronzePawnSetScaleColor(BronzePawnUICurrentScale, VgerCore.RGBToHex(r, g, b))
	BronzePawnUI_ScalesTab_Refresh()
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_ScaleColorSwatch_Update()
	if BronzePawnUICurrentScale ~= BronzePawnUINoScale then
		local r, g, b = BronzePawnUIFrame_GetCurrentScaleColor()
		BronzePawnUIFrame_ScaleColorSwatch_Color:SetTexture(r, g, b)
		BronzePawnUIFrame_ScaleColorSwatch_Label:Show()
		BronzePawnUIFrame_ScaleColorSwatch:Show()
	else
		BronzePawnUIFrame_ScaleColorSwatch_Label:Hide()
		BronzePawnUIFrame_ScaleColorSwatch:Hide()
	end
end

function BronzePawnUIFrame_ShowScaleCheck_Update()
	if BronzePawnUICurrentScale ~= BronzePawnUINoScale then
		BronzePawnUIFrame_ShowScaleCheck:SetChecked(BronzePawnIsScaleVisible(BronzePawnUICurrentScale))
		BronzePawnUIFrame_ShowScaleCheck:Show()
	else
		BronzePawnUIFrame_ShowScaleCheck:Hide()
	end
end

function BronzePawnUIFrame_ShowScaleCheck_OnClick()
	BronzePawnSetScaleVisible(BronzePawnUICurrentScale, BronzePawnUIFrame_ShowScaleCheck:GetChecked())
	BronzePawnUIFrame_ScaleSelector_Refresh()
end

function BronzePawnUIFrame_ScaleSocketOptionsList_SetSelection(Value)
	if BronzePawnUICurrentScale == BronzePawnUINoScale then return end
	if not BronzePawnCommon.Scales[BronzePawnUICurrentScale] then return end
	if BronzePawnUICurrentStatIndex == BronzePawnUIStats_MetaSocketIndex then
		BronzePawnCommon.Scales[BronzePawnUICurrentScale].SmartMetaGemSocketing = Value
	else
		BronzePawnCommon.Scales[BronzePawnUICurrentScale].SmartGemSocketing = Value
	end
	BronzePawnUIFrame_ScaleSocketOptionsList_UpdateSelection()
	-- Changing the socketing option affects scale values, so we'll have to recalculate everything.
	BronzePawnRecalculateScaleTotal(BronzePawnUICurrentScale)
	BronzePawnResetTooltips()
	BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_RedSocketIndex)
	BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_YellowSocketIndex)
	BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_BlueSocketIndex)
	BronzePawnUIFrame_StatsList_UpdateStat(BronzePawnUIStats_MetaSocketIndex)
end

function BronzePawnUIFrame_ScaleSocketOptionsList_UpdateSelection()
	if BronzePawnUICurrentScale == BronzePawnUINoScale then return end
	if not BronzePawnCommon.Scales[BronzePawnUICurrentScale] then return end
	
	local IsReadOnly = BronzePawnScaleIsReadOnly(BronzePawnUICurrentScale)
	local ShowEditingUI = not IsReadOnly
	if (not IsReadOnly) and
		(BronzePawnUICurrentStatIndex == BronzePawnUIStats_RedSocketIndex or
		BronzePawnUICurrentStatIndex == BronzePawnUIStats_YellowSocketIndex or
		BronzePawnUICurrentStatIndex == BronzePawnUIStats_BlueSocketIndex or
		BronzePawnUICurrentStatIndex == BronzePawnUIStats_MetaSocketIndex) then
		local SmartSocketing
		if BronzePawnUICurrentStatIndex == BronzePawnUIStats_MetaSocketIndex then
			SmartSocketing = BronzePawnCommon.Scales[BronzePawnUICurrentScale].SmartMetaGemSocketing
		else
			SmartSocketing = BronzePawnCommon.Scales[BronzePawnUICurrentScale].SmartGemSocketing
		end
		if SmartSocketing then
			ShowEditingUI = false
			BronzePawnUIFrame_ScaleSocketBestRadio:SetChecked(true)
			BronzePawnUIFrame_ScaleSocketCorrectRadio:SetChecked(false)
		else
			BronzePawnUIFrame_ScaleSocketBestRadio:SetChecked(false)
			BronzePawnUIFrame_ScaleSocketCorrectRadio:SetChecked(true)
		end
		BronzePawnUIFrame_ScaleSocketOptionsList:Show()
	else
		BronzePawnUIFrame_ScaleSocketOptionsList:Hide()
	end
	if ShowEditingUI then
		BronzePawnUIFrame_StatValueBox:Show()
		BronzePawnUIFrame_StatValueLabel:Hide()
		BronzePawnUIFrame_ClearValueButton:Show()
	else
		BronzePawnUIFrame_StatValueBox:Hide()
		BronzePawnUIFrame_StatValueLabel:Show()
		BronzePawnUIFrame_ClearValueButton:Hide()
	end
end

function BronzePawnUIFrame_NormalizeValuesCheck_OnClick()
	if BronzePawnUICurrentScale == BronzePawnUINoScale or BronzePawnScaleIsReadOnly(BronzePawnUICurrentScale) then return end
	local Scale = BronzePawnCommon.Scales[BronzePawnUICurrentScale]
	
	if BronzePawnUIFrame_NormalizeValuesCheck:GetChecked() then
		Scale.NormalizationFactor = 1
	else
		Scale.NormalizationFactor = nil
	end
	BronzePawnResetTooltips()
end

------------------------------------------------------------
-- Compare tab
------------------------------------------------------------

-- Initializes the Compare tab if it hasn't already been initialized.
local BronzePawnUI_CompareTabInitialized
function BronzePawnUI_InitCompareTab()
	-- This only needs to be run once.
	if BronzePawnUI_CompareTabInitialized then return end
	BronzePawnUI_CompareTabInitialized = true
	
	-- All the Compare tab needs to do here is clear out the comparison items.  Initializing the dropdown
	-- is actually covered by existing code.
	BronzePawnUI_ClearCompareItems()
end

-- Sets either the left (index 1) or right (index 2) comparison item, using an item link.  If the passed item
-- link is nil, that comparison item is instead cleared out.  Returns true if an item was actually placed in the
-- slot or cleared from the slot.
function BronzePawnUI_SetCompareItem(Index, ItemLink)
	BronzePawnUI_InitCompareTab()
	if Index ~= 1 and Index ~= 2 then
		VgerCore.Fail("Index must be 1 or 2.")
		return
	end
	
	-- Get the item data for this item link; we can't do a comparison without it.
	local Item
	if ItemLink then
		-- If they passed item data instead of an item link, just use that.  Otherwise, get item data from the link.
		if type(ItemLink) == "table" then
			Item = ItemLink
			ItemLink = Item.Link
			if not ItemLink then
				VgerCore.Fail("Second parameter must be an item link or item data from BronzePawnGetItemData.")
				return
			end
		else
			-- Unenchant the item link.
			local UnenchantedLink = BronzePawnUnenchantItemLink(ItemLink)
			if UnenchantedLink then ItemLink = UnenchantedLink end
			Item = BronzePawnGetItemData(ItemLink)
			VgerCore.Assert(Item, "Failed to get item data while setting an comparison item!")
		end
	end
	local ItemName, ItemRarity, ItemEquipLoc, ItemTexture
	local SlotID1, SlotID2
	if ItemLink then
		ItemName, _, ItemRarity, _, _, _, _, _, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink)
		SlotID1, SlotID2 = BronzePawnGetSlotsForItemType(ItemEquipLoc)
	else
		ItemName = BronzePawnUIFrame_VersusHeader_NoItem
		ItemRarity = 0
	end
	
	-- Items that are not equippable cannot be placed in the Compare slots.
	if ItemLink and SlotID1 == nil and SlotID2 == nil then return end
	
	-- Save the item data locally, in case the item is later removed from the main BronzePawn item cache.
	BronzePawnUIComparisonItems[Index] = Item
	
	-- Now, update the item name and icon.
	local Label = getglobal("BronzePawnUICompareItemName" .. Index)
	local Texture = getglobal("BronzePawnUICompareItemIconTexture" .. Index)
	Label:SetText(ItemName)
	-- Workaround: ITEM_QUALITY_COLORS does not have a [7].  :(
	if ItemRarity == 7 then ItemRarity = 6 end
	local Color = ITEM_QUALITY_COLORS[ItemRarity]
	if Color then Label:SetVertexColor(Color.r, Color.g, Color.b) end
	Texture:SetTexture(ItemTexture)
	
	-- If this item is a different type than the existing item, clear out the existing item.
	if ItemLink then
		local OtherIndex
		if Index == 1 then OtherIndex = 2 else OtherIndex = 1 end
		if BronzePawnUIComparisonItems[OtherIndex] then
			_, _, _, _, _, _, _, _, OtherItemEquipLoc = GetItemInfo(BronzePawnUIComparisonItems[OtherIndex].Link)
			local OtherSlotID1, OtherSlotID2 = BronzePawnGetSlotsForItemType(OtherItemEquipLoc)
			if not (
				(SlotID1 == nil and SlotID2 == nil and OtherSlotID1 == nil and OtherSlotID2 == nil) or
				(SlotID1 and (SlotID1 == OtherSlotID1 or SlotID1 == OtherSlotID2)) or
				(SlotID2 and (SlotID2 == OtherSlotID1 or SlotID2 == OtherSlotID2))
			) then
				BronzePawnUI_SetCompareItem(OtherIndex, nil)
			end
		end	
	end
	
	-- Update the item shortcuts.  The item shortcuts appear on the left side, but they're based on what's equipped on
	-- the right side.
	if Index == 2 then
		BronzePawnUI_SetShortcutItemForSlot(1, SlotID1)
		BronzePawnUI_SetShortcutItemForSlot(2, SlotID2)
	end
	
	-- Finally, either compare the two items, or remove the current comparison, whichever is appropriate.
	BronzePawnUI_CompareItems()
	
	-- Return true to indicate success to the caller.
	return true
end

-- Same as BronzePawnUI_SetCompareItem, but shows the BronzePawn Compare UI if not already visible.
function BronzePawnUI_SetCompareItemAndShow(Index, ItemLink)
	if Index ~= 1 and Index ~= 2 then
		VgerCore.Fail("Index must be 1 or 2.")
		return
	end
	if not ItemLink or BronzePawnGetHyperlinkType(ItemLink) ~= "item" then return end
	
	-- Set this as a compare item.
	local Success = BronzePawnUI_SetCompareItem(Index, ItemLink)
	if Success then
		-- Automatically pick a comparison item when possible.
		BronzePawnUI_AutoCompare()
		
		-- If the BronzePawn Compare UI is not visible, show it.
		BronzePawnUIShowTab(BronzePawnUICompareTabPage)
	end
	
	return Success
end

-- If there is an item in slot 2 and nothing in slot 1, and the player has an item equipped in the proper slot, automatically
-- compare the slot 2 item with the equipped item.
function BronzePawnUI_AutoCompare()
	if BronzePawnUIComparisonItems[2] and not BronzePawnUIComparisonItems[1] and (BronzePawnUIShortcutItems[1] or BronzePawnUIShortcutItems[2]) then
		-- Normally, use the first shortcut.  But, if the first shortcut is missing or matches the item just compared, use the second
		-- shortcut item instead.
		local ShortcutToUse = BronzePawnUIShortcutItems[1]
		if (not BronzePawnUIShortcutItems[1]) or (BronzePawnUIShortcutItems[2] and (BronzePawnUIShortcutItems[1].Link == BronzePawnUIComparisonItems[2].Link)) then
			ShortcutToUse = BronzePawnUIShortcutItems[2]
		end
		-- Don't bother with an auto-comparison at all if the best item we found was the same item.
		if ShortcutToUse.Link ~= BronzePawnUIComparisonItems[2].Link then
			BronzePawnUI_SetCompareItem(1, ShortcutToUse)
		end
	end
end

-- Tries to set one of the compare items based on what the user is currently hovering over.  Meant for keybindings.
function BronzePawnUI_SetCompareFromHover(Index)
	BronzePawnUI_SetCompareItemAndShow(Index, BronzePawnLastHoveredItem)
end

-- Enables or disables one of the "currently equipped" shortcut buttons based on an inventory slot ID.  If there is an item in that
-- slot, that item will appear in the shortcut button.  If not, or if Slot is nil, that shortcut button will be hidden.
function BronzePawnUI_SetShortcutItemForSlot(ShortcutIndex, Slot)
	if ShortcutIndex ~= 1 and ShortcutIndex ~= 2 then
		VgerCore.Fail("ShortcutIndex must be 1 or 2.")
		return
	end

	-- Find the currently equipped inventory item, and save it for later.
	local ButtonName = "BronzePawnUICompareItemShortcut" .. ShortcutIndex
	local ShortcutButton = getglobal(ButtonName)
	local CurrentlyEquippedItem
	if Slot then CurrentlyEquippedItem = BronzePawnGetItemDataForInventorySlot(Slot, true) end
	BronzePawnUIShortcutItems[ShortcutIndex] = CurrentlyEquippedItem
	
	-- Now, update the button.
	if CurrentlyEquippedItem then
		-- There is a currently equipped item to put in this slot; get information about it.
		local Texture = getglobal(ButtonName .. "Texture")
		local _, _, _, _, _, _, _, _, _, ItemTexture = GetItemInfo(CurrentlyEquippedItem.Link)
		Texture:SetTexture(ItemTexture)
		ShortcutButton:Show()
	else
		ShortcutButton:Hide()
	end
end

-- Clears both comparison items and all comparison data.
function BronzePawnUI_ClearCompareItems()
	BronzePawnUI_SetCompareItem(1, nil)
	BronzePawnUI_SetCompareItem(2, nil)
end

-- Swaps the left and right comparison items.
function BronzePawnUI_SwapCompareItems()
	local Item1, Item2 = BronzePawnUIComparisonItems[1], BronzePawnUIComparisonItems[2]
	PlaySound("igMainMenuOptionCheckBoxOn")
	-- Set the right item to nil first so that unnecessary comparisons aren't performed.
	BronzePawnUI_SetCompareItem(2, nil)
	BronzePawnUI_SetCompareItem(1, Item2)
	BronzePawnUI_SetCompareItem(2, Item1)
end

-- Performs an item comparison.  If the item in either index 1 or index 2 is currently empty, no
-- item comparison is made and the function silently exits.
function BronzePawnUI_CompareItems()
	-- Before doing anything else, clear out the existing comparison data.
	BronzePawnUICompareItemScore1:SetText("")
	BronzePawnUICompareItemScore2:SetText("")
	BronzePawnUICompareItemScoreDifference1:SetText("")
	BronzePawnUICompareItemScoreDifference2:SetText("")
	BronzePawnUICompareItemScoreHighlight1:Hide()
	BronzePawnUICompareItemScoreHighlight2:Hide()
	BronzePawnUICompareItemScoreArrow1:Hide()
	BronzePawnUICompareItemScoreArrow2:Hide()
	BronzePawnUIFrame_CompareSwapButton:Hide()
	BronzePawnUI_DeleteComparisonLines()
	
	-- There must be a scale selected to perform a comparison.
	BronzePawnUI_EnsureLoaded()
	if (not BronzePawnUICurrentScale) or (BronzePawnUICurrentScale == BronzePawnUINoScale) then return end

	-- There must be two valid comparison items set to perform a comparison.
	local Item1, Item2 = BronzePawnUIComparisonItems[1], BronzePawnUIComparisonItems[2]
	if Item1 or Item2 then BronzePawnUIFrame_CompareSwapButton:Show() end
	if (not Item1) or (not Item2) then return end

	-- We have two comparison items set.  Do the compare!
	local ItemStats1 = Item1.UnenchantedStats
	local ItemSocketBonusStats1 = Item1.UnenchantedSocketBonusStats
	local ItemStats2 = Item2.UnenchantedStats
	local ItemSocketBonusStats2 = Item2.UnenchantedSocketBonusStats
	local ThisScale = BronzePawnCommon.Scales[BronzePawnUICurrentScale]
	local ThisScaleValues = ThisScale.Values
	
	-- For items that have socket bonuses, we actually go through the list twice -- the first loop goes until we get to
	-- the place in the list where the socket bonus should be displayed, and then we pause the first loop and go into
	-- the second loop.  Once the second loop completes, we return to the first loop and finish it.
	if (not ItemStats1) or (not ItemStats2) then return end
	local CurrentItemStats1, CurrentItemStats2 = ItemStats1, ItemStats2
	local InSocketBonusLoop
	local FinishedSocketBonusLoop
	
	local StatCount = #BronzePawnStats
	local LastFoundHeader
	local i = 1
	while true do
		if i == BronzePawnUIStats_SocketBonusBefore and not FinishedSocketBonusLoop and not InSocketBonusLoop then
			-- If we're still in the outer loop, and we've reached the point in the stat list where socket bonuses should be inserted, enter
			-- the inner loop.
			InSocketBonusLoop = true
			i = 1
			CurrentItemStats1, CurrentItemStats2 = ItemSocketBonusStats1, ItemSocketBonusStats2
			LastFoundHeader = BronzePawnUIFrame_CompareSocketBonusHeader_Text
		elseif i > StatCount then
			if FinishedSocketBonusLoop then
				-- We've finished the outer loop, so exit.
				break
			else
				-- We've finished the inner loop, so return to the outer loop.
				InSocketBonusLoop = nil
				FinishedSocketBonusLoop = true
				i = BronzePawnUIStats_SocketBonusBefore
				if i > StatCount then break end
				CurrentItemStats1, CurrentItemStats2 = ItemStats1, ItemStats2
				LastFoundHeader = nil
			end
		end
		
		local ThisStatInfo = BronzePawnStats[i]
		VgerCore.Assert(ThisStatInfo, "Failed to find stat info at BronzePawnStats[" .. i .. "]")
		local Title, StatName = ThisStatInfo[1], ThisStatInfo[2]
		
		-- Is this a stat header, or an actual stat?
		if StatName then
			-- This is a stat name.  Is this stat present in the scale AND one of the items?
			local StatValue = ThisScaleValues[StatName]
			local Stats1, Stats2 = CurrentItemStats1[StatName], CurrentItemStats2[StatName]
			if StatValue and (Stats1 or Stats2) then
				-- We should show this stat.  Do we need to add a header first?
				if LastFoundHeader then
					BronzePawnUI_AddComparisonHeaderLine(LastFoundHeader)
					LastFoundHeader = nil
				end
				-- Now, add the stat line.
				local StatNameAndValue = Title .. " @ " .. format("%g", StatValue)
				BronzePawnUI_AddComparisonStatLineNumbers(StatNameAndValue, Stats1, Stats2)
			end
		else
			-- This is a header; remember it.  (But, for socket bonuses, ignore all headers.)
			if not InSocketBonusLoop then LastFoundHeader = Title end
		end
		
		-- Increment the counter and continue.
		i = i + 1
		if i > 1000 then
			VgerCore.Fail("Failed to break out of item comparison loop!")
			break
		end
	end
	LastFoundHeader = BronzePawnUIFrame_CompareOtherInfoHeader_Text
	
	-- Add item level information if the user normally has item levels visible.
	local Level1, Level2 = Item1.Level, Item2.Level
	if not Level1 or Level1 <= 1 then Level1 = nil end
	if not Level2 or Level2 <= 1 then Level2 = nil end
	if GetCVar("showItemLevel") == "1" and ((Level1 and Level1 > 0) or (Level2 and Level2 > 0)) then
		if LastFoundHeader then
			BronzePawnUI_AddComparisonHeaderLine(LastFoundHeader)
			LastFoundHeader = nil
		end
		BronzePawnUI_AddComparisonStatLineNumbers(BronzePawnLocal.ItemLevelTooltipLine, Level1, Level2)
	end
	
	-- Add asterisk indicator.
	if BronzePawnCommon.ShowAsterisks ~= BronzePawnShowAsterisksNever then
		local Asterisk1, Asterisk2
		if Item1.UnknownLines then Asterisk1 = BronzePawnUIFrame_CompareAsterisk_Yes end
		if Item2.UnknownLines then Asterisk2 = BronzePawnUIFrame_CompareAsterisk_Yes end
		if Asterisk1 or Asterisk2 then
			if LastFoundHeader then
				BronzePawnUI_AddComparisonHeaderLine(LastFoundHeader)
				LastFoundHeader = nil
			end
			BronzePawnUI_AddComparisonStatLineStrings(BronzePawnUIFrame_CompareAsterisk, Asterisk1, Asterisk2)
		end
	end
	
	-- Update the scrolling stat area's height.
	BronzePawnUI_RefreshCompareScrollFrame()
	
	-- Update the total item score row.
	local ValueFormat = "%." .. BronzePawnCommon.Digits .. "f"
	local r, g, b = VgerCore.HexToRGB(BronzePawnCommon.Scales[BronzePawnUICurrentScale].Color)
	if not r then r, g, b = VgerCore.Color.BlueR, VgerCore.Color.BlueG, VgerCore.Color.BlueB end
	local _, Value1 = BronzePawnGetSingleValueFromItem(Item1, BronzePawnUICurrentScale)
	local _, Value2 = BronzePawnGetSingleValueFromItem(Item2, BronzePawnUICurrentScale)
	local Value1String, Value2String
	if Value1 then Value1String = format(ValueFormat, Value1) else Value1 = 0 end
	if Value2 then Value2String = format(ValueFormat, Value2) else Value2 = 0 end
	if Value1 > 0 then
		BronzePawnUICompareItemScore1:SetText(Value1String)
		BronzePawnUICompareItemScore1:SetVertexColor(r, g, b)
		if Value1 > Value2 then
			BronzePawnUICompareItemScoreDifference1:SetText("(+" .. format(ValueFormat, Value1 - Value2) .. ")")
			BronzePawnUICompareItemScoreHighlight1:Show()
			BronzePawnUICompareItemScoreArrow1:Show()
		end
	end
	if Value2 > 0 then
		BronzePawnUICompareItemScore2:SetText(Value2String)
		BronzePawnUICompareItemScore2:SetVertexColor(r, g, b)
		if Value2 > Value1 then
			BronzePawnUICompareItemScoreDifference2:SetText("(+" .. format(ValueFormat, Value2 - Value1) .. ")")
			BronzePawnUICompareItemScoreHighlight2:Show()
			BronzePawnUICompareItemScoreArrow2:Show()
		end
	end
end

-- Deletes all comparison stat and header lines.
function BronzePawnUI_DeleteComparisonLines()
	for i = 1, BronzePawnUITotalComparisonLines do
		local LineName = "BronzePawnUICompareStatLine" .. i
		local Line = getglobal(LineName)
		if Line then Line:Hide() end
		setglobal(LineName, nil)
		setglobal(LineName .. "Name", nil)
		setglobal(LineName .. "Quantity1", nil)
		setglobal(LineName .. "Quantity2", nil)
		setglobal(LineName .. "Difference1", nil)
		setglobal(LineName .. "Difference2", nil)
	end
	BronzePawnUITotalComparisonLines = 0
	BronzePawnUI_RefreshCompareScrollFrame()
end

-- Adds a stat line to the comparison stat area, passing in the strings to use.
function BronzePawnUI_AddComparisonStatLineStrings(StatNameAndValue, Quantity1, Quantity2, Difference1, Difference2)
	local Line, LineName = BronzePawnUI_AddComparisonLineCore("BronzePawnUICompareStatLineTemplate")
	getglobal(LineName .. "Name"):SetText(StatNameAndValue)	
	getglobal(LineName .. "Quantity1"):SetText(Quantity1)	
	getglobal(LineName .. "Quantity2"):SetText(Quantity2)	
	getglobal(LineName .. "Difference1"):SetText(Difference1)	
	getglobal(LineName .. "Difference2"):SetText(Difference2)	
	Line:Show()
end

-- Adds a stat line to the comparison stat area, passing in the numbers to use.  It is acceptable to use nil for either or both
-- of the numbers.  Differences are calculated automatically.
function BronzePawnUI_AddComparisonStatLineNumbers(StatNameAndValue, Quantity1, Quantity2)
	local QuantityString1 = BronzePawnFormatShortDecimal(Quantity1)
	local QuantityString2 = BronzePawnFormatShortDecimal(Quantity2)
	local Difference1, Difference2
	if not Quantity1 then Quantity1 = 0 end
	if not Quantity2 then Quantity2 = 0 end
	if Quantity1 > Quantity2 then
		Difference1 = "(+" .. BronzePawnFormatShortDecimal(Quantity1 - Quantity2) .. ")"
	elseif Quantity2 > Quantity1 then
		Difference2 = "(+" .. BronzePawnFormatShortDecimal(Quantity2 - Quantity1) .. ")"
	end
	
	BronzePawnUI_AddComparisonStatLineStrings(StatNameAndValue, QuantityString1, QuantityString2, Difference1, Difference2)
end

-- Adds a header line to the comparison stat area.
function BronzePawnUI_AddComparisonHeaderLine(HeaderText)
	local Line, LineName = BronzePawnUI_AddComparisonLineCore("BronzePawnUICompareStatLineHeaderTemplate")
	local HeaderLabel = getglobal(LineName .. "Name")
	HeaderLabel:SetText(HeaderText)
	Line:Show()
end

-- Adds a line to the comparison stat area.
-- Arguments: Template
--	Template: The XML UI template to use when creating the new line.
-- Returns: Line, LineName
--	Line: A reference to the newly added line.
--	LineName: The string name of the newly added line.
function BronzePawnUI_AddComparisonLineCore(Template)
	BronzePawnUITotalComparisonLines = BronzePawnUITotalComparisonLines + 1
	local LineName = "BronzePawnUICompareStatLine" .. BronzePawnUITotalComparisonLines
	local Line = CreateFrame("Frame", LineName, BronzePawnUICompareScrollContent, Template)
	Line:SetPoint("TOPLEFT", BronzePawnUICompareScrollContent, "TOPLEFT", 0, -BronzePawnUIComparisonLineHeight * (BronzePawnUITotalComparisonLines - 1))
	return Line, LineName
end

-- Updates the height of the comparison stat list scroll area's inner frame.  Call this after adding or removing a block of
-- comparison lines to ensure that the scroll area is correct.
function BronzePawnUI_RefreshCompareScrollFrame()
	BronzePawnUICompareScrollContent:SetHeight(BronzePawnUIComparisonLineHeight * BronzePawnUITotalComparisonLines + BronzePawnUIComparisonAreaPaddingBottom)
	if BronzePawnUITotalComparisonLines > 0 then
		BronzePawnUICompareMissingItemInfoFrame:Hide()
		BronzePawnUICompareScrollFrame:Show()
	else
		BronzePawnUICompareScrollFrame:Hide()
		BronzePawnUICompareMissingItemInfoFrame:Show()
	end
end

-- Links an item in chat.
function BronzePawnUILinkItemInChat(Item)
	if not Item then return end
	local EditBox = DEFAULT_CHAT_FRAME.editBox
	if EditBox then
		if not EditBox:IsShown() then
			EditBox:SetText("")
			EditBox:Show()
		end
		EditBox:Insert(Item.Link)
	else
		VgerCore.Fail("Can't insert item link into chat because the edit box was not found.")
	end
end

-- Called when one of the two upper item slots are clicked.
function BronzePawnUICompareItemIcon_OnClick(Index)
	PlaySound("igMainMenuOptionCheckBoxOn")
	
	-- Are they shift-clicking it to insert the item into chat?
	if IsModifiedClick("CHATLINK") then
		BronzePawnUILinkItemInChat(BronzePawnUIComparisonItems[Index])
		return
	end
	
	-- Are they dropping an item from their inventory?
	local InfoType, Info1, Info2 = GetCursorInfo()
	if InfoType == "item" then
		ClearCursor()
		BronzePawnUI_SetCompareItem(Index, Info2)
		if Index == 2 then BronzePawnUI_AutoCompare() end
		return
	end
	
	-- Are they dropping an item from a merchant's inventory?
	if InfoType == "merchant" then
		ClearCursor()
		local ItemLink = GetMerchantItemLink(Info1)
		if not ItemLink then return end
		BronzePawnUI_SetCompareItem(Index, ItemLink)
		if Index == 2 then BronzePawnUI_AutoCompare() end
		return
	end
end

-- Shows the tooltip for an item comparison slot.
function BronzePawnUICompareItemIcon_TooltipOn(Index)
	-- Is there an item set for this slot?
	local Item = BronzePawnUIComparisonItems[Index]
	if Item then
		if Index == 1 then
			GameTooltip:SetOwner(BronzePawnUICompareItemIcon1, "ANCHOR_BOTTOMLEFT")
		elseif Index == 2 then
			GameTooltip:SetOwner(BronzePawnUICompareItemIcon2, "ANCHOR_BOTTOMRIGHT")
		end
		GameTooltip:SetHyperlink(Item.Link)
	end
end

-- Hides the tooltip for an item comparison slot.
function BronzePawnUICompareItemIcon_TooltipOff()
	GameTooltip:Hide()
end

-- Sets the left item to the item depicted in the "currently equipped" shortcut button.
function BronzePawnUICompareItemShortcut_OnClick(ShortcutIndex, Button)
	PlaySound("igMainMenuOptionCheckBoxOn")

	-- Are they shift-clicking it to insert the item into chat?
	if IsModifiedClick("CHATLINK") then
		BronzePawnUILinkItemInChat(BronzePawnUIShortcutItems[ShortcutIndex])
		return
	end
	
	-- Nope; they want to set the compare item.
	local Index = 1
	if Button == "RightButton" then Index = 2 end
	BronzePawnUI_SetCompareItem(Index, BronzePawnUIShortcutItems[ShortcutIndex])
end

-- Shows the tooltip for the shortcut button.
function BronzePawnUICompareItemShortcut_TooltipOn(ShortcutIndex)
	local Item = BronzePawnUIShortcutItems[ShortcutIndex]
	if Item then
		GameTooltip:SetOwner(getglobal("BronzePawnUICompareItemShortcut" .. ShortcutIndex), "ANCHOR_TOPLEFT")
		local UnenchantedLink = BronzePawnUnenchantItemLink(Item.Link)
		if not UnenchantedLink then UnenchantedLink = Item.Link end
		GameTooltip:SetHyperlink(UnenchantedLink)
	end
end

-- Hides the tooltip for the shortcut button.
function BronzePawnUICompareItemShortcut_TooltipOff()
	GameTooltip:Hide()
end

------------------------------------------------------------
-- Gems tab
------------------------------------------------------------

function BronzePawnUI_InitGemsTab()
	-- Each time the gems tab is shown, immediately refresh its contents.
	BronzePawnUI_ShowBestGems()
end

-- When GemQualityDropDown is first shown, initialize it.
local BronzePawnUIFrame_GemQualityDropDown_IsInitialized = false
function BronzePawnUIFrame_GemQualityDropDown_OnShow()
	if BronzePawnUIFrame_GemQualityDropDown_IsInitialized then return end
	BronzePawnUIFrame_GemQualityDropDown_IsInitialized = true

	UIDropDownMenu_SetWidth(BronzePawnUIFrame_GemQualityDropDown, 140)
	BronzePawnUIFrame_GemQualityDropDown_Reset()
end

-- Resets GemQualityDropDown.
function BronzePawnUIFrame_GemQualityDropDown_Reset()
	UIDropDownMenu_Initialize(BronzePawnUIFrame_GemQualityDropDown, BronzePawnUIFrame_GemQualityDropDown_Initialize)
end

-- Function used by the UIDropDownMenu code to initialize GemQualityDropDown.
function BronzePawnUIFrame_GemQualityDropDown_Initialize()
	if BronzePawnUICurrentScale == BronzePawnUINoScale then return end

	
	-- Add the item quality levels to the dropdown.
	local QualityData
	for _, QualityData in pairs(BronzePawnGemQualityLevels) do
		UIDropDownMenu_AddButton({
			func = BronzePawnUIFrame_GemQualityDropDown_ItemClicked,
			value = QualityData[1],
			text = QualityData[2],
		})
	end
end

function BronzePawnUIFrame_GemQualityDropDown_ItemClicked(self)
	local QualityLevel = self.value
	BronzePawnSetGemQualityLevel(BronzePawnUICurrentScale, QualityLevel)
	BronzePawnUI_ShowBestGems()
end

function BronzePawnUIFrame_GemQualityDropDown_SelectQualityLevel(QualityLevel)
	UIDropDownMenu_SetSelectedValue(BronzePawnUIFrame_GemQualityDropDown, QualityLevel)
	
	-- Painfully stupid: manually update the text on the dropdown to handle the case where the
	-- user has just switched scales and the gem quality level needs to be updated.
	local QualityData
	for _, QualityData in pairs(BronzePawnGemQualityLevels) do
		if QualityData[1] == QualityLevel then
			UIDropDownMenu_SetText(BronzePawnUIFrame_GemQualityDropDown, QualityData[2])
			return
		end
	end
end

function BronzePawnUI_ShowBestGems()
	-- Always clear out the existing gems, no matter what happens next.
	BronzePawnUI_DeleteGemLines()
	if not BronzePawnUICurrentScale or BronzePawnUICurrentScale == BronzePawnUINoScale then return end
	
	-- Update the gem list for this scale.
	BronzePawnUIFrame_GemQualityDropDown_SelectQualityLevel(BronzePawnGetGemQualityLevel(BronzePawnUICurrentScale))
	
	-- If no scale is selected, we can't show a gem list.  (This is a valid case!)
	if not BronzePawnScaleBestGems[BronzePawnUICurrentScale] then
		VgerCore.Fail("Failed to build a gem list because no best-gem data was available for this scale.")
		return
	end
	
	-- Otherwise, we're good -- show the gem list.
	local ShownGems = false

	if #(BronzePawnScaleBestGems[BronzePawnUICurrentScale].RedSocket) > 0 then
		BronzePawnUI_AddGemHeaderLine(format(BronzePawnUIFrame_FindGemColorHeader_Text, RED_GEM))
		for _, GemData in pairs(BronzePawnScaleBestGems[BronzePawnUICurrentScale].RedSocket) do
			BronzePawnUI_AddGemLine(GemData.Name, GemData.Texture, GemData.ID)
		end
		ShownGems = true
	end

	if #(BronzePawnScaleBestGems[BronzePawnUICurrentScale].YellowSocket) > 0 then
		BronzePawnUI_AddGemHeaderLine(format(BronzePawnUIFrame_FindGemColorHeader_Text, YELLOW_GEM))
		for _, GemData in pairs(BronzePawnScaleBestGems[BronzePawnUICurrentScale].YellowSocket) do
			BronzePawnUI_AddGemLine(GemData.Name, GemData.Texture, GemData.ID)
		end
		ShownGems = true
	end

	if #(BronzePawnScaleBestGems[BronzePawnUICurrentScale].BlueSocket) > 0 then
		BronzePawnUI_AddGemHeaderLine(format(BronzePawnUIFrame_FindGemColorHeader_Text, BLUE_GEM))
		for _, GemData in pairs(BronzePawnScaleBestGems[BronzePawnUICurrentScale].BlueSocket) do
			BronzePawnUI_AddGemLine(GemData.Name, GemData.Texture, GemData.ID)
		end
		ShownGems = true
	end
	
	if #(BronzePawnScaleBestGems[BronzePawnUICurrentScale].MetaSocket) > 0 then
		BronzePawnUI_AddGemHeaderLine(BronzePawnUIFrame_FindGemColorHeader_Meta_Text)
		for _, GemData in pairs(BronzePawnScaleBestGems[BronzePawnUICurrentScale].MetaSocket) do
			BronzePawnUI_AddGemLine(GemData.Name, GemData.Texture, GemData.ID)
		end
		ShownGems = true
	end
	
	if not ShownGems then
		BronzePawnUI_AddGemHeaderLine(BronzePawnUIFrame_FindGemNoGemsHeader_Text)
	end

	BronzePawnUI_RefreshGemScrollFrame()
end

-- Deletes all gem lines.
function BronzePawnUI_DeleteGemLines()
	for i = 1, BronzePawnUITotalGemLines do
		local LineName = "BronzePawnUIGemLine" .. i
		local Line = getglobal(LineName)
		if Line then Line:Hide() end
		setglobal(LineName, nil)
		setglobal(LineName .. "Icon", nil)
		setglobal(LineName .. "Name", nil)
		setglobal(LineName .. "Highlight", nil)
	end
	BronzePawnUITotalGemLines = 0
	BronzePawnUI_RefreshGemScrollFrame()
end

-- Adds a gem line to the gem list area, passing in the string and icon to use.
function BronzePawnUI_AddGemLine(GemName, Icon, ItemID)
	local Line, LineName = BronzePawnUI_AddGemLineCore("BronzePawnUIGemLineTemplate")
	Line:SetID(ItemID)
	
	-- Prefer data from the BronzePawn cache if available.  It's more up-to-date if the user
	-- has hovered over anything.
	local Item = BronzePawnGetItemData("item:" .. ItemID)
	if Item and Item.Name then
		GemName = Item.Name
		Icon = Item.Texture
	end
	
	getglobal(LineName .. "Name"):SetText(GemName)	
	getglobal(LineName .. "Icon"):SetTexture(Icon)
	Line:Show()
end

-- Adds a header to the gem list area.
function BronzePawnUI_AddGemHeaderLine(Text)
	local Line, LineName = BronzePawnUI_AddGemLineCore("BronzePawnUIGemHeaderLineTemplate")
	getglobal(LineName .. "Name"):SetText(Text)	
	Line:Show()
end

-- Adds a line to the gem list area.
-- Arguments: Template
--	Template: The XML UI template to use when creating the new line.
-- Returns: Line, LineName
--	Line: A reference to the newly added line.
--	LineName: The string name of the newly added line.
function BronzePawnUI_AddGemLineCore(Template)
	BronzePawnUITotalGemLines = BronzePawnUITotalGemLines + 1
	local LineName = "BronzePawnUIGemLine" .. BronzePawnUITotalGemLines
	local Line = CreateFrame("Button", LineName, BronzePawnUIGemScrollContent, Template)
	Line:SetPoint("TOPLEFT", BronzePawnUIGemScrollContent, "TOPLEFT", 0, -BronzePawnUIGemLineHeight * (BronzePawnUITotalGemLines - 1))
	return Line, LineName
end

-- Updates the height of the gem list scroll area's inner frame.  Call this after adding or removing a block of
-- gem lines to ensure that the scroll area is correct.
function BronzePawnUI_RefreshGemScrollFrame()
	BronzePawnUIGemScrollContent:SetHeight(BronzePawnUIGemLineHeight * BronzePawnUITotalGemLines + BronzePawnUIGemAreaPaddingBottom)
end

-- Raised when the user hovers over a gem in the Gems tab.
function BronzePawnUIFrame_GemList_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:SetHyperlink("item:" .. self:GetID())
	BronzePawnUIFrame_GemList_UpdateInfo(self)
end

-- Raised when the user stops hovering over a gem in the Gems tab.
function BronzePawnUIFrame_GemList_OnLeave(self)
	GameTooltip:Hide()
	BronzePawnUIFrame_GemList_UpdateInfo(self)
end

-- Updates the name and icon for a gem in the gem list if necessary.
function BronzePawnUIFrame_GemList_UpdateInfo(self)
	-- If Icon already has a texture set, then we already have item information, so skip this.
	local Icon = getglobal(tostring(self:GetName()) .. "Icon")
	if Icon and not Icon:GetTexture() then
		local Label = getglobal(tostring(self:GetName()) .. "Name")
		local Item = BronzePawnGetItemData("item:" .. self:GetID())
		if BronzePawnRefreshCachedItem(Item) then
			Label:SetText(Item.Name)
			Icon:SetTexture(Item.Texture)
		end
	end
end

-- Raised when the user clicks a gem in the Gems tab.
function BronzePawnUIFrame_GemList_OnClick(self)
	-- Are they shift-clicking it to insert the item into chat?
	if IsModifiedClick("CHATLINK") then
		BronzePawnUILinkItemInChat(BronzePawnGetItemData("item:" .. tostring(self:GetID())))
		return
	end
end

------------------------------------------------------------
-- Options tab
------------------------------------------------------------

-- When the Options tab is first shown, set the values of all of the controls based on the user's settings.
function BronzePawnUIOptionsTabPage_OnShow()
	-- Tooltip options
	BronzePawnUIFrame_ShowItemIDsCheck:SetChecked(BronzePawnCommon.ShowItemID)
	BronzePawnUIFrame_ShowIconsCheck:SetChecked(BronzePawnCommon.ShowTooltipIcons)
	BronzePawnUIFrame_ShowExtraSpaceCheck:SetChecked(BronzePawnCommon.ShowSpace)
	BronzePawnUIFrame_AlignRightCheck:SetChecked(BronzePawnCommon.AlignNumbersRight)
	BronzePawnUIFrame_AsterisksList_UpdateSelection()
	
	-- Calculation options
	BronzePawnUIFrame_DigitsBox:SetText(BronzePawnCommon.Digits)
	BronzePawnUIFrame_UnenchantedValuesCheck:SetChecked(BronzePawnCommon.ShowUnenchanted)
	BronzePawnUIFrame_EnchantedValuesCheck:SetChecked(BronzePawnCommon.ShowEnchanted)
	BronzePawnUIFrame_DebugCheck:SetChecked(BronzePawnCommon.Debug)
	
	-- Other options
	BronzePawnUIFrame_ButtonPositionList_UpdateSelection()
end

function BronzePawnUIFrame_ShowItemIDsCheck_OnClick()
	BronzePawnCommon.ShowItemID = BronzePawnUIFrame_ShowItemIDsCheck:GetChecked() ~= nil
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_ShowIconsCheck_OnClick()
	BronzePawnCommon.ShowTooltipIcons = BronzePawnUIFrame_ShowIconsCheck:GetChecked() ~= nil
	BronzePawnToggleTooltipIcons()
end

function BronzePawnUIFrame_ShowExtraSpaceCheck_OnClick()
	BronzePawnCommon.ShowSpace = BronzePawnUIFrame_ShowExtraSpaceCheck:GetChecked() ~= nil
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_AlignRightCheck_OnClick()
	BronzePawnCommon.AlignNumbersRight = BronzePawnUIFrame_AlignRightCheck:GetChecked() ~= nil
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_AsterisksList_SetSelection(Value)
	BronzePawnCommon.ShowAsterisks = Value
	BronzePawnUIFrame_AsterisksList_UpdateSelection()
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_AsterisksList_UpdateSelection()
	BronzePawnUIFrame_AsterisksAutoRadio:SetChecked(BronzePawnCommon.ShowAsterisks == BronzePawnShowAsterisksNonzero)
	BronzePawnUIFrame_AsterisksAutoNoTextRadio:SetChecked(BronzePawnCommon.ShowAsterisks == BronzePawnShowAsterisksNonzeroNoText)
	BronzePawnUIFrame_AsterisksOffRadio:SetChecked(BronzePawnCommon.ShowAsterisks == BronzePawnShowAsterisksNever)
end

function BronzePawnUIFrame_DigitsBox_OnTextChanged()
	local Digits = tonumber(BronzePawnUIFrame_DigitsBox:GetText())
	if not Digits then Digits = 0 end
	BronzePawnCommon.Digits = Digits
	BronzePawnRecreateAnnotationFormats()
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_UnenchantedValuesCheck_OnClick()
	BronzePawnCommon.ShowUnenchanted = BronzePawnUIFrame_UnenchantedValuesCheck:GetChecked() ~= nil
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_EnchantedValuesCheck_OnClick()
	BronzePawnCommon.ShowEnchanted = BronzePawnUIFrame_EnchantedValuesCheck:GetChecked() ~= nil
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_DebugCheck_OnClick()
	BronzePawnCommon.Debug = BronzePawnUIFrame_DebugCheck:GetChecked() ~= nil
	BronzePawnResetTooltips()
end

function BronzePawnUIFrame_ButtonPositionList_SetSelection(Value)
	BronzePawnCommon.ButtonPosition = Value
	BronzePawnUIFrame_ButtonPositionList_UpdateSelection()
	BronzePawnUI_InventoryBronzePawnButton_Move()
end

function BronzePawnUIFrame_ButtonPositionList_UpdateSelection()
	BronzePawnUIFrame_ButtonRightRadio:SetChecked(BronzePawnCommon.ButtonPosition == BronzePawnButtonPositionRight)
	BronzePawnUIFrame_ButtonLeftRadio:SetChecked(BronzePawnCommon.ButtonPosition == BronzePawnButtonPositionLeft)
	BronzePawnUIFrame_ButtonOffRadio:SetChecked(BronzePawnCommon.ButtonPosition == BronzePawnButtonPositionHidden)
end

------------------------------------------------------------
-- About tab methods
------------------------------------------------------------

function BronzePawnUIAboutTabPage_OnShow()
	local Version = GetAddOnMetadata("BronzePawn", "Version")
	if Version then 
		BronzePawnUIFrame_AboutVersionLabel:SetText(format(BronzePawnUIFrame_AboutVersionLabel_Text, Version))
	end
end

------------------------------------------------------------
-- Item socketing UI
------------------------------------------------------------

function BronzePawnUI_OnSocketUpdate()
	-- Find out what item it is.
	local _, ItemLink = ItemSocketingDescription:GetItem()
	local Item = BronzePawnGetItemData(ItemLink)
	if not Item or not Item.Values then
		VgerCore.Fail("Failed to update the socketing UI because we didn't know what item was in it.")
		return
	end
	if not Item.UnenchantedStats then return end -- Can't do anything interesting if we couldn't get unenchanted item data
	
	-- Add the annotation lines to the tooltip.
	CreateFrame("GameTooltip", "BronzePawnSocketingTooltip", ItemSocketingFrame, "BronzePawnUI_FattyTooltip")
	BronzePawnSocketingTooltip:SetOwner(ItemSocketingFrame, "ANCHOR_NONE")
	BronzePawnSocketingTooltip:SetPoint("TOPLEFT", ItemSocketingFrame, "BOTTOMLEFT", 10, 30)
	BronzePawnSocketingTooltip:SetText("BronzePawn", 1, 1, 1)
	BronzePawnSocketingTooltip:AddLine(BronzePawnUI_ItemSocketingDescription_Header)
	
	for _, Entry in pairs(Item.Values) do
		local ScaleName, UseRed, UseYellow, UseBlue = Entry[1], Entry[4], Entry[5], Entry[6]
		if BronzePawnIsScaleVisible(ScaleName) then
			local Scale = BronzePawnCommon.Scales[ScaleName]
			local ScaleValues = Scale.Values
			local ItemStats = Item.UnenchantedStats
			local TextColor = VgerCore.Color.Blue
			if Scale.Color and strlen(Scale.Color) == 6 then TextColor = "|cff" .. Scale.Color end
			
			-- Count the number of prismatic sockets.  We have to rely on the item socketing UI
			-- for this, because unenchanted items don't have prismatic sockets, and enchanted items
			-- have gems in those sockets.
			local SocketCount = GetNumSockets()
			local PrismaticSockets = 0
			for i = 1, SocketCount do
				if GetSocketTypes(i) == "Socket" then PrismaticSockets = PrismaticSockets + 1 end
			end
			
			local BestGems = ""
			if UseRed or UseYellow or UseBlue then
				-- Use all of a single color.
				local TotalColoredSockets = 0
				if ItemStats.RedSocket then TotalColoredSockets = TotalColoredSockets + ItemStats.RedSocket end
				if ItemStats.YellowSocket then TotalColoredSockets = TotalColoredSockets + ItemStats.YellowSocket end
				if ItemStats.BlueSocket then TotalColoredSockets = TotalColoredSockets + ItemStats.BlueSocket end
				if PrismaticSockets then TotalColoredSockets = TotalColoredSockets + PrismaticSockets end
				BestGems = BronzePawnGetGemListString(TotalColoredSockets, UseRed, UseYellow, UseBlue, ScaleName)
			else
				-- Use the proper colors.
				if PrismaticSockets and PrismaticSockets > 0 then
					-- If there are prismatic sockets, we'll try to merge them with other sockets.
					UseRed, UseYellow, UseBlue = BronzePawnGetBestGemColorsForScale(ScaleName)
				end
				if ItemStats.RedSocket then
					local RedSockets = ItemStats.RedSocket
					if UseRed and not UseYellow and not UseBlue then
						RedSockets = RedSockets + PrismaticSockets
						PrismaticSockets = 0
					end
					if BestGems ~= "" then BestGems = BestGems .. ", " end
					BestGems = BestGems .. BronzePawnGetGemListString(RedSockets, true, false, false, ScaleName)
				end
				if ItemStats.YellowSocket then
					local YellowSockets = ItemStats.YellowSocket
					if not UseRed and UseYellow and not UseBlue then
						YellowSockets = YellowSockets + PrismaticSockets
						PrismaticSockets = 0
					end
					if BestGems ~= "" then BestGems = BestGems .. ", " end
					BestGems = BestGems .. BronzePawnGetGemListString(YellowSockets, false, true, false, ScaleName)
				end
				if ItemStats.BlueSocket then
					local BlueSockets = ItemStats.BlueSocket
					if not UseRed and not UseYellow and UseBlue then
						BlueSockets = BlueSockets + PrismaticSockets
						PrismaticSockets = 0
					end
					if BestGems ~= "" then BestGems = BestGems .. ", " end
					BestGems = BestGems .. BronzePawnGetGemListString(BlueSockets, false, false, true, ScaleName)
				end
				if PrismaticSockets and PrismaticSockets > 0 then
					-- If the prismatic sockets were merged with another color, this will be skipped.
					if BestGems ~= "" then BestGems = BestGems .. ", " end
					BestGems = BestGems .. BronzePawnGetGemListString(PrismaticSockets, UseRed, UseYellow, UseBlue, ScaleName)
				end
			end
			if ItemStats.MetaSocket then
				if BestGems ~= "" then BestGems = BestGems .. ", " end
				BestGems = BestGems .. tostring(ItemStats.MetaSocket) .. " " .. META_GEM
			end
			local TooltipText = TextColor .. BronzePawnGetScaleLocalizedName(ScaleName) .. ":  |r" .. BestGems
			BronzePawnSocketingTooltip:AddLine(TooltipText, 1, 1, 1)
		end
	end
	
	-- Show our annotations tooltip.
	BronzePawnSocketingTooltip:Show()
end

------------------------------------------------------------
-- Interface Options
------------------------------------------------------------

function BronzePawnInterfaceOptionsFrame_OnLoad()
	-- NOTE: If you need anything from BronzePawnCommon in the future, you should call BronzePawnInitializeOptions first.

	-- Register the Interface Options page.
	BronzePawnInterfaceOptionsFrame.name = "BronzePawn"
	InterfaceOptions_AddCategory(BronzePawnInterfaceOptionsFrame)
	-- Update the version display.
	local Version = GetAddOnMetadata("BronzePawn", "Version")
	if Version then 
		BronzePawnInterfaceOptionsFrame_AboutVersionLabel:SetText(format(BronzePawnUIFrame_AboutVersionLabel_Text, Version))
	end
end

------------------------------------------------------------
-- Other BronzePawn UI methods
------------------------------------------------------------

-- Switches to a tab by its Page.
function BronzePawnUISwitchToTab(Tab)
	local TabCount = #BronzePawnUITabList
	if not Tab then
		VgerCore.Fail("You must specify a valid BronzePawn tab.")
		return
	end
	
	-- Hide popup UI.
	BronzePawnUIStringDialog:Hide()
	ColorPickerFrame:Hide()
	
	-- Loop through all tab frames, showing all but the current one.
	local TabNumber
	for i = 1, TabCount do
		local ThisTab = BronzePawnUITabList[i]
		if ThisTab == Tab  then
			ThisTab:Show()
			TabNumber = i
		else
			ThisTab:Hide()
		end
	end
	VgerCore.Assert(TabNumber, "Oh noes, we couldn't find that tab.")
	BronzePawnUICurrentTabNumber = TabNumber
	
	-- Then, update the tabstrip itself.
	VgerCore.Assert(TabNumber, "Couldn't find the tab to show!")
	PanelTemplates_SetTab(BronzePawnUIFrame, TabNumber)
	
	-- Show/hide the scale selector as appropriate.
	if BronzePawnUIFrameNeedsScaleSelector[BronzePawnUICurrentTabNumber] then
		BronzePawnUIScaleSelector:Show()
	else
		BronzePawnUIScaleSelector:Hide()
	end
	
	-- Then, update the header text.
	BronzePawnUIUpdateHeader()
end

function BronzePawnUIUpdateHeader()
	if not BronzePawnUIHeaders[BronzePawnUICurrentTabNumber] then return end
	local ColoredName
	if BronzePawnUICurrentScale and BronzePawnUICurrentScale ~= BronzePawnUINoScale then
		ColoredName = BronzePawnGetScaleColor(BronzePawnUICurrentScale) .. BronzePawnGetScaleLocalizedName(BronzePawnUICurrentScale) .. "|r"
	else
		ColoredName = BronzePawnUINoScale
	end
	BronzePawnUIHeader:SetText(format(BronzePawnUIHeaders[BronzePawnUICurrentTabNumber], ColoredName))
end

-- Switches to a tab and shows the BronzePawn UI if not already visible.
-- If Toggle is true, close the BronzePawn UI if it was already visible on that page.
function BronzePawnUIShowTab(Tab, Toggle)
	if not BronzePawnUIFrame:IsShown() then
		BronzePawnUIShow()
		BronzePawnUISwitchToTab(Tab)
	elseif not Tab:IsShown() then
		PlaySound("igCharacterInfoTab")
		BronzePawnUISwitchToTab(Tab)
	else
		if Toggle then
			BronzePawnUIShow()
		else
			PlaySound("igMainMenuOptionCheckBoxOn")
		end
	end
end

-- Makes sure that all first-open initialization has been performed.
function BronzePawnUI_EnsureLoaded()
	if not BronzePawnUIOpenedYet then
		BronzePawnUIOpenedYet = true
		BronzePawnUIFrame_ScaleSelector_Refresh()
		BronzePawnUIFrame_ShowScaleCheck_Label:SetText(format(BronzePawnUIFrame_ShowScaleCheck_Label_Text, UnitName("player")))
		if not BronzePawnCommon then
			VgerCore.Fail("BronzePawn UI OnShow handler was called before BronzePawnCommon was initialized.")
			BronzePawnUISwitchToTab(BronzePawnUIHelpTabPage)
		elseif not BronzePawnCommon.ShownGettingStarted then
			BronzePawnCommon.ShownGettingStarted = true
			BronzePawnUISwitchToTab(BronzePawnUIHelpTabPage)
		else
			BronzePawnUISwitchToTab(BronzePawnUIValuesTabPage)
		end
	end
	BronzePawnUIApplyPhaseOneStyle()
end

-- Shows a tooltip for a given control if available.
-- The tooltip used will be the string with the name of the control plus "_Tooltip" on the end.
-- The title of the tooltip will be the text on a control with the same name plus "_Label" on the
-- end if available, or otherwise the actual text on the control if there is any.  If the tooltip text
-- OR title is missing, no tooltip is displayed.
function BronzePawnUIFrame_TooltipOn(self)
	local TooltipText = getglobal(self:GetName() .. "_Tooltip")
	if TooltipText then
		local Label
		local FontString = getglobal(self:GetName() .. "_Label")
		if type(FontString) == "string" then
			Label = FontString
		elseif FontString then
			Label = FontString:GetText()
		elseif this.GetText and self:GetText() then
			Label = self:GetText()
		end
		if Label then
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:AddLine(Label, 1, 1, 1, 1)
			GameTooltip:AddLine(TooltipText, nil, nil, nil, 1, 1)
			GameTooltip:Show()
		end
	end
end

-- Hides the game tooltip.
function BronzePawnUIFrame_TooltipOff()
	GameTooltip:Hide()
end

------------------------------------------------------------
-- BronzePawnUIStringDialog methods
------------------------------------------------------------

-- Shows a dialog containing given prompt text, asking the user for a string.
-- Calls OKCallbackFunction with the typed string as the only input if the user clicked OK.
-- Calls CancelCallbackFunction if the user clicked Cancel.
function BronzePawnUIGetString(Prompt, DefaultValue, OKCallbackFunction, CancelCallbackFunction)
	BronzePawnUIGetStringCore(Prompt, DefaultValue, true, OKCallbackFunction, CancelCallbackFunction)
end

-- Shows a dialog with a copyable string.
-- Calls CallbackFunction when the user closes the dialog.
-- Note: Successfully tested with strings of about 900 characters.
function BronzePawnUIShowCopyableString(Prompt, Value, CallbackFunction)
	BronzePawnUIGetStringCore(Prompt, Value, false, CallbackFunction, nil)
end

-- Core function called by BronzePawnUIGetString.
function BronzePawnUIGetStringCore(Prompt, DefaultValue, Cancelable, OKCallbackFunction, CancelCallbackFunction)
	BronzePawnUIStringDialog_PromptText:SetText(Prompt)
	BronzePawnUIStringDialog_TextBox:SetText("") -- Causes the insertion point to move to the end on the next SetText
	BronzePawnUIStringDialog_TextBox:SetText(DefaultValue)
	if Cancelable then
		BronzePawnUIStringDialog_OKButton:Show()
		BronzePawnUIStringDialog_OKButton:SetText(BronzePawnLocal.OKButton)
		BronzePawnUIStringDialog_CancelButton:SetText(BronzePawnLocal.CancelButton)
	else
		BronzePawnUIStringDialog_OKButton:Hide()
		BronzePawnUIStringDialog_CancelButton:SetText(BronzePawnLocal.CloseButton)
	end
	BronzePawnUIStringDialog.OKCallbackFunction = OKCallbackFunction
	BronzePawnUIStringDialog.CancelCallbackFunction = CancelCallbackFunction
	BronzePawnUIStringDialog:Show()
	BronzePawnUIStringDialog_TextBox:SetFocus()
end

-- Cancels the string dialog if it's open.
function BronzePawnUIGetStringCancel()
	if not BronzePawnUIStringDialog:IsVisible() then return end
	BronzePawnUIStringDialog_CancelButton_OnClick()
end

function BronzePawnUIStringDialog_OKButton_OnClick()
	BronzePawnUIStringDialog:Hide()
	if BronzePawnUIStringDialog.OKCallbackFunction then BronzePawnUIStringDialog.OKCallbackFunction(BronzePawnUIStringDialog_TextBox:GetText()) end
end

function BronzePawnUIStringDialog_CancelButton_OnClick()
	BronzePawnUIStringDialog:Hide()
	if BronzePawnUIStringDialog.CancelCallbackFunction then BronzePawnUIStringDialog.CancelCallbackFunction() end
end

function BronzePawnUIStringDialog_TextBox_OnTextChanged()
	if BronzePawnUIStringDialog_TextBox:GetText() ~= "" then
		BronzePawnUIStringDialog_OKButton:Enable()
	else
		BronzePawnUIStringDialog_OKButton:Disable()
	end
end