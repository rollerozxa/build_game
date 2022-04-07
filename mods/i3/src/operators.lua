--[[    All source files have to be preprocessed before loading.
	This allows implementing custom operators like bitwise ones.	]]

local fmt, split = string.format, string.split
local var = "[%w%.%[%]\"\'_]"

local operators = {
	["([%+%-%*%^/&|])="] = function(a, b, c)
		return fmt("%s = %s %s %s", a, a, b, c)
	end,
}

local function compile(data)
	data = data:gsub("IMPORT%((.-)%)", function(a)
		return "local " .. a:gsub("\"", "") .. " = i3.get(" .. a .. ")"
	end)

	for op, func in pairs(operators) do
		data = data:gsub("(" .. var .. "+)%s?" .. op .. "%s?(" .. var .. "*)", func)
	end

	return data
end

local function _load(path, line, data, t)
	if line then
		if not t then
			t = split(data, "\n")
		end
		t[line] = t[line]:gsub("(" .. var .. "+)%s?=%s?(" .. var .. "*)", "%2")
		data = table.concat(t, "\n")
	else
		local file = assert(io.open(path, "r"))
		data = file:read"*a"
		file:close()
		data = compile(data)
	end

	local l, err = loadstring(data)

	if not l then
		local err_line = tonumber(err:match(":(%d+):"))

		if line ~= err_line then
			return _load(path, err_line, data, t)
		end
	end

	return l, err
end

return function(path)
	return _load(path) or loadfile(path)
end
