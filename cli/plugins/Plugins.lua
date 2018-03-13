do
local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  return false
end

local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end

local function list_all_plugins(only_enabled, msg)
  local tmp = '\n'
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    local status = '|✖️|>'
    nsum = nsum+1
    nact = 0
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '|✔|>'
      end
      nact = nact+1
    end
    if not only_enabled or status == '|✔|>'then
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'.'..status..' '..v..' \n'
    end
  end
  text = '`'..text..'`\n> *ιηѕтαƖƖєɗ ρƖυgιηѕ :* _['..nsum..']_\n *ρƖυgιηѕ єηαвƖєɗ :* _['..nact..']_\n *ρƖυgιηѕ ɗιѕαвƖєɗ :* _['..nsum-nact..']_'..tmp
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end

local function list_plugins(only_enabled, msg)
  local text = '> *Ɗσηє!*\n`MαƬαƊσR Rєℓσα∂ :)`'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end

local function reload_plugins(checks, msg)
  plugins = {}
  load_plugins()
  return list_plugins(true, msg)
end


local function enable_plugin( plugin_name, msg )
  print('checking if '..plugin_name..' exists')
  if plugin_enabled(plugin_name) then
    local text = '<b>'..plugin_name..'</b> <i>Is Enabled.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  if plugin_exists(plugin_name) then
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    return reload_plugins(true, msg)
  else
    local text = '<b>'..plugin_name..'</b> <i>Does Not Exists.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  end
end

local function disable_plugin( name, msg )
  local k = plugin_enabled(name)
  if not k then
    local text = '<b>'..name..'</b> <i>Not Enabled.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  if not plugin_exists(name) then
    local text = '<b>'..name..'</b> <i>Does Not Exists.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  else
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true, msg)
end  
end

local function disable_plugin_on_chat(receiver, plugin, msg)
  if not plugin_exists(plugin) then
    return "`Plugin Doesn't Exists`"
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
  local text = '<b>'..plugin..'</b> <i>Disabled On This Chat.</i>'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function reenable_plugin_on_chat(receiver, plugin, msg)
  if not _config.disabled_plugin_on_chat then
    return 'There Aren\'t Any Disabled Plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There Aren\'t Any Disabled Plugins For This Chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
    return '`This Plugin Is Not Disabled`'
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  local text = '<b>'..plugin..'</b> <i>Is Enabled Again.</i>'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function run(msg, matches)
  if is_sudo(msg) then
  if (matches[1]:lower() == 'pluginlist' ) or (matches[1]:lower() == 'لیست پلاگین' ) then 
    return list_all_plugins(false, msg)
  end
end
  if (matches[1]:lower() == 'plugin' ) or (matches[1]:lower() == 'پلاگین' ) then
  if matches[2] == '+' and ((matches[4] == 'chat' ) or (matches[4] == 'گروه' )) then
      if is_mod(msg) then
    local receiver = msg.chat_id_
    local plugin = matches[3]
    print("enable "..plugin..' on this chat')
    return reenable_plugin_on_chat(receiver, plugin, msg)
  end
    end

  if matches[2] == '+' and is_sudo(msg) then
    local plugin_name = matches[3]
    print("enable: "..matches[3])
    return enable_plugin(plugin_name, msg)
  end
  if matches[2] == '-' and ((matches[4] == 'chat' ) or (matches[4] == 'گروه' )) then
      if is_mod(msg) then
    local plugin = matches[3]
    local receiver = msg.chat_id_
    print("disable "..plugin..' on this chat')
    return disable_plugin_on_chat(receiver, plugin, msg)
  end
    end
  if matches[2] == '-' and is_sudo(msg) then
    if matches[3] == 'plugins' then
		return 'This plugin can\'t be disabled'
    end
    print("disable: "..matches[3])
    return disable_plugin(matches[3], msg)
  end
  if matches[2] == '*' and is_sudo(msg) then
    return reload_plugins(true, msg)
  end
  end
  if (matches[1]:lower() == 'reload' ) or (matches[1]:lower() == 'بارگذاری' ) and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
end

return {
  description = "Plugin to manage other plugins. Enable, disable or reload.", 
  usage = {
      moderator = {
          "!pl - [plugin] chat : disable plugin only this chat.",
          "!pl + [plugin] chat : enable plugin only this chat.",
          },
      sudo = {
          "!plist : list all plugins.",
          "!pl + [plugin] : enable plugin.",
          "!pl - [plugin] : disable plugin.",
          "!pl * : reloads all plugins." },
          },
  patterns = {
    "^[!/#]([Pp]luginlist)$",
    "^[!/#]([Pp]lugin) (+) ([%w_%.%-]+)$",
    "^[!/#]([Pp]lugin) (-) ([%w_%.%-]+)$",
    "^[!/#]([Pp]lugin) (+) ([%w_%.%-]+) (chat)",
    "^[!/#]([Pp]lugin) (-) ([%w_%.%-]+) (chat)",
    "^[!/#]([Pp]lugin) (*)$",
    "^[!/#]([Rr]eload)$",
	"^([Pp]luginlist)$",
    "^([Pp]lugin) (+) ([%w_%.%-]+)$",
    "^([Pp]lugin) (-) ([%w_%.%-]+)$",
    "^([Pp]lugin) (+) ([%w_%.%-]+) (chat)",
    "^([Pp]lugin) (-) ([%w_%.%-]+) (chat)",
    "^([Pp]lugin) (*)$",
    "^([Rr]eload)$",
    "^(لیست پلاگین)$",
    "^(پلاگین) (+) ([%w_%.%-]+)$",
    "^(پلاگین) (-) ([%w_%.%-]+)$",
    "^(پلاگین) (+) ([%w_%.%-]+) (گروه)",
    "^(پلاگین) (-) ([%w_%.%-]+) (گروه)",
    "^(پلاگین) (*)$",
    "^(بارگذاری)$",
    },
  run = run,
  moderated = true,
  privileged = true
}

end

