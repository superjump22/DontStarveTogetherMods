local obc_languageCode = GLOBAL.TheNet:GetLanguageCode()
local obc_viewMode = GetModConfigData("OBC_INITIAL_VIEW_MODE")
local obc_recentTarget = {
	flag = 0,
	entity = nil,
	x = 0, y = 0, z = 0,
}

local ChatQueue = require "widgets/chatqueue"
local CHAT_QUEUE_SIZE = 7
local CHAT_EXPIRE_TIME = 1.0

function ChatQueue:PushMessage(username, message, colour, whisper, nolabel, profileflair)
    -- Shuffle upwards
    for i = 1, CHAT_QUEUE_SIZE - 1 do
        self.chat_queue_data[i] = GLOBAL.shallowcopy( self.chat_queue_data[i+1] )
    end

    --Set this new message into the chat queue data
    self.chat_queue_data[CHAT_QUEUE_SIZE].expire_time = GLOBAL.GetTime() + CHAT_EXPIRE_TIME
    self.chat_queue_data[CHAT_QUEUE_SIZE].username = username
    self.chat_queue_data[CHAT_QUEUE_SIZE].message = message
    self.chat_queue_data[CHAT_QUEUE_SIZE].colour = colour
    self.chat_queue_data[CHAT_QUEUE_SIZE].whisper = whisper
    self.chat_queue_data[CHAT_QUEUE_SIZE].nolabel = nolabel
    self.chat_queue_data[CHAT_QUEUE_SIZE].profileflair = profileflair

    self:RefreshWidgets()
end

local function TextFilter(texts)
	if obc_languageCode == "schinese" then
		return texts[1]
	elseif obc_languageCode == "tchinese" then
		return texts[2]
	else
		return texts[3]
	end
end

local function Say(texts)
	if GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue == nil then
        GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue = GLOBAL.ThePlayer.HUD.controls.chat_queue_root:AddChild(ChatQueue())
        GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue:SetClickable(false)
    end
	GLOBAL.ThePlayer.HUD.controls.gcc_mod_chatqueue:DisplaySystemMessage(TextFilter(texts))
end

local function IsDefaultScreen()
	local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
	local screenName = screen and screen.name or ""
	return screenName:find("HUD") ~= nil and GLOBAL.ThePlayer ~= nil
end

local function SetCamera(zoomstep, mindist, maxdist, mindistpitch, maxdistpitch, distance, distancetarget)
	if GLOBAL.TheCamera ~= nil then
		local camera = GLOBAL.TheCamera
		camera.zoomstep = zoomstep or camera.zoomstep
		camera.mindist = mindist or camera.mindist
		camera.maxdist = maxdist or camera.maxdist
		camera.mindistpitch = mindistpitch or camera.mindistpitch
		camera.maxdistpitch = maxdistpitch or camera.maxdistpitch
		camera.distance = distance or camera.distance
		camera.distancetarget = distancetarget or camera.distancetarget
	end
end

local function SetDefaultView()
	if GLOBAL.TheWorld ~= nil then
		if GLOBAL.TheWorld:HasTag("cave") then
			SetCamera(4, 15, 35, 25, 40, 25, 25)
		else
			SetCamera(4, 15, 50, 30, 60, 30, 30)
		end
	end
end

local function SetAerialView()
	if GLOBAL.TheWorld ~= nil then
		if GLOBAL.TheWorld:HasTag("cave") then
			SetCamera(10, 10, 180, 25, 40, 80, 80)
		else
			SetCamera(10, 10, 180, 30, 60, 80, 80)
		end
	end
end

local function SetVerticalView()
	if GLOBAL.TheWorld ~= nil then
		if GLOBAL.TheWorld:HasTag("cave") then
			SetCamera(10, 10, 180, 90, 90, 80, 80)
		else
			SetCamera(10, 10, 180, 90, 90, 80, 80)
		end
	end
end

local function ChangeViewMode()
	if IsDefaultScreen() then
		if obc_viewMode == 0 then
			SetAerialView()
			obc_viewMode = 1
			Say({"高空", "高空", "Aerial View"})
		elseif obc_viewMode == 1 then
			SetVerticalView()
			obc_viewMode = 2
			Say({"俯视", "俯視", "Vertical View"})
		elseif obc_viewMode == 2 then
			SetDefaultView()
			obc_viewMode = 0
			Say({"默认", "默認", "Default View"})
		end
	end
end

local function ShowOrHideHUD()
	if IsDefaultScreen() then
		if GLOBAL.ThePlayer.HUD:IsVisible() then
			GLOBAL.ThePlayer.HUD:Hide()
		else
			GLOBAL.ThePlayer.HUD:Show()
		end
	end
end

local function ShowOrHidePlayer()
	if IsDefaultScreen() then
		if GLOBAL.ThePlayer.entity:IsVisible() then
			GLOBAL.ThePlayer:Hide()
			GLOBAL.ThePlayer.DynamicShadow:Enable(false)
		else
			GLOBAL.ThePlayer:Show()
			GLOBAL.ThePlayer.DynamicShadow:Enable(true)
		end
	end
