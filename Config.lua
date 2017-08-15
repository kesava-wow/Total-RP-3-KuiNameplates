----------------------------------------------------------------------------------
--- Total RP 3: KuiNameplates
--- Configuration
---    ---------------------------------------------------------------------------
---    Copyright 2017 Renaud "Ellypse" Parize <ellypse@totalrp3.info> @EllypseCelwe
---
---    Licensed under the Apache License, Version 2.0 (the "License");
---    you may not use this file except in compliance with the License.
---    You may obtain a copy of the License at
---
---        http://www.apache.org/licenses/LICENSE-2.0
---
---    Unless required by applicable law or agreed to in writing, software
---    distributed under the License is distributed on an "AS IS" BASIS,
---    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
---    See the License for the specific language governing permissions and
---    limitations under the License.
----------------------------------------------------------------------------------

local TRPKN = select(2, ...);

function TRPKN.initConfig()
	
	TRPKN.CONFIG = {};
	
	local loc = TRP3_API.locale.getText;
	local registerConfigurationPage = TRP3_API.configuration.registerConfigurationPage;
	local registerConfigKey = TRP3_API.configuration.registerConfigKey;
	local registerHandler = TRP3_API.configuration.registerHandler;
	
	TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION = "kui_nameplates_enable";
	TRPKN.CONFIG.DISPLAY_NAMEPLATES_ONLY_IN_CHARACTER = "kui_nameplates_only_in_character";
	TRPKN.CONFIG.USE_CUSTOM_COLOR = "kui_nameplates_use_custom_color";
	TRPKN.CONFIG.INCREASE_CONTRAST = "kui_nameplates_increase_contrast";
	TRPKN.CONFIG.SHOW_TITLES = "kui_nameplates_show_titles";
	TRPKN.CONFIG.HIDE_NON_ROLEPLAY = "kui_nameplates_hide_non_roleplay";
	TRPKN.CONFIG.PET_NAMES = "kui_nameplates_pet_names";
	
	registerConfigKey(TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION, true);
	registerConfigKey(TRPKN.CONFIG.DISPLAY_NAMEPLATES_ONLY_IN_CHARACTER, true);
	registerConfigKey(TRPKN.CONFIG.HIDE_NON_ROLEPLAY, false);
	registerConfigKey(TRPKN.CONFIG.USE_CUSTOM_COLOR, true);
	registerConfigKey(TRPKN.CONFIG.INCREASE_CONTRAST, false);
	registerConfigKey(TRPKN.CONFIG.PET_NAMES, true);
	registerConfigKey(TRPKN.CONFIG.SHOW_TITLES, false);
	
	registerHandler(TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION, TRPKN.refreshAllNameplates);
	registerHandler(TRPKN.CONFIG.DISPLAY_NAMEPLATES_ONLY_IN_CHARACTER, TRPKN.refreshAllNameplates);
	registerHandler(TRPKN.CONFIG.HIDE_NON_ROLEPLAY, TRPKN.refreshAllNameplates);
	registerHandler(TRPKN.CONFIG.USE_CUSTOM_COLOR, TRPKN.refreshAllNameplates);
	registerHandler(TRPKN.CONFIG.INCREASE_CONTRAST, TRPKN.refreshAllNameplates);
	registerHandler(TRPKN.CONFIG.SHOW_TITLES, TRPKN.refreshAllNameplates);
	registerHandler(TRPKN.CONFIG.PET_NAMES, TRPKN.refreshAllNameplates);
	
	-- Build configuration page
	registerConfigurationPage({
		id = "main_config_nameplates",
		menuText = "Kui|cff9966ffNameplates|r",
		pageText = loc("KNP_MODULE"),
		elements = {
			{
				inherit = "TRP3_ConfigCheck",
				title = loc("KNP_ENABLE_CUSTOMIZATION"),
				configKey = TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = loc("KNP_PET_NAMES"),
				configKey = TRPKN.CONFIG.PET_NAMES,
				dependentOnOptions = { TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION },
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = loc("KNP_ONLY_IC"),
				configKey = TRPKN.CONFIG.DISPLAY_NAMEPLATES_ONLY_IN_CHARACTER,
				dependentOnOptions = { TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION },
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = loc("KNP_HIDE_NON_RP"),
				configKey = TRPKN.CONFIG.HIDE_NON_ROLEPLAY,
				help = loc("KNP_HIDE_NON_RP_TT"),
				dependentOnOptions = { TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION },
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = loc("KNP_CUSTOM_COLORS"),
				configKey = TRPKN.CONFIG.USE_CUSTOM_COLOR,
				dependentOnOptions = { TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION },
			},
			-- We'll do that later.
			--{
			--	inherit = "TRP3_ConfigCheck",
			--	title = loc("KNP_INCREASE_CONTRAST"),
			--	configKey = TRPKN.CONFIG.INCREASE_CONTRAST,
			--	dependentOnOptions = { TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION, TRPKN.CONFIG.USE_CUSTOM_COLOR },
			--},
			{
				inherit = "TRP3_ConfigCheck",
				title = loc("KNP_CUSTOM_TITLES"),
				configKey = TRPKN.CONFIG.SHOW_TITLES,
				help = loc("KNP_CUSTOM_TITLES_TT");
				dependentOnOptions = { TRPKN.CONFIG.ENABLE_NAMEPLATES_CUSTOMIZATION },
			},
		}
	});

end