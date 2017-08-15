----------------------------------------------------------------------------------
--- Total RP 3: KuiNameplates
--- Locales
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

-- Imports
local pairs = pairs;
local getLocale = TRP3_API.locale.getLocale;


local TRP3_KUINAMEPLATES_LOCALE = {};

TRP3_KUINAMEPLATES_LOCALE["enUS"] = {
	KNP_MODULE = "Kui|cff9966ffNameplates|r module",
	KNP_ENABLE_CUSTOMIZATION = "Enable nameplates customizations",
	KNP_ONLY_IC = "Only when in character",
	KNP_HIDE_NON_RP = "Hide non-roleplay nameplates",
	KNP_HIDE_NON_RP_TT = [[Hide nameplates of players who do not have a roleplay profile, so you only see the names of people with a RP profile.

Note: If you have enabled the option ot only enable nameplate customisation when you are In Character, you can quickly switch the Out Of Character to see everyone's name!]],
	KNP_CUSTOM_COLORS = "Use custom colors",
	KNP_INCREASE_CONTRAST = "Increase color contrast",
	KNP_CUSTOM_TITLES = "Show custom titles",
	KNP_CUSTOM_TITLES_TT = "Replace the guild text by the RP title of the player. Be aware that custom titles may be really long and take a lot of space.",
	KNP_PET_NAMES = "Pet names"
}

TRP3_KUINAMEPLATES_LOCALE["frFR"] = {
	KNP_MODULE = "Module pour Kui|cff9966ffNameplates|r",
	KNP_ENABLE_CUSTOMIZATION = "Activer les modifications des barres d'infos",
	KNP_ONLY_IC = "Seulement quand je suis \"Dans le personnage\"",
	KNP_HIDE_NON_RP = "Cacher les noms des joueurs non RP",
	KNP_HIDE_NON_RP_TT = [[Cacher les barres d'infos des joueurs n'ayant pas de profil roleplay, pour ne voir plus que les noms des joueurs avec un profile RP.

Note: Si vous avez activé l'option de modifier les barres d'infos uniquement lorsque vous êtes "dans le personnage", vous pouvez passer de "dans le personnage" à "hors du personnage" pour afficher toutes les barres d'infos à nouveau!]],
	KNP_CUSTOM_COLORS = "Utiliser les couleurs personnalisées",
	KNP_INCREASE_CONTRAST = "Améliorer le contraste des couleurs",
	KNP_CUSTOM_TITLES = "Afficher les titres personnalisés",
	KNP_CUSTOM_TITLES_TT = [[Remplace la ligne du texte de guilde par le titre RP du joueur. Attention, certains titres peuvent être très long et prendre beaucoup de place]],
	KNP_PET_NAMES = "Nom des familiers"
}

function TRPKN.initLocales()
	for localeID, localeStructure in pairs(TRP3_KUINAMEPLATES_LOCALE) do
		local locale = getLocale(localeID);
		for localeKey, text in pairs(localeStructure) do
			locale.localeContent[localeKey] = text;
		end
	end
end