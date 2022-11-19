--The name of the mod displayed in the 'mods' screen.
name = "Observer Camera"

--A description of the mod.
description = [[
[Version 1.3.2] - 使用说明：
1. 按下 F9 在默认视角、高空视角、俯视视角间切换；
2. 按下 F10 隐藏/显示游戏HUD；
3. 按下 F11 隐藏/显示自身角色；
4. 按下 O 将视角固定到鼠标指针所在的实体上；
5. 按下 P 将视角固定到鼠标指针所在的位置上；
6. 按下 R 将视角在自身角色和最近选定的实体/位置之间切换；
7. 按下 ↑、↓、← 和 → 调整相机FOV。

For English speakers:
A pure English version for this mod have been uploaded to the Steam-Workshop at
https://steamcommunity.com/sharedfiles/filedetails/?id=1596632143
You can subscribed to the pure English version if you dislike this bilingual version. Sorry for the inconvenience!
]]

--Who wrote this awesome mod?
author = "gcc"

--A version number so you can ask people if they are running an old version of your mod.
version = "1.3.2"

--This lets other players know if your mod is out of date. This typically needs to be updated every time there's a new game update.
api_version = 6
api_version_dst = 10
priority = 0

--Compatible with both the base game and Reign of Giants
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true

--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = false

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = true

--This lets people search for servers with this mod by these tags
server_filter_tags = {}

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
    {
        name = "OBC_INITIAL_VIEW_MODE",
        label = "进入游戏时的初始视角模式",
        hover = "Initial view mode when entering a game.",
        options = {
            {description = "Default - 默认", data = 0},
            {description = "Aerial - 高空", data = 1},
            {description = "Vertical - 俯视", data = 2},
        },
        default = 0,
    },
    {
        name = "OBC_FUNCTION_KEY_1",
        label = "在默认/高空/俯视模式间切换",
        hover = "The key to switch among default/aerial/vertical view mode.",
        options = {
            {description = "F1", data = 282},
            {description = "F2", data = 283},
            {description = "F3", data = 284},
            {description = "F4", data = 285},
            {description = "F5", data = 286},
            {description = "F6", data = 287},
            {description = "F7", data = 288},
            {description = "F8", data = 289},
            {description = "F9", data = 290},
            {description = "F10", data = 291},
            {description = "F11", data = 292},
            {description = "F12", data = 293},
        },
        default = 290,
    },
    {
        name = "OBC_FUNCTION_KEY_2",
        label = "隐藏/显示游戏HUD",
        hover = "The key to hide/show game HUD.",
        options = {
            {description = "F1", data = 282},
            {description = "F2", data = 283},
            {description = "F3", data = 284},
            {description = "F4", data = 285},
            {description = "F5", data = 286},
            {description = "F6", data = 287},
            {description = "F7", data = 288},
            {description = "F8", data = 289},
            {description = "F9", data = 290},
            {description = "F10", data = 291},
            {description = "F11", data = 292},
            {description = "F12", data = 293},
        },
        default = 291,
    },
    {
        name = "OBC_FUNCTION_KEY_3",
        label = "隐藏/显示自身角色",
        hover = "The key to hide/show your character.",
        options = {
            {description = "F1", data = 282},
            {description = "F2", data = 283},
            {description = "F3", data = 284},
            {description = "F4", data = 285},
            {description = "F5", data = 286},
            {description = "F6", data = 287},
            {description = "F7", data = 288},
            {description = "F8", data = 289},
            {description = "F9", data = 290},
            {description = "F10", data = 291},
            {description = "F11", data = 292},
            {description = "F12", data = 293},
        },
        default = 292,
    },
    {
        name = "OBC_SWITCH_KEY_1",
        label = "固定视角到鼠标所指实体",
        hover = "The key to focus the camera on the entity under mouse.",
        options = {
            {description = "R", data = "R"},
            {description = "T", data = "T"},
            {description = "O", data = "O"},
            {description = "P", data = "P"},
            {description = "G", data = "G"},
            {description = "H", data = "H"},
            {description = "J", data = "J"},
            {description = "K", data = "K"},
            {description = "L", data = "L"},
            {description = "Z", data = "Z"},
            {description = "X", data = "X"},
            {description = "C", data = "C"},
            {description = "V", data = "V"},
            {description = "B", data = "B"},
            {description = "N", data = "N"},
        },
        default = "O",
    },
    {
        name = "OBC_SWITCH_KEY_2",
        label = "固定视角到鼠标所指位置",
        hover = "The key to focus the camera on the position under mouse.",
        options = {
            {description = "R", data = "R"},
            {description = "T", data = "T"},
            {description = "O", data = "O"},
            {description = "P", data = "P"},
            {description = "G", data = "G"},
            {description = "H", data = "H"},
            {description = "J", data = "J"},
            {description = "K", data = "K"},
            {description = "L", data = "L"},
            {description = "Z", data = "Z"},
            {description = "X", data = "X"},
            {description = "C", data = "C"},
            {description = "V", data = "V"},
            {description = "B", data = "B"},
            {description = "N", data = "N"},
        },
        default = "P",
    },
    {
        name = "OBC_RESET_KEY",
        label = "在自身与最近选定的实体/位置间切换",
        hover = "The key to switch the focus of the camera between your character and recent selected entity/position.",
        options = {
            {description = "R", data = "R"},
            {description = "T", data = "T"},
            {description = "O", data = "O"},
            {description = "P", data = "P"},
            {description = "G", data = "G"},
            {description = "H", data = "H"},
            {description = "J", data = "J"},
            {description = "K", data = "K"},
            {description = "L", data = "L"},
            {description = "Z", data = "Z"},
            {description = "X", data = "X"},
            {description = "C", data = "C"},
            {description = "V", data = "V"},
            {description = "B", data = "B"},
            {description = "N", data = "N"},
        },
        default = "R",
    },
}
