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
	local unitIDIsKnown = TRP3_API.register.isUnitIDKnown;
	local getColorFromHexadecimalCode = TRP3_API.utils.color.getColorFromHexadecimalCode;
	local getConfigValue = TRP3_API.configuration.getValue;
	local getUnitFullName = TRP3_API.r.name;
	local getUnitProfile = TRP3_API.register.profileExists;
	local getCompleteName = TRP3_API.register.getCompleteName;
	local crop = TRP3_API.utils.str.crop;
	
	local MAX_TITLE_SIZE = 40;
	
	local function getPlayerData(playerUnitID)
		local profile = getUnitProfile(playerUnitID);
		
		local name, title, color;
		
		-- If we have more information (sometimes we don't have them yet) we continue
		if profile and profile.characteristics then
			name = getCompleteName(profile.characteristics, getUnitFullName(playerUnitID), false);
			title = profile.characteristics.FT;
			color = profile.characteristics.CH;
		end
		
		return name, title, color;
	end
	
	function TRPKN.modifyPlayerNameplate(nameplate)
		local unitID = getUnitID(nameplate.unit);
		
		-- If we didn't get a proper unit ID or we don't have any data for this unit ID we can stop here
		if not unitID or not unitIDIsKnown(unitID) then
			return
		end;
		
		local name, title, color = getPlayerData(unitID);
		
		if name then
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
			---@type ColorMixin
			color = getColorFromHexadecimalCode(color);
			if getConfigValue(TRPKN.CONFIG.INCREASE_CONTRAST) then
				color:LightenColorUntilItIsReadable();
			end
			nameplate.NameText:SetTextColor(color:GetRGB())
		end
	end
end