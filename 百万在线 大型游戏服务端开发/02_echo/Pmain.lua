--[[
Author: Hector Jiang
Date: 2023-01-30 22:11:26
LastEditTime: 2023-01-30 22:11:31
Description: 
--]]
local skynet = require "skynet"
local socket = require "skynet.socket"

skynet.start(function()
    local listenfd = socket.listen("0.0.0.0", 8888)
    socket.start(listenfd, connect)
end)

function connect(fd, addr)
    print(fd .. "connected addr:" .. addr)
    socket.start(fd)
    while true do
        local readdata = socket.read(fd)
        if readdata ~= nil then
            print(fd .. "recv" .. readdata)
            socket.write(fd, readdata)
        else
            print(fd .. "close")
            socket.close(fd)
        end
    end
end