-- Lua implementation of Langar.io
-- InputUsername 2015

-- Version 1.2
-- Implements Langar.io 1.2

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
	-- Match only valid cells
	for m in string.gmatch(line, "%(([%dSW ]-)%)") do
		-- If the cell contains an 'S' or 'W' action
		if string.find(m, "[SW]") then
			m = string.gsub(m, "[^SW]", "")
		else
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

--[[ DEBUG
for i, row in ipairs(program) do
	io.write(i..": ")
	for j, col in ipairs(row) do
		io.write("["..col.."]\t")
	end
	print()
end
]]

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
	if #stack == 0 then return nil end
	local value = stack[#stack]
	stack[#stack] = nil
	return value
end

-- Execute a function indicated by the number
-- Returns true if successful, false if not
local function doFunction(number)
	number = number % 16

	-- 1: push the player's mass
	if number == 1 then
		push(mass)

	-- 2: pop one byte and output as a character
	elseif number == 2 then
		local value = pop()
		if not value then return false end
		io.write(string.char(value))

	-- 3: get one byte of input and push
	elseif number == 3 then
		local input = io.read(1)
		if not input then return false end
		push(string.byte(input))

	-- 4: pop two numbers, add, push the result
	elseif number == 4 then
		local first, second = pop(), pop()
		if not first or not second then return false end
		push(first + second)

	-- 5: subtract
	elseif number == 5 then
		local first, second = pop(), pop()
		if not first or not second then return false end
		push(second - first)

	-- 6: multiply
	elseif number == 6 then
		local first, second = pop(), pop()
		if not first or not second then return false end
		push(first * second)

	-- 7: integer division
	elseif number == 7 then
		local first, second = pop(), pop()
		if not first or not second then return false end
		push(floor(first / second))
		push(first % second)

	end

	return true
end

while true do
	local cell = program[ip.y][ip.x]

	if type(cell) == "number" then
		if mass >= cell then
			local continue = doFunction(cell)
			if not continue then break end
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
