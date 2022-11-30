local CHAT_QUEUE_SIZE = 7
local CHAT_EXPIRE_TIME = 1.0

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
                GLOBAL.Networking_Say(-1, -1, "开启", nil, "延迟补偿已开启。", {0.196, 0.804, 0.196, 1}, false, 'none')
            else
                GLOBAL.Networking_Say(-1, -1, "关闭", nil, "延迟补偿已关闭。", {1, 0.388, 0.278, 1}, false, 'none')
            end
        else
            if movementprediction then
                GLOBAL.Networking_Say(-1, -1, "ON", nil, "Lag compensation is set to predictive.", {0.196, 0.804, 0.196, 1}, false, 'none')
            else
                GLOBAL.Networking_Say(-1, -1, "OFF", nil, "Lag compensation is set to none.", {1, 0.388, 0.278, 1}, false, 'none')
            end
        end
    end
end

if type(TLC_TOGGLE_KEY) == "string" then
    GLOBAL.TheInput:AddKeyUpHandler(TLC_TOGGLE_KEY:lower():byte(), ToggleLagCompensation)
else
    GLOBAL.TheInput:AddKeyUpHandler(TLC_TOGGLE_KEY, ToggleLagCompensation)
end
