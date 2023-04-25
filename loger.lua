-- Define a function to log function calls
function logFunctionCalls(event, line)
    local info = debug.getinfo(2, "S")
    if info.what == "Lua" and info.name ~= nil then
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        print(timestamp, "Function called:", info.name)
    end
end

-- Set a hook to log function calls
debug.sethook(logFunctionCalls, "c")