-- Contains data validators and some functions to simplify things
-- and some typing info

-- Typing
---@class Field
local Field = {
	---@type string
	name=nil,
	---@type string|nil
	desc=nil,
	---@type string|number
	default=nil,
	---@type fun(newValue:string|number):string|number @ Or nil
	changed=nil
}
---@class Device
local Device = {
	---@type string
	name=nil,
	---@type string|nil
	desc=nil,
	---@type table<string,Field>
	fields=nil
}


local function validateField(field, otherFieldName, deviceName)
	local otherFieldName = otherFieldName or "<NO_NAME>"
	local deviceName = deviceName or "<NO_NAME>"
	if type(field.name) ~= "string" then
		error("field " .. otherFieldName .. " of " .. deviceName .. " is missing a 'name' field of the type string.")
	elseif type(field.desc) ~= "string" then
		print("field " .. field.name .. " of " .. deviceName .. " is missing a 'desc' field of the type string.")
	elseif type(field.default) ~= "string" and type(field.default) ~= "number" then
		error("field " .. field.name .. " of " .. deviceName .. " is missing a 'default' field of the type string or number.")
	end
	if field.jsonify == nil then
		function field:jsonify()
			return {
				name=self.name,
				value=self.value
			}
		end
	end
end

local jsonifyBlacklistedIndices = {
	desc=true,
	_device=true,
	map=true
}
local function validateDevice(device)
	if type(device.name) ~= "string" then
		error("<NO_NAME> is missing a 'name' field of the type string.")
	elseif type(device.desc) ~= "string" then
		print(device.name .. " is missing a 'desc' field of the type string.")
		device.desc = "No Description."
	elseif type(device.fields) ~= "table" then
		error(device.name .. " is missing a 'fields' field of the type table.")
	end
	for i, v in pairs(device.fields) do
		validateField(v, i, device.name)
	end
	if device.jsonify == nil then
		function device:jsonify()
			local objectsIndexLookup = {}
			for i, v in pairs(LoadedMap.objects) do
				objectsIndexLookup[v] = i
			end

			local new = {}
			for i, v in pairs(self) do
				if jsonifyBlacklistedIndices[i] then
					-- we don't want to jsonify these
				elseif i == "connections" then
					local connections = {}
					new[i] = connections
					for _, obj in pairs(v) do
						table.insert(connections, objectsIndexLookup[obj])
					end
				elseif type(v) == "table" then
					if v.jsonify then
						new[i] = v:jsonify()
					else
						new[i] = jsonify_auto(v)
					end
				elseif type(v) == "function" then
					-- we cant jsonify a function
				else
					new[i] = v
				end
			end
			return new
		end
	end
end

return {
	validateDevice=validateDevice,
	validateField=validateField,

	-- used for simplification, save's writing same code for different stuff
	changed_anyNumber=function(self, newValue)
		if type(newValue) ~= "number" then
			return self.value
		end
		return newValue
	end,
	changed_anyString=function(self, newValue)
		if type(newValue) ~= "string" then
			return self.value
		end
		return newValue
	end,
	changed_number0to1=function(self, newValue)
		if type(newValue) ~= "number" or newValue < 0 or newValue > 1 then
			return self.value
		end
		return newValue
	end
}
