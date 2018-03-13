local function load_help(msg)
  local f = io.open("./data/Help.lua", "r")
  	if f then
	f:close()
	local help = loadfile("./data/Help.lua")()
	return help
	else
	return false
	end
end
function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local _help = load_help()
if ((matches[1]:lower() == 'help' ) or (matches[1]:lower() == 'راهنما' )) and is_mod(msg) then
local helpen = _help and _help.helpen
local helpfa = _help and _help.helpfa
local help_en = helpen and helpen.help or "`> Inaccessible`"
local help_fa = helpfa and helpfa.help or "`> قابل دسترسی نمیباشد`"
 if not lang then
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_en, 1, "md")
    else
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_fa, 1, "md")
 end
 end
---------------------------------------
if ((matches[1]:lower() == 'helplock' ) or (matches[1]:lower() == 'راهنمای قفلی' )) and is_mod(msg) then
local helpen = _help and _help.helpen
local helpfa = _help and _help.helpfa
local help_en = helpen and helpen.helplock or "`> Inaccessible`"
local help_fa = helpfa and helpfa.helplock or "`> قابل دسترسی نمیباشد`"
 if not lang then
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_en, 1, "md")
    else
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_fa, 1, "md")
 end
end
---------------------------------------
 if ((matches[1]:lower() == 'helplockpro' ) or (matches[1]:lower() == 'راهنمای قفلی پیشرفته' )) and is_mod(msg) then
local helpen = _help and _help.helpen
local helpfa = _help and _help.helpfa
local help_en = helpen and helpen.helplock4 or "`> Inaccessible`"
local help_fa = helpfa and helpfa.helplock4 or "`> قابل دسترسی نمیباشد`"
 if not lang then
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_en, 1, "md")
    else
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_fa, 1, "md")
 end
end
---------------------------------------
if ((matches[1]:lower() == 'helpmod' ) or (matches[1]:lower() == 'راهنمای مدیریتی' )) and is_mod(msg) then
local helpen = _help and _help.helpen
local helpfa = _help and _help.helpfa
local help_en = helpen and helpen.helpmod or "`> Inaccessible`"
local help_fa = helpfa and helpfa.helpmod or "`> قابل دسترسی نمیباشد`"
 if not lang then
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_en, 1, "md")
    else
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_fa, 1, "md")
 end
end
---------------------------------------
if ((matches[1]:lower() == 'helpfun' ) or (matches[1]:lower() == 'راهنمای سرگرمی' )) and is_mod(msg) then
local helpen = _help and _help.helpen
local helpfa = _help and _help.helpfa
local help_en = helpen and helpen.helpfun or "`> Inaccessible`"
local help_fa = helpfa and helpfa.helpfun or "`> قابل دسترسی نمیباشد`"
 if not lang then
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_en, 1, "md")
    else
   tdcli.sendMessage(msg.to.id, msg.id_, 1, help_fa, 1, "md")
 end
end
---------------------------------------
end

 return { 
  patterns = {
   "^[!#/]([Hh]elp)$",
   "^([Hh]elp)$",
   "^(راهنما)$",
   "^[!#/]([Hh]elplock)$",
   "^([Hh]elplock)$",
   "^(راهنمای قفلی)$",
   "^[!#/]([Hh]elplockpro)$",
   "^([Hh]elplockpro)$",
   "^(راهنمای قفلی پیشرفته)$",
   "^[!#/]([Hh]elpmod)$",
   "^([Hh]elpmod)$",
   "^(راهنمای مدیریتی)$",
   "^[!#/]([Hh]elpfun)$",
   "^([Hh]elpfun)$",
   "^(راهنمای سرگرمی)$",
  }, 
run = run
}