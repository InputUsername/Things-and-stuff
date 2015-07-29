-- Lua implementation of Langar.io
-- InputUsername 2015

-- Version 1.1

-- Constants
EMPTY = " "

-- Usage
if #arg < 1 then
	print("Usage: " .. arg[0] .. " <file>")
	os.exit()
end

-- Open file
local file = io.open(arg[1], "r")

if not file then
	print("Error: could not open " .. arg[1])
	os.exit()
end

-- Read + parse file
local program = {}
local width = 0

for line in file:lines() do
	local matches = {}
	for m in string.gmatch(line, "%(([%dSW ]-)%)") do
		if m ~= "S" and m ~= "W" then
			-- Remove non-numeric characters
			m = string.gsub(m, "%D", "")

			-- If a numeric string, convert to number, else set to EMPTY
			m = tonumber(m) or EMPTY
		end
		table.insert(matches, m)
	end
	if #matches > width then width = #matches end
	table.insert(program, matches)
end

file:close()

-- Pad with empty cells
for i, row in ipairs(program) do
	if #row < width then
		for i = 1, width - #row do
			-- Insert into row as it is just a table reference
			table.insert(row, EMPTY)
		end
	end
end

-- 0 is up, 1 is right, 2 is down, 3 is left, -1 is black magic
local dir = -1
local ip = {x = 1, y = 1}
local mass = 10

-- Stack functions
local stack = {}

local function push(value)
	stack[#stack + 1] = value
end
local function pop()
	local value = stack[#stack]
	stack[#stack] = nil
	return value
end

local function doFunction(number)
	--TODO: functions
end

while true do
	local cell = program[ip.y][ip.x]

	if type(cell) == "number" then
		if mass >= cell then
			doFunction(cell)
		else
			break
		end
		mass = mass + cell
		program[ip.y][ip.x] = EMPTY
	elseif cell == "S" then
		if mass % 2 == 0 then
			cell = mass / 2
			mass = mass / 2
		else
			cell = math.floor(mass / 2)
			mass = mass - cell
		end
	elseif cell == "W" then
		if mass > 30 then
			cell = 10
			mass = mass - 10
		end
	end

	if mass == 0 then
		break
	end
end

print("Stack: " .. table.concat(stack, ", "))
print("Player mass: " .. mass)
