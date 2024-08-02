local E = ElvUI[1]
local DT = E:GetModule("DataTexts")
local displayString = ""
local function createButton(text, func)
    return {
        notCheckable = true,
        colorCode = "|cffffffff",
        text = text,
        func = func,
    }
end
local frame = CreateFrame("Frame", "ElvUI_MicroMenuDTMenu", E.UIParent, "UIDropDownMenuTemplate")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self)
    self.initialize = function()
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(CHARACTER_BUTTON, "TOGGLECHARACTER0"),
            function() ToggleFrame(CharacterFrame) end
        ))
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(SPELLBOOK_ABILITIES_BUTTON, "TOGGLESPELLBOOK"),
            function() ToggleFrame(SpellBookFrame) end
        ))
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(TALENTS_BUTTON, "TOGGLETALENTS"),
            function()
                if UnitLevel("player") >= 10 then
                    if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end
                    ToggleFrame(PlayerTalentFrame)
                end
            end
        ))
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "TOGGLEACHIEVEMENT"),
            function() ToggleAchievementFrame() end
        ))
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(QUESTLOG_BUTTON, "TOGGLEQUESTLOG"),
            function() ToggleQuestLog() end
        ))
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(SOCIAL_BUTTON, "TOGGLESOCIAL"),
            function() ToggleFriendsFrame() end
        ))
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(COLLECTIONS, "TOGGLECOLLECTIONS"),
            function() ToggleCollectionsJournal() end
        ))
        UIDropDownMenu_AddButton {
            notCheckable = true,
            colorCode = TogglePVPUI and "|cffffffff" or "|cff999999",
            text = MicroButtonTooltipText(COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP, "TOGGLECHARACTER4"),
            func = function() if TogglePVPUI then TogglePVPUI() end end,
        }
        UIDropDownMenu_AddButton(createButton(
            MicroButtonTooltipText(DUNGEONS_BUTTON, "TOGGLEGROUPFINDER"),
            function() PVEFrame_ToggleFrame() end
        ))
        UIDropDownMenu_AddButton(createButton(
            HELP_BUTTON,
            function() ToggleHelpFrame() end
        ))
    end
    self.displayMode = "MENU"
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

local function onClick(self)
    ToggleDropDownMenu(1, nil, frame, self, 0, -4)
end

local function onEvent(self)
    self.text:SetFormattedText(displayString, MAINMENU_BUTTON)
end

local function applySettings(self, color)
    displayString = strjoin('', color, '%s|r')
end

DT:RegisterDatatext("pluginMicroMenu", nil, nil, onEvent, nil, onClick, nil, nil, "Plugin-" .. MAINMENU_BUTTON, nil,
    applySettings)
