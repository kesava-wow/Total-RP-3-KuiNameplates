----------------------------------------------------------------------------------
--- Total RP 3: KuiNameplates
--- Player nameplates
---	---------------------------------------------------------------------------
---	Copyright 2017 Renaud "Ellypse" Parize <ellypse@totalrp3.info> @EllypseCelwe
---
---	Licensed under the Apache License, Version 2.0 (the "License");
---	you may not use this file except in compliance with the License.
---	You may obtain a copy of the License at
---
---		http://www.apache.org/licenses/LICENSE-2.0
---
---	Unless required by applicable law or agreed to in writing, software
---	distributed under the License is distributed on an "AS IS" BASIS,
---	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
---	See the License for the specific language governing permissions and
---	limitations under the License.
----------------------------------------------------------------------------------

local TRPKN = select(2, ...);

function TRPKN.initPlayerNameplates()

	local getUnitID = TRP3_API.utils.str.getUnitID;
	local unitIDToInfo = TRP3_API.utils.str.unitIDToInfo;
	local unitIDIsKnown = TRP3_API.register.isUnitIDKnown;
	local hasProfile = TRP3_API.register.hasProfile;
	local colorHexaToFloats = TRP3_API.utils.color.hexaToFloat;
	local getConfigValue = TRP3_API.configuration.getValue;
	local getUnitProfile = TRP3_API.register.profileExists;
	local getCompleteName = TRP3_API.register.getCompleteName;
	local crop = TRP3_API.utils.str.crop;
	local loc = TRP3_API.loc;
	local OOC_ICON = "|TInterface\\COMMON\\Indicator-Red:15:15|t";

	local profilesRequestByUnitForThisSession = {}

	local CONFIG_PREFER_OOC_ICON = "tooltip_prefere_ooc_icon";

	local MAX_TITLE_SIZE = 40;

	local function getPlayerData(playerUnitID)
		if not unitIDIsKnown(playerUnitID) then return end

		local unitName = unitIDToInfo(playerUnitID);
		local profile = getUnitProfile(playerUnitID);

		-- Should be impossible but I don't really want to take that chance.
		if not unitName then return end

		local name, title, color, OOC;

		-- If we have more information (sometimes we don't have them yet) we continue
		if profile and profile.characteristics then
			name = getCompleteName(profile.characteristics, unitName, false);
			title = profile.characteristics.FT;
			color = profile.characteristics.CH;
			if profile.character then
				OOC = profile.character.RP ~= 1 ;
			end
		end

		return name, title, color, OOC;
	end

	function TRPKN.modifyPlayerNameplate(nameplate)
		local unitID = getUnitID(nameplate.unit);

		-- If we didn't get a proper unit ID or we don't have any data for this unit ID we can stop here
		if not unitID then
			return
		end;

		if not unitIDIsKnown(unitID) or not hasProfile(unitID) then
			-- We don't know this unit we will try to ask for their profile
			if getConfigValue(TRPKN.CONFIG.ACTIVE_QUERY) and not profilesRequestByUnitForThisSession[unitID] then
				TRP3_API.r.sendQuery(unitID);
				profilesRequestByUnitForThisSession[unitID] = true
			end

			if getConfigValue(TRPKN.CONFIG.HIDE_NON_ROLEPLAY) then
				TRPKN.HideKuiNameplate(nameplate);
			end
			return false;
		end

		local name, title, color, OOC = getPlayerData(unitID);

		if name then
			if getConfigValue(TRPKN.CONFIG.SHOW_OOC_INDICATOR) and OOC then
				name = " " .. name
				if getConfigValue(CONFIG_PREFER_OOC_ICON) == "TEXT" then
					name = strconcat(TRP3_API.Ellyb.ColorManager.RED("[" .. loc.CM_OOC .. "] "), name);
				else
					name = strconcat(OOC_ICON, name);
				end
			end

			nameplate.state.name = name;
			nameplate.NameText:SetText(nameplate.state.name);
		end

		if getConfigValue(TRPKN.CONFIG.SHOW_TITLES) then
			if not nameplate.state.old_guild_text then
				nameplate.state.old_guild_text = nameplate.state.guild_text;
			end
			if title then
				nameplate.state.guild_text = "<" .. crop(title, MAX_TITLE_SIZE) .. ">";
			else
				nameplate.state.guild_text = "";
			end
			nameplate.GuildText:SetText(nameplate.state.guild_text)
		end

		if getConfigValue(TRPKN.CONFIG.HIDE_NON_ROLEPLAY) then
			TRPKN.ShowKuiNameplate(nameplate);
		end

		if color and getConfigValue(TRPKN.CONFIG.USE_CUSTOM_COLOR) then
			local r, g, b = colorHexaToFloats(color);
			nameplate.NameText:SetTextColor(r, g, b)
		end
	end

	TRP3_API.events.listenToEvent(TRP3_API.events.WORKFLOW_ON_LOADED, function()
		TRP3_API.configuration.registerHandler(CONFIG_PREFER_OOC_ICON, TRPKN.refreshAllNameplates);
	end)
end
