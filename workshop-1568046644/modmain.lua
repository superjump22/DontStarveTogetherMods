local ChatQueue = require "widgets/chatqueue"
local TLC_LANGUAGE = GetModConfigData("TLC_LANGUAGE")
local TLC_TOGGLE_KEY = GetModConfigData("TLC_TOGGLE_KEY")
local TLC_DISPLAY_CHANGE = GetModConfigData("TLC_DISPLAY_CHANGE")

local function GetActiveScreenName()
	local screen = TheFrontEnd:GetActiveScreen()
	return screen and screen.name or ""
end

local function IsDefaultScreen()
	return GetActiveScreenName():find("HUD") ~= nil
end

local function ToggleLagCompensation(self)
    if not IsDefaultScreen() or GLOBAL.ThePlayer == nil then
        return
    end
    if GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue == nil then
        GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue = GLOBAL.ThePlayer.HUD.controls.chat_queue_root:AddChild(ChatQueue())
        GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue:SetClickable(false)
    end
    local chatqueue = GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue
    local playercontroller = GLOBAL.ThePlayer.components.playercontroller
    local movementprediction = not GLOBAL.Profile:GetMovementPredictionEnabled()
    if playercontroller:CanLocomote() then
        playercontroller.locomotor:Stop()
    else
        playercontroller:RemoteStopWalking()
    end
    GLOBAL.ThePlayer:EnableMovementPrediction(movementprediction)
    GLOBAL.Profile:SetMovementPredictionEnabled(movementprediction)
    if TLC_DISPLAY_CHANGE then
        if TLC_LANGUAGE then
            if movementprediction then
                chatqueue:PushMessage("开启", "延迟补偿已开启。", {0.196, 0.804, 0.196, 1})
            else
                chatqueue:PushMessage("关闭", "延迟补偿已关闭。", {1, 0.388, 0.278, 1})
            end
        else
            if movementprediction then
                chatqueue:PushMessage("ON", "Lag compensation is set to predictive.", {0.196, 0.804, 0.196, 1})
            else
                chatqueue:PushMessage("OFF", "Lag compensation is set to none.", {1, 0.388, 0.278, 1})
            end
        end
    end
end

if type(TLC_TOGGLE_KEY) == "string" then
    GLOBAL.TheInput:AddKeyUpHandler(TLC_TOGGLE_KEY:lower():byte(), ToggleLagCompensation)
else
    GLOBAL.TheInput:AddKeyUpHandler(TLC_TOGGLE_KEY, ToggleLagCompensation)
end