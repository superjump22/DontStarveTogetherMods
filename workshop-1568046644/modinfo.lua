--The name of the mod displayed in the 'mods' screen.
name = "Toggle Lag Compensation"

--A description of the mod.
description = [[
这个MOD让你不需要打开设置就能一键开关延迟补偿。

[Version 1.0.5]
更新日志：修复不在聊天信息中显示开关状态的bug，添加了新的可选择键位（现支持A-Z、0-9、F1·F12）

With this MOD, you can toggle lag compensation more conveniently without opening settings screen.

[Version 1.0.5]
Update log: fix the bug that does not display the switch status in chat messages, add more selectable keys (A-Z, 0-9, F1·F12)
]]

--Who wrote this awesome mod?
author = "gcc"

--A version number so you can ask people if they are running an old version of your mod.
version = "1.0.5"

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
        name = "TLC_LANGUAGE",
        label = "Language - 语言",
        options = {
            {description = "中文", data = true},
            {description = "English", data = false},
        },
        default = true,
    },
    {
        name = "TLC_TOGGLE_KEY",
        label = "Toggle Key - 开关快捷键",
        hover = "Press this key to toggle on/off - 用此快捷键开启/关闭延迟补偿",
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
            {description = "0", data = 48},
            {description = "1", data = 49},
            {description = "2", data = 50},
            {description = "3", data = 51},
            {description = "4", data = 52},
            {description = "5", data = 53},
            {description = "6", data = 54},
            {description = "7", data = 55},
            {description = "8", data = 56},
            {description = "9", data = 57},
            {description = "A", data = 97},
            {description = "B", data = 98},
            {description = "C", data = 99},
            {description = "D", data = 100},
            {description = "E", data = 101},
            {description = "F", data = 102},
            {description = "G", data = 103},
            {description = "H", data = 104},
            {description = "I", data = 105},
            {description = "J", data = 106},
            {description = "K", data = 107},
            {description = "L", data = 108},
            {description = "M", data = 109},
            {description = "N", data = 110},
            {description = "O", data = 111},
            {description = "P", data = 112},
            {description = "Q", data = 113},
            {description = "R", data = 114},
            {description = "S", data = 115},
            {description = "T", data = 116},
            {description = "U", data = 117},
            {description = "V", data = 118},
            {description = "W", data = 119},
            {description = "X", data = 120},
            {description = "Y", data = 121},
            {description = "Z", data = 122},
        },
        default = 98,
    },
    {
        name = "TLC_DISPLAY_CHANGE",
        label = "Display Changes? - 显示变化？",
        hover = "Whether changes are displayed. - 开关时是否显示变化。",
        options = {
            {description = "Display - 显示", data = true},
            {description = "Not Display - 不显示", data = false},
        },
        default = true,
    },
}