end

local function ChangeCameraTarget()
	if IsDefaultScreen() then
		local entity = GLOBAL.TheInput:GetWorldEntityUnderMouse()
		if entity ~= nil then
			local x, y, z = entity.Transform:GetWorldPosition()
			if x ~= nil and y ~= nil and z ~= nil then
				GLOBAL.TheCamera.target = entity
				GLOBAL.TheCamera.targetpos.x, GLOBAL.TheCamera.targetpos.y, GLOBAL.TheCamera.targetpos.z = x, y, z
				obc_recentTarget.flag = 1
				obc_recentTarget.entity = entity
				obc_recentTarget.x, obc_recentTarget.y, obc_recentTarget.z = x, y, z
			else
				Say({"超出范围", "超出範圍", "Out of Range"})
			end
		end
	end
end

local function ChangeCameraPosition()
	if IsDefaultScreen() then
		local x, y, z = GLOBAL.TheInput:GetWorldPosition():Get()
		GLOBAL.TheCamera.target = nil;
		GLOBAL.TheCamera.targetpos.x, GLOBAL.TheCamera.targetpos.y, GLOBAL.TheCamera.targetpos.z = x, y, z
		obc_recentTarget.flag = 2
		obc_recentTarget.entity = nil
		obc_recentTarget.x, obc_recentTarget.y, obc_recentTarget.z = x, y, z
	end
end

local function ResetCameraTarget()
	if IsDefaultScreen() then
		if GLOBAL.TheCamera.target ~= GLOBAL.ThePlayer then
			GLOBAL.TheCamera:SetTarget(GLOBAL.ThePlayer)
		elseif obc_recentTarget.flag == 1 then
			if obc_recentTarget.entity ~= nil then
				local x, y, z = obc_recentTarget.entity.Transform:GetWorldPosition()
				if x ~= nil and y ~= nil and z ~= nil then
					GLOBAL.TheCamera.target = obc_recentTarget.entity
					GLOBAL.TheCamera.targetpos.x, GLOBAL.TheCamera.targetpos.y, GLOBAL.TheCamera.targetpos.z = x, y, z
					return
				end
			end
			Say({"超出范围", "超出範圍", "Out of Range"})
		elseif obc_recentTarget.flag == 2 then
			GLOBAL.TheCamera.target = nil;
			GLOBAL.TheCamera.targetpos.x, GLOBAL.TheCamera.targetpos.y, GLOBAL.TheCamera.targetpos.z = obc_recentTarget.x, obc_recentTarget.y, obc_recentTarget.z
		end
	end
end

local function AddFOV(delta)
	if IsDefaultScreen() then
		local fov = GLOBAL.TheCamera.fov + delta
		if fov < 20 then
			fov = 20
		elseif fov > 120 then
			fov = 120
		end
		GLOBAL.TheCamera.fov = fov
		Say({"FOV " .. fov .. "（默认 35）", "FOV " .. fov .. "（默認 35）", "FOV " .. fov .. " (default 35)"})
	end
end

AddPlayerPostInit(
	function(inst) inst:DoTaskInTime(0, function(player)
		if GLOBAL.TheCamera ~= nil and GLOBAL.ThePlayer ~= nil and player == GLOBAL.ThePlayer then
			GLOBAL.TheCamera:SetTarget(GLOBAL.ThePlayer)
		end
	end)
end)

local function lerp(lower, upper, t)
    return t > 1 and upper
        or (t < 0 and lower
        or lower * (1 - t) + upper * t)
end

local function normalize(angle)
    while angle > 360 do
        angle = angle - 360
    end
    while angle < 0 do
        angle = angle + 360
    end
    return angle
end

