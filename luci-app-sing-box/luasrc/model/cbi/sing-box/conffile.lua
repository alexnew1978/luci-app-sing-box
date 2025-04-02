local m, s, o
local fs = require "nixio.fs"
local http = require "luci.http"

m = Map("sing-box")
m.title = translate("sing-box")
m.description = translate(
    "Here you can edit sing-box configuration file. Sing-box will be restart automatically after apply.")

m.apply_on_parse = false
m.reset = false

s = m:section(TypedSection, "sing-box", translate("Configuration file"))
s.anonymous = true
s.addremove = false

local conffile = "/etc/sing-box/config.json"

o = s:option(TextValue, "config_content")
o.rows = 34
o.wrap = "off"
o.rmempty = false
o.template = "cbi/tvalue"
o.readonly = false

function o.cfgvalue(self, section)
    return fs.readfile(conffile) or ""
end

function o.write(self, section, value)
    if value then
        value = value:gsub("\r\n?", "\n")
        fs.writefile(conffile, value)
        luci.sys.call("service sing-box restart >/dev/null 2>&1 &")
    end
end

return m
