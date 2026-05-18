local logger = require("logger")

local function getPluginPath()
    local source = debug.getinfo(3, "S").source

    -- Remove extension suffix
    local path, _ = source:match("(.*)%.(.*)")

    local plugin_path = path:match("@.*/([^/]+%.koplugin/.+)$")
    if plugin_path then
        return plugin_path
    end

    return path
end

local NamespacedLogger = {}

function NamespacedLogger:new()
    local obj = {
        name = getPluginPath()
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function NamespacedLogger:dbg(...)
    return logger.dbg(self.name, ...)
end

function NamespacedLogger:info(...)
    return logger.info(self.name, ...)
end

function NamespacedLogger:warn(...)
    return logger.warn(self.name, ...)
end

function NamespacedLogger:err(...)
    return logger.err(self.name, ...)
end

return NamespacedLogger