-- Wrote by Boogle help from Mr_Purrsalot 
-- Decemember 5th, 2020.

--> stolen code
function string:split(sep)
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c) fields[#fields+1] = c end)
	return fields
end

--> variables
local Fulldata = {}

local data = {}

local required = {
	['byr'] = function(v)
		v = tonumber(v)
		if v >= 1920 and v <= 2002 then
			return true
		end

		return false
	end,
	['iyr'] = function(v)
		v = tonumber(v)
		if v >= 2010 and v <= 2020 then
			return true
		end

		return false
	end,
	['eyr'] = function(v)
		v = tonumber(v)
		if v >= 2020 and v <= 2030 then
			return true
		end

		return false
	end,
	['hgt'] = function(v)
		if v:find("cm") then
			v = v:sub(1,#v-2)
			v = tonumber(v)
			if v >= 150 and v <= 193 then
				return true
			end
		elseif v:find("in") then
			v = v:sub(1,#v-2)
			v = tonumber(v)
			if v >= 59 and v <= 76 then
				return true
			end
		end

		return false
	end,
	['hcl'] = function(v)
		v = string.match(v, "#(.*)")

		if v and #v == 6 then
			return true
		end

		return false

	end,
	['ecl'] = function(v)

		local valid = {
			"amb","blu","brn","gry","grn","hzl","oth"
		}

		for _, b in pairs(valid) do
			if v == b then
				return true
			end
		end


		return false
	end,
	['pid'] = function(v)
		if #tostring(v) == 9 then
			return true
		end

		return false
	end,
}

local dataFileName = "data.txt"

local validCount = 0

--> functions
function parse(line, dataInto)
	
	local bairs = line:split(" ")
	
	for _, v in pairs(bairs) do
		local kvp = v:split(":")
		
		data[kvp[1]] = kvp[2]
	end
	
end

for line in io.lines(dataFileName) do
	if #line == 0 then
		table.insert(Fulldata, #Fulldata+1, data)
		data = {}
	else
		parse(line, data)
	end
end

function check(input)
	for k, v in pairs(required) do
		if input[k] == nil then
			return false
		else
			if not v(input[k]) then
				return false
			end
		end
	end
	
	return true
end

--> run stuff
for _, v in pairs(Fulldata) do
	if check(v) == true then
		validCount = validCount + 1
	end
end

print('Output:',tostring(validCount))