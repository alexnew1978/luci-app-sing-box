local m, s, o

m = Map("sing-box")
m.title = translate("sing-box")
m.description = translate("The universal proxy platform.")

m:section(SimpleSection).template = "sing-box/status"

s = m:section(TypedSection, "sing-box", translate("Base Settings"))
s.anonymous = true

o = s:option(Flag, "enabled", translate("Enable"))
o.default = 0

o = s:option(Value, "conffile", translate("Configuration file"))
o.default = '/etc/sing-box/config.json'
o.readonly = true

o = s:option(Value, "workdir", translate("Work directory"))
o.default = '/usr/share/sing-box'
o.rmempty = false

o = s:option(Value, "user", translate("Username"))
o.default = 'root'
o.rmempty = false

o = s:option(Value, "log_stderr", translate("Log to stderr"))
o.default = '1'
o.rmempty = false

o = s:option(Value, 'log_stdout', translate('Log to stdout'))
o.default = '1'
o.rmempty = false

m.apply_on_parse = true
m.on_after_apply = function(self, map)
    luci.sys.call("/etc/init.d/sing-box restart >/dev/null 2>&1 &")
end

return m
