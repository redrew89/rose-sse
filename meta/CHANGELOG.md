# Lielle 0.5.0 Changelog

* Added first-pass Dawnguard quest awareness, may expand further
* Added reactions to Dawnguard player vampirism and feeding events and cure recognition
* Added reactions to lesser vampirism and feeding events and cure recognition
* Added narrative endpoint for players that repeatedly feed on Lielle as a vampire; beware, you might lose her forever
* Added new falmer/dwarven dungeon location: Mnzeft
* Added new Arcane Research Quest: Field Work
* Added new Arcane Research Quest: Aetherium
* Added new Arcane Research Quest: Blackreach
* Added new Arcane Research Quest: Azura's Star/Black Star
* Note that these research quests do not grant player rewards. I may change this to dispense leveled amounts of gold, in the future.
* Added patchless interaction with I'm Glad You're Here (requires OAR)
* Revised interaction with Sofia to better reflect backstory of both characters, including a new backstory element for Lielle
* Added new combat interrupt behavior when encountering frostbite spiders, including a one-time dialogue
* Removed non-free music resources 
* Removed 'Drew's Doodad' debugging item and accompanying dialogue tree. Now replaced by MCM
* Fixed a file structure oversight that caused a (mostly harmless) file conflict with Ashara Imperial Outfit
* Added scene lines for when the player performs actions that increase Lielle's Affection (eg. Gift of Charity)
* Textual revisions to Lielle's Journal, to reflect additions to backstory, as well as changes to Lielle's rank at the College
* Added new dialogue within Lielle's research topic, and during the College of Winterhold questline
* Retuned the conditions on a number of idles, so they (hopefully) fire less often. Particularly, her "wait up" lines
* Textual revisions on a number of dialogues, to bring the writing style within Bethesda's established style ("Alright" vs "All right")
* Rebalanced Affection changes via dialogue; the amount of affection gained or lost through dialogue has been reduced to less than whole integer amounts, in most cases. This is to prepare for future changes to the Affection framework and other planned content
* Added patchless detection and integration for outfits from West Wind Misfit Mage and Dwemer Researcher Armor; install one or both outfit mods. This feature lets Lielle dynamically change outfits based on weather, location, and specific story events. Finding the Misfit Mage chest is the first event to uncover
* Note that users of the vanilla base body can use the original UNP versions of both outfits, even though the original West Wind Misfit Mage is for Legendary Edition. You can convert it yourself easily with the Creation Kit and Cathedral Asset Optimizer or similar tools.
* Users of the CBBE/3BA base body can use the respective conversions for both outfits. Be sure to use BodySlide to build outfits based on Lielle's provided preset
* Also added patchless support for KS Hairdos - HDT SMP, where the optional wigs plugin is installed. Lielle will now automatically equip her physics-enabled wig at game start
* Also added patchless support for Cloaks and Capes, now Lielle will equip various capes, depending on her chosen outfit, when the weather turns poor
* Note that the outfit feature offers limited player-choice in what outfit Lielle might wear, as well as an option to disable outfit switching and cloak equipping via dialogue. I plan to eventually expand it to player-provided options, for different situations, gated by Affection
* Added patchless support for KS Jewelry SSE, which enhances Lielle's wedding outfit, if installed, as well as KS Hairdos wigs component
* Added expanded outfit detection via keywords distributed by KID. Some outfits are too revealing for Lielle to accept wearing (unless Affection is high enough). Requires Keyword Item Distributor
* Restructured and made slight edits to Lielle's marriage process. She will now require a two-week betrothal before marriage, as a hint for future changes to romance
* Added new story element that gives Lielle enhanced tattoos; now she's complete
* Added an idle reading behavior in certain settings; implementation method borrowed from Ashe - Crystal Heart by Martimus, with permission
* Revised Lielle's follower framework, giving her complete standalone follower behavior. This makes her INCOMPATIBLE with follower framework mods like NFF/EFF/BFF/AFT
* Made further refinements and adjustments to Lielle's follower behavior. She will now automatically sandbox in certain locations while an active follower, as well as ready spells when the player draws weapons
* Implemented a custom home feature for post-marriage. Lielle can now be moved into any valid player home with the correct keywords, delivered by the new quest "A Place To Grow"
* Implemented a new feature to enhance Lielle's expressiveness; Emotion Manager. By interfacing directly with Mfg Fix NG to provide unique expressions in dialogue. System falls back to default dialogue expressions when Mfg Fix NG is not installed, with subtle enhancements
* Minor story and dialogue additions and revisions, including a universal catch for player's who might use Legacy of the Dragonborn; now they won't lose out on an artifact
* Carried over revisions made in 0.4.x to fix scene order issues during the Gauldur Amulet quest commentary
* Added a custom eye part with unique texture variants as part of Emotion Manager
* Added dynamic blush effect as part of Emotion Manager; depends on RaceMenu -- gracefully disables if not present
* Added animated tears effect as part of Emotion Manager; depends on RaceMenu -- gracefully falls back to shader effect method if not present
* Added internal central logging and verbose notifications on start up and for specific events. These notifications can be toggled off in the MCM
* If Papyrus logging is enabled, Lielle will now write to a custom log file for debugging and testing purposes
 