local sys = require "luci.sys"
local http = require "luci.http"

module("luci.controller.sing-box", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/sing-box") then
        return
    end

    entry({ "admin", "services", "sing-box" }, alias("admin", "services", "sing-box", "setting"), _("sing-box"), 58).dependent = true
    entry({ "admin", "services", "sing-box", "setting" }, cbi("sing-box/basic"), _("Base Settings"), 1).leaf = true
    entry({ "admin", "services", "sing-box", "config" }, cbi("sing-box/conffile"), _("Configuration"), 2).leaf = true

    entry({ "admin", "services", "sing-box", "get_status" }, call("get_status"))
    entry({ "admin", "services", "sing-box", "get_version" }, call("get_version"))
end

function get_status()
    local e = {}
    e.running = sys.call("pidof sing-box >/dev/null") == 0
    http.prepare_content("application/json")
    http.write_json(e)
end

function get_version()
    local version = "Unknown"
    local f = io.popen("/usr/bin/sing-box version 2>/dev/null | head -n1 | awk '{print $3}'")
    if f then
        version = f:read("*a") or "Unknown"
        f:close()
        version = version:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace
    end
    http.prepare_content("application/json")
    http.write_json({ version = version })
end