local FollowCameraPostConstruct = function(self)
	local originalSetDefault = self.SetDefault
	self.SetDefault = function(self)
		originalSetDefault(self)
		if obc_viewMode == 0 then
			SetDefaultView()
		elseif obc_viewMode == 1 then
			SetAerialView()
		elseif obc_viewMode == 2 then
			SetVerticalView()
		end
	end
	self.Update = function(self, dt, dontupdatepos)
		if self.paused then
			return
		end
		local pangain = dt * self.pangain
		if not dontupdatepos then
			if self.cutscene then
				self.currentpos.x = lerp(self.currentpos.x, self.targetpos.x + self.targetoffset.x, pangain)
				self.currentpos.y = lerp(self.currentpos.y, self.targetpos.y + self.targetoffset.y, pangain)
				self.currentpos.z = lerp(self.currentpos.z, self.targetpos.z + self.targetoffset.z, pangain)
			else
				if self.time_since_zoom ~= nil and not self.cutscene then
					self.time_since_zoom = self.time_since_zoom + dt
					if self.should_push_down and self.time_since_zoom > 1.0 then
						self.distancetarget = (self.maxdist - self.mindist) * 0.6 + self.mindist
					end
				end
				if self.target ~= nil then
					if self.target.components.focalpoint then
						self.target.components.focalpoint:CameraUpdate(dt)
					end
					local x, y, z = self.target.Transform:GetWorldPosition()
					if x == nil or y == nil or z == nil then
						if IsDefaultScreen() then
							self:SetTarget(GLOBAL.ThePlayer)
						end
						return
					end
					self.targetpos.x = x + self.targetoffset.x
					self.targetpos.y = y + self.targetoffset.y
					self.targetpos.z = z + self.targetoffset.z
				end
				self.currentpos.x = lerp(self.currentpos.x, self.targetpos.x, pangain)
				self.currentpos.y = lerp(self.currentpos.y, self.targetpos.y, pangain)
				self.currentpos.z = lerp(self.currentpos.z, self.targetpos.z, pangain)
			end
		end
		local screenxoffset = 0
		while #self.screenoffsetstack > 0 do
			if self.screenoffsetstack[1].ref.inst:IsValid() then
				screenxoffset = self.screenoffsetstack[1].xoffset
				break
			end
			GLOBAL.table.remove(self.screenoffsetstack, 1)
		end
		if screenxoffset ~= 0 then
			self.currentscreenxoffset = lerp(self.currentscreenxoffset, screenxoffset, pangain)
		elseif self.currentscreenxoffset ~= 0 then
			self.currentscreenxoffset = lerp(self.currentscreenxoffset, 0, pangain)
			if GLOBAL.math.abs(self.currentscreenxoffset) < .01 then
				self.currentscreenxoffset = 0
			end
		end
		if self.shake ~= nil then
			local shakeOffset = self.shake:Update(dt)
			if shakeOffset ~= nil then
				local rightOffset = self:GetRightVec() * shakeOffset.x
				self.currentpos.x = self.currentpos.x + rightOffset.x
				self.currentpos.y = self.currentpos.y + rightOffset.y + shakeOffset.y
				self.currentpos.z = self.currentpos.z + rightOffset.z
			else
				self.shake = nil
			end
		end
		self.heading = normalize(self.heading)
		self.headingtarget = normalize(self.headingtarget)
		local diffheading = GLOBAL.math.abs(self.heading - self.headingtarget)
		self.heading =
			diffheading <= .01 and
			self.headingtarget or
			lerp(self.heading,
				diffheading <= 180 and
				self.headingtarget or
				self.headingtarget + (self.heading > self.headingtarget and 360 or -360),
				dt * self.headinggain)
		self.distance =
			GLOBAL.math.abs(self.distance - self.distancetarget) > .01 and
			lerp(self.distance, self.distancetarget, dt * self.distancegain) or
			self.distancetarget
		self.pitch = lerp(self.mindistpitch, self.maxdistpitch, (self.distance - self.mindist) / (self.maxdist - self.mindist))
		self:onupdatefn(dt)
		self:Apply()
		self:UpdateListeners(dt)
	end
end

local function BindKey(key, func)
	if type(key) == "string" then
		GLOBAL.TheInput:AddKeyUpHandler(key:lower():byte(), func)
	elseif key > 0 then
		GLOBAL.TheInput:AddKeyUpHandler(key, func)
	end
end

local OBC_FUNCTION_KEY_1 = GetModConfigData("OBC_FUNCTION_KEY_1")
local OBC_FUNCTION_KEY_2 = GetModConfigData("OBC_FUNCTION_KEY_2")
local OBC_FUNCTION_KEY_3 = GetModConfigData("OBC_FUNCTION_KEY_3")
local OBC_SWITCH_KEY_1 = GetModConfigData("OBC_SWITCH_KEY_1")
local OBC_SWITCH_KEY_2 = GetModConfigData("OBC_SWITCH_KEY_2")
local OBC_RESET_KEY = GetModConfigData("OBC_RESET_KEY")
local OBC_FOV_PLUS_KEY = GetModConfigData("OBC_FOV_PLUS_KEY")
local OBC_FOV_MINUS_KEY = GetModConfigData("OBC_FOV_MINUS_KEY")
local OBC_FOV_PLUS_MORE_KEY = GetModConfigData("OBC_FOV_PLUS_MORE_KEY")
local OBC_FOV_MINUS_MORE_KEY = GetModConfigData("OBC_FOV_MINUS_MORE_KEY")

BindKey(OBC_FUNCTION_KEY_1, ChangeViewMode)
BindKey(OBC_FUNCTION_KEY_2, ShowOrHideHUD)
BindKey(OBC_FUNCTION_KEY_3, ShowOrHidePlayer)
BindKey(OBC_SWITCH_KEY_1, ChangeCameraTarget)
BindKey(OBC_SWITCH_KEY_2, ChangeCameraPosition)
BindKey(OBC_RESET_KEY, ResetCameraTarget)
BindKey(OBC_FOV_PLUS_KEY, function() AddFOV(1) end)
BindKey(OBC_FOV_MINUS_KEY, function() AddFOV(-1) end)
BindKey(OBC_FOV_PLUS_MORE_KEY, function() AddFOV(5) end)
BindKey(OBC_FOV_MINUS_MORE_KEY, function() AddFOV(-5) end)

AddClassPostConstruct('cameras/followcamera', FollowCameraPostConstruct)
