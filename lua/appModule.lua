local _M = {}
local lrucache = require("resty.lrucache")
local http = require "resty.http"
local cjson = require "cjson"

local cachettl = 300

local versionCache, err = lrucache.new(1000)
if not versionCache then
    return error("failed to create the cache: " .. (err or "unknown"))
end

function _M.getModuleTenant(moduleName, tenantKey)
  local cacheKey = moduleName .. ":" .. tenantKey
  local tenant = versionCache:get(cacheKey)
  if tenant == nil then
		local httpc = http.new()

    local accessKey="sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2021-02-06T01:13:14Z&st=2020-02-05T17:13:14Z&spr=https&sig=7FkzQQLBSG4sq5%2B2kFDcqRy%2FmjqnSmTg1AqhVo6JcnA%3D"
		local queryUrl="https://awlprojectprototype.table.core.windows.net/Tenant?" .. accessKey
		queryUrl = queryUrl .. "&$format=json&$$filter=(PartitionKey%20eq%20'production')%20and%20(key%20eq%20'" .. tenantKey .. "')%20and%20(moduleName%20eq%20'" .. moduleName .. "')"
		local res, err = httpc:request_uri(queryUrl , {
			ssl_verify = false
		})
		if err then
			return nil, err
		end
		local data = cjson.decode(res.body)

		for i,v in ipairs(data.value) do
			tenant = v
			versionCache:set(cacheKey, tenant, cachettl)
		end
	end
	return tenant
end

return _M
