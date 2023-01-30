--[[
Author: Hector Jiang
Date: 2023-01-30 21:25:22
LastEditTime: 2023-01-30 21:25:29
Description: 
--]]
local skynet = require "skynet"

local CMD = {}

skynet.start(function()
	-- 为lua类型消息设置处理函数
	skynet.dispatch("lua", function(session, source, cmd, ...)
	local f = assert(CMD[cmd])
	f(source, ...)
	end)
end)

function CMD.start(source, target)
	skynet.send(target, "lua", "ping", 1)
end

function CMD.ping(source, count)
	local id = skynet.self()
	skynet.error("["..id.."] recv ping count="..count)
	skynet.sleep(100)
	skynet.send(source, "lua", "ping", count+1)
end