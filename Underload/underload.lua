local function run(code)
	local _, count = string.gsub(code, "[()]", "%0")
	if count % 2 ~= 0 then
		print("Error: unmatched parentheses")
		error()
	end

	local stack = {}

	local function check_empty()
		if #stack == 0 then
			print("Error: empty stack")
			error()
		end
	end

	local function push(value)
		stack[#stack + 1] = value
	end
	local function pop()
		check_empty()

		local value = stack[#stack]
		stack[#stack] = nil
		return value
	end

	local ip = 1
	local nesting = 0

	while ip <= string.len(code) do
		local c = string.sub(code, ip, ip)

		if c == "~" then
			local first, second = pop(), pop()
			push(first)
			push(second)
		elseif c == ":" then
			local value = pop()
			push(value)
			push(value)
		elseif c == "!" then
			pop()
		elseif c == "*" then
			local first, second = pop(), pop()
			push(second .. first)
		elseif c == "(" then
			nesting = 1
			ip = ip + 1
			local value = ""
			while true do
				local c = string.sub(code, ip, ip)
				if c == "(" then
					nesting = nesting + 1
				elseif c == ")" then
					nesting = nesting - 1
				end
				if nesting == 0 then
					break
				end
				value = value .. c
				ip = ip + 1
			end
			push(value)
		elseif c == "a" then
			local value = pop()
			push("(" .. value .. ")")
		elseif c == "^" then
			local value = pop()
			code = string.sub(code, 1, ip) .. value .. string.sub(code, ip + 1)
		elseif c == "S" then
			local value = pop()
			io.write(value)
		end

		ip = ip + 1
	end
end

if #arg < 1 then
	print("Usage: " .. arg[0] .. " <-i | file>\n" ..
		"Use -i to enter interactive mode")
	error()
elseif arg[1] == "-i" then
	while true do
		io.write("> ")
		local code = io.read("*l")
		local result, err = pcall(run, code)
		if not result then
			print(err)
		end
		print()
	end
else
	local file = io.open(arg[1], "r")
	if not file then
		print("Error: could not open " .. arg[1])
		error()
	end
	local code = file:read("*a")
	file:close()
	run(code)
	print()
end
