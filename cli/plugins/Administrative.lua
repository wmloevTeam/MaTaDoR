local SUDO = MaTaDoR_sudo
function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

local function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
local function index_function(user_id)
  for k,v in pairs(_config.admins) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end

local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

local function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

local function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end

local function sudolist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = "> *Lιѕт σf ѕυɗσ υѕєяѕ :*\n"
   else
 text = "> *لــیسـت سـودو هـای ربــات :*\n"
  end
for i=1,#sudo_users do
    text = text..i.." - "..sudo_users[i].."\n"
end
return text
end

local function adminlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '> *Lιѕт σf вσт αɗмιηѕ :*\n'
   else
 text = "> *لــیست ادمـین هـای ربــات :*\n"
  end
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..'- '..(user[2] or '')..' ➣ ('..user[1]..')\n'
		  	i = i +1
		  	end
		  	if compare == text then
   if not lang then
		  		text = '> `Ɲσ` *αɗмιηѕ* `αναιƖαвƖє`'
      else
		  		text = '> *ادمـینـی بـرای ربـات تـعیـیـن نـشده*'
           end
		  	end
		  	return text
    end
----------------------------------------
local function chat_list(msg)
	i = 1
	local data = load_data(_config.moderation.data)
    local groups = 'groups'
    if not data[tostring(groups)] then
        return '> *65Ɲσ gяσυρѕ αт тнє мσмєηт*'
    end
    local message = '> لیست گروه ها :\n\n'
    for k,v in pairsByKeys(data[tostring(groups)]) do
		local group_id = v
		if data[tostring(group_id)] then
			settings = data[tostring(group_id)]['settings']
		end	
        for m,n in pairsByKeys(settings) do
		local expire_date = ''
        local expi = redis:ttl('ExpireDate:'..group_id)
		    if expi == -1 then
	        expire_date = 'نامحدود!'
            else
	        local day = math.floor(expi / 86400) + 1
	        expire_date = day
            end
			if m == 'set_name' then
				name = n:gsub("", "") 
				chat_name = name:gsub("‮", "")
				group_name_id = '\n#آیدی گروه :\n•['..group_id..']\n#نام گروه :\n•['..check_markdown(name or "---")..']\n#شارژ گروه :\n•['..expire_date..']\n🔺➖🔻➖🔺➖🔻➖🔺➖🔻\n' 
					group_info = i..' - '..group_name_id
					group_info1 = i
				i = i + 1
			end
        end
		--local file = io.open("./data/gplist.txt", "w")
		--	file:write(message)
		--	file:close()
		--	MaT = "تعداد گروه های مدیریتی :"
		message = message..group_info
		if (i%30)==1 then 
			tdcli.sendMessage(msg.to.id,msg.id_,1,message,1,md)
			message = ""
		end
    end
	--tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./data/gplist.txt", MaT..group_info1, dl_cb, nil)
	tdcli.sendMessage(msg.to.id,msg.id_,1,message,1,md)
end
----------------------------------------

local function botrem(msg)
	local data = load_data(_config.moderation.data)
	data[tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	local groups = 'groups'
	if not data[tostring(groups)] then
		data[tostring(groups)] = nil
		save_data(_config.moderation.data, data)
	end
	data[tostring(groups)][tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	if redis:get('CheckExpire::'..msg.to.id) then
		redis:del('CheckExpire::'..msg.to.id)
	end
	if redis:get('ExpireDate:'..msg.to.id) then
		redis:del('ExpireDate:'..msg.to.id)
	end
	tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end

local function warning(msg)
	local hash = "gp_lang:"..msg.to.id
	local lang = redis:get(hash)
	local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
	if expiretime == -1 then
		return
	else
	local d = math.floor(expiretime / 86400) + 1
        if tonumber(d) == 1 and not is_sudo(msg) and is_mod(msg) then
				tdcli.sendMessage(msg.to.id, 0, 1, '`از شارژ گروه فقط 1 روز باقی مانده است برای اطلاعات بیشتر به پیوی سازنده مراجعه کنید.`', 1, 'md')
		end
	end
end

local function action_by_reply(arg, data)
    local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
    if cmd == "adminprom" then
local function adminprom_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل ادمین ربات بود_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _به مقام ادمین ربات منتصب شد_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, adminprom_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "admindem" then
local function admindem_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
	local nameid = index_function(tonumber(data.id_))
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل ادمین ربات نبود_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از مقام ادمین ربات برکنار شد_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, admindem_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "visudo" then
local function visudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل سودو ربات بود_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _به مقام سودو ربات منتصب شد_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "desudo" then
local function desudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل سودو ربات نبود_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از مقام سودو ربات برکنار شد_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `کاربر یافت نشد`⚠️👣", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `Uѕєя Ɲσт Ƒσυηɗ`⚠️👣", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل ادمین ربات بود_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _به مقام ادمین ربات منتصب شد_", 0, "md")
   end
end
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل ادمین ربات نبود_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از مقام ادمین ربات برکنار شد_", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل سودو ربات بود_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _به مقام سودو ربات منتصب شد_", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل سودو ربات نبود_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از مقام سودو ربات برکنار شد_", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `کاربر یافت نشد`⚠️👣", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Uѕєя Ɲσт Ƒσυηɗ`⚠️👣", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل ادمین ربات بود_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _به مقام ادمین ربات منتصب شد_", 0, "md")
   end
end 
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل ادمین ربات نبود_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از مقام ادمین ربات برکنار شد_", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل سودو ربات بود_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _به مقام سودو ربات منتصب شد_", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از قبل سودو ربات نبود_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n _از مقام سودو ربات برکنار شد_", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `کاربر یافت نشد`⚠️👣", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Uѕєя Ɲσт Ƒσυηɗ`⚠️👣", 0, "md")
      end
   end
end

local function pre_process(msg)
	if msg.to.type ~= 'pv' then
		local hash = "gp_lang:"..msg.to.id
		local lang = redis:get(hash)
		local data = load_data(_config.moderation.data)
		local gpst = data[tostring(msg.to.id)]
		local chex = redis:get('CheckExpire::'..msg.to.id)
		local exd = redis:get('ExpireDate:'..msg.to.id)
		if gpst and not chex and msg.from.id ~= SUDO and not is_sudo(msg) then
			redis:set('CheckExpire::'..msg.to.id,true)
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 86400, true)
				tdcli.sendMessage(msg.to.id, msg.id_, 1, '> `تنها 1 روز تا پایان شارژ شما باقیمانده، . لطفا با سودو برای شارژ بیشتر تماس بگیرید. در غیر اینصورت گروه شما از لیست ربات حذف و ربات گروه را ترک خواهد کرد.`', 1, 'md')
		end
		if chex and not exd and msg.from.id ~= SUDO and not is_sudo(msg) then
			local text1 = '> شارژ این گروه به اتمام رسید \n\nID:  <code>'..msg.to.id..'</code>\n\nدر صورتی که میخواهید ربات این گروه را ترک کند از دستور زیر استفاده کنید\n\n/leave '..msg.to.id..'\nبرای جوین دادن توی این گروه میتونی از دستور زیر استفاده کنی:\n/jointo '..msg.to.id..'\n_________________\nدر صورتی که میخواهید گروه رو دوباره شارژ کنید میتوانید از کد های زیر استفاده کنید...\n\n<b>برای شارژ 1 ماهه:</b>\n/plan 1 '..msg.to.id..'\n\n<b>برای شارژ 3 ماهه:</b>\n/plan 2 '..msg.to.id..'\n\n<b>برای شارژ نامحدود:</b>\n/plan 3 '..msg.to.id
			local text2 = '> `شارژ این گروه به پایان رسید. به دلیل عدم شارژ مجدد، گروه از لیست ربات حذف و ربات از گروه خارج می ‌‌شود.`'
				tdcli.sendMessage(SUDO, 0, 1, text1, 1, 'html')
				tdcli.sendMessage(msg.to.id, 0, 1, text2, 1, 'md')
			botrem(msg)
		else
			local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
			local day = (expiretime / 86400)
			if tonumber(day) > 0.208 and not is_sudo(msg) and is_mod(msg) then
				warning(msg)
			end
		end
	end
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
if tonumber(msg.from.id) == SUDO or is_sudio(msg) then
if (matches[1]:lower() == "sudoset" ) or (matches[1] == "افزودن سودو" ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="visudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="visudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="visudo"})
      end
   end
if (matches[1]:lower() == "sudodem" ) or (matches[1] == "حذف سودو" ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="desudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="desudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="desudo"})
      end
   end
	if ((matches[1]:lower() == "sendfile" ) or (matches[1] == 'ارسال فایل' )) and matches[2] and matches[3] then
		local send_file = "./"..matches[2].."/"..matches[3]
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, MaTaDoRch, dl_cb, nil)
	end
	if ((matches[1]:lower() == "sendplug" ) or (matches[1] == 'ارسال پلاگین' )) and matches[2] then
	    local plug = "./plugins/"..matches[2]..".lua"
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, plug, MaTaDoRch, dl_cb, nil)
    end
if (matches[1]:lower() == "setend") or (matches[1] == "تنظیم پایان") then
redis:set("setend",matches[2])
return "Doɴe!\nSeтeɴd To :\n"..matches[2]
end
if (matches[1]:lower() == "delend") or (matches[1] == "حذف پایان") then
redis:del("setend")
return "Doɴe!\nEɴd мѕɢ Deleтed"
end
----------------------------------------
end
if is_sudo(msg) then
if matches[1] == "فعال سازی" then
redis:set("MaTaDoRLikes",2345)
redis:set("MaTaDoRDisLikes",189)
return "انجام شد"
end
if msg.to.type ~= 'pv' then
		if ((matches[1]:lower() == 'gid' ) or (matches[1] == 'گروه ایدی' )) and is_admin(msg) then
			tdcli.sendMessage(msg.to.id, msg.id_, 1, '`'..msg.to.id..'`', 1,'md')
		end
end
		if ((matches[1]:lower() == 'leave' ) or (matches[1] == 'خروج' )) and matches[2] and is_admin(msg) then
			if lang then
				tdcli.sendMessage(matches[2], 0, 1, 'ربات با دستور سودو از گروه خارج شد.\nبرای اطلاعات بیشتر با سودو تماس بگیرید.', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(SUDO, msg.id_, 1, 'ربات با موفقیت از گروه '..matches[2]..' خارج شد.', 1,'md')
			else
				tdcli.sendMessage(matches[2], 0, 1, '`Rσвσт Ɩєfт тнє gяσυρ.`\n*Ƒσя мσяє ιηfσямαтιση cσηтαcт Ƭнє SUƊO.*', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(SUDO, msg.id_, 1, '*Robot left from under group successfully:*\n\n`'..matches[2]..'`', 1,'md')
			end
		end
		if ((matches[1]:lower() == 'charge' ) or (matches[1] == "شارژ" )) and matches[2] and matches[3] and is_admin(msg) then
		if string.match(matches[2], '^.*$') then
			if tonumber(matches[3]) > 0 and tonumber(matches[3]) < 1001 then
				local extime = (tonumber(matches[3]) * 86400)
				redis:setex('ExpireDate:'..matches[2], extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				local linkgp = data[tostring(chat)]['settings']['linkgp']
                if not linkgp then
                  return '`لطفا قبل از شارژ گروه لینک گروه را تنظیم کنید 🌹`\n*"تنظیم لینک [لینک]"\n"setlink [link]"*'
                end
				local data = load_data(_config.moderation.data)
                local i = 1
                 if next(data[tostring(msg.to.id)]['owners']) == nil then 
                 return '`لطفا قبل از شارژ گروه مالک گروه را تنظیم کنید 🌹`\n_یا میتوانید از دستور زیر استفاده کنید_\n*"Config"*\n*"پیکربندی"*'
                 end
                 message = '\n'
                 for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
                 message = message ..i.. '- '..v..' [' ..k.. '] \n'
                 i = i + 1
                 end
                 if next(data[tostring(msg.to.id)]['mods']) == nil then 
                 return '`لطفا قبل از شارژ گروه مدیر گروه را تنظیم کنید 🌹`\n_یا میتوانید از دستور زیر استفاده کنید_\n*"Config"*\n*"پیکربندی"*'
                 end
                 message2 = '\n'
                 for k,v in pairs(data[tostring(msg.to.id)]['mods']) do
                 message2 = message2 ..i.. '- '..v..' [' ..k.. '] \n'
                 i = i + 1
                 end
					tdcli.sendMessage(GpsidSudo, msg.id_, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..matches[2].."`\n>_مقدار شارژ انجام داده ؛_ `"..matches[3].."`\n_>لینک گروه ؛_\n"..check_markdown(linkgp).."\n_>لیست مالک گروه ؛_ "..message.."\n_>لیست مدیران گروه؛_ "..message2.."\n\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..matches[2].."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..matches[2].."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..matches[2].."`", 1, 'md')
					tdcli.sendMessage(matches[2], 0, 1, '*Rσвσт яєcнαяgєɗ* `'..matches[3]..'` *ɗαу(ѕ)*\n*Ƒσя cнєcкιηg єxριяє ɗαтє, ѕєηɗ* `/cнєcкєxριяє`',1 , 'md')
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '`تعداد روزها باید عددی از` *1* `تا` *1000* `باشد.`', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '`Ɛxριяє ɗαуѕ мυѕт вє вєтωєєη` *1 - 1000*', 1, 'md')
				end
			end
		end
		end
		if (matches[1]:lower() == 'plan' ) or (matches[1] == 'پلن' ) then
		        local linkgp = data[tostring(chat)]['settings']['linkgp']
                if not linkgp then
                  return '`لطفا قبل از شارژ گروه لینک گروه را تنظیم کنید 🌹`\n*"تنظیم لینک [لینک]"\n"setlink [link]"*'
                end
				local data = load_data(_config.moderation.data)
                local i = 1
                 if next(data[tostring(msg.to.id)]['owners']) == nil then 
                 return '`لطفا قبل از شارژ گروه مالک گروه را تنظیم کنید 🌹`\n_یا میتوانید از دستور زیر استفاده کنید_\n*"Config"*\n*"پیکربندی"*'
                 end
                 message = '\n'
                 for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
                 message = message ..i.. '- '..v..' [' ..k.. '] \n'
                 i = i + 1
                 end
                 if next(data[tostring(msg.to.id)]['mods']) == nil then 
                 return '`لطفا قبل از شارژ گروه مدیر گروه را تنظیم کنید 🌹`\n_یا میتوانید از دستور زیر استفاده کنید_\n*"Config"*\n*"پیکربندی"*'
                 end
                 message2 = '\n'
                 for k,v in pairs(data[tostring(msg.to.id)]['mods']) do
                 message2 = message2 ..i.. '- '..v..' [' ..k.. '] \n'
                 i = i + 1
                 end
		if matches[2] == '1' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^.*$') then
			local timeplan1 = 2592000
			redis:setex('ExpireDate:'..matches[3], timeplan1, true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
				tdcli.sendMessage(GpsidSudo, msg.id_, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..msg.to.id.."`\n>_مقدار شارژ انجام داده ؛_ `30`\n_>لینک گروه ؛_\n"..check_markdown(linkgp).."\n_>لیست مالک گروه ؛_ "..message.."\n_>لیست مدیران گروه؛_ "..message2.."\n\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..msg.to.id.."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..msg.to.id.."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..msg.to.id.."`", 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Sυccєѕѕƒυℓℓу яєcнαяgє∂*\n*Ɛχριяє Ɗαтє:* `30` *Ɗαуѕ (1 Mσηтн)*', 1, 'md')
		end
		end
		if matches[2] == '2' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^.*$') then
			local timeplan2 = 7776000
			redis:setex('ExpireDate:'..matches[3],timeplan2,true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
				tdcli.sendMessage(GpsidSudo, msg.id_, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..msg.to.id.."`\n>_مقدار شارژ انجام داده ؛_ `60`\n_>لینک گروه ؛_\n"..check_markdown(linkgp).."\n_>لیست مالک گروه ؛_ "..message.."\n_>لیست مدیران گروه؛_ "..message2.."\n\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..msg.to.id.."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..msg.to.id.."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..msg.to.id.."`", 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Sυccєѕѕƒυℓℓу яєcнαяgє∂*\n*Ɛχριяє Ɗαтє:* `90` *Ɗαуѕ (3 Mσηтнѕ)*', 1, 'md')
		end
		end
		if matches[2] == '3' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^.*$') then
			redis:set('ExpireDate:'..matches[3],true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
				tdcli.sendMessage(GpsidSudo, msg.id_, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..msg.to.id.."`\n>_مقدار شارژ انجام داده ؛_ `نامحدود !`\n_>لینک گروه ؛_\n"..check_markdown(linkgp).."\n_>لیست مالک گروه ؛_ "..message.."\n_>لیست مدیران گروه؛_ "..message2.."\n\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..msg.to.id.."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..msg.to.id.."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..msg.to.id.."`", 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Sυccєѕѕƒυℓℓу яєcнαяgє∂*\n*Ɛχριяє Ɗαтє:* `Uηℓιмιтє∂`', 1, 'md')
		end
		end
		end
		if ((matches[1]:lower() == 'jointo' ) or (matches[1] == 'ورود به' )) and matches[2] and is_admin(msg) then
		if string.match(matches[2], '^.*$') then
			if lang then
				tdcli.sendMessage(SUDO, msg.id_, 1, 'با موفقیت تورو به گروه '..matches[2]..' اضافه کردم.', 1, 'md')
				tdcli.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, '_سودو به گروه اضافه شد._', 1, 'md')
			else
				tdcli.sendMessage(SUDO, msg.id_, 1, '*I α∂∂є∂ уσυ тσ тнιѕ gяσυρ:*\n\n`'..matches[2]..'`', 1, 'md')
				tdcli.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, 'A∂мιη Jσιηє∂!', 1, 'md')
			end
		end
		end
end
	if msg.to.type == 'channel' or msg.to.type == 'chat' then
		if ((matches[1]:lower() == 'charge' ) or (matches[1] == 'شارژ' )) and matches[2] and not matches[3] and is_sudo(msg) then
			if tonumber(matches[2]) > 0 and tonumber(matches[2]) < 1001 then
				local extime = (tonumber(matches[2]) * 86400)
				redis:setex('ExpireDate:'..msg.to.id, extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id)
				end
				local linkgp = data[tostring(chat)]['settings']['linkgp']
                if not linkgp then
                  return '`لطفا قبل از شارژ گروه لینک گروه را تنظیم کنید 🌹`\n*"تنظیم لینک [لینک]"\n"setlink [link]"*'
                end
				local data = load_data(_config.moderation.data)
                local i = 1
                 if next(data[tostring(msg.to.id)]['owners']) == nil then 
                 return '`لطفا قبل از شارژ گروه مالک گروه را تنظیم کنید 🌹`\n_یا میتوانید از دستور زیر استفاده کنید_\n*"Config"*\n*"پیکربندی"*'
                 end
                 message = '\n'
                 for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
                 message = message ..i.. '- '..v..' [' ..k.. '] \n'
                 i = i + 1
                 end
                 if next(data[tostring(msg.to.id)]['mods']) == nil then 
                 return '`لطفا قبل از شارژ گروه مدیر گروه را تنظیم کنید 🌹`\n_یا میتوانید از دستور زیر استفاده کنید_\n*"Config"*\n*"پیکربندی"*'
                 end
                 message2 = '\n'
                 for k,v in pairs(data[tostring(msg.to.id)]['mods']) do
                 message2 = message2 ..i.. '- '..v..' [' ..k.. '] \n'
                 i = i + 1
                 end                        
					tdcli.sendMessage(GpsidSudo, msg.id_, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..msg.to.id.."`\n>_مقدار شارژ انجام داده ؛_ `"..matches[2].."`\n_>لینک گروه ؛_\n"..check_markdown(linkgp).."\n_>لیست مالک گروه ؛_ "..message.."\n_>لیست مدیران گروه؛_ "..message2.."\n\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..msg.to.id.."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..msg.to.id.."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..msg.to.id.."`", 1, 'md')
			    if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, 'گروه به مدت '..matches[2]..' روز شارژ شد.', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, 'Ɗσηє\nƓяσυρ Ƈнαяgє : '..matches[2]..'', 1, 'md')
				end
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '`تعداد روزها باید عددی از` *1* `تا` *1000* `باشد.`', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '`Ɛxριяє ɗαуѕ мυѕт вє вєтωєєη` *1 - 1000*', 1, 'md')
				end
			end
		end
		if ((matches[1]:lower() == 'checkexpire' ) or (matches[1] == 'اعتبار' )) and is_mod(msg) and not matches[2] and is_owner(msg) then
local check_time = redis:ttl('ExpireDate:'..msg.to.id)
			year = math.floor(check_time / 31536000)
			byear = check_time % 31536000
			month = math.floor(byear / 2592000)
			bmonth = byear % 2592000
			day = math.floor(bmonth / 86400)
			bday = bmonth % 86400
			hours = math.floor( bday / 3600)
			bhours = bday % 3600
			min = math.floor(bhours / 60)
			sec = math.floor(bhours % 60)
			if not lang then
				if check_time == -1 then
					remained_expire = '_Unlimited Charging!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_Expire until_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_Expire until_ '..min..' _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_Expire until_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_Expire until_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_Expire until_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_Expire until_ *'..year..'* _year_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
			else
				if check_time == -1 then
					remained_expire = '_گروه به صورت نامحدود شارژ می‌باشد!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_گروه به مدت_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_گروه به مدت_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_گروه به مدت_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_گروه به مدت_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_گروه به مدت_ *'..month..'* _ماه_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_گروه به مدت_ *'..year..'* _سال_ *'..month..'* _ماه_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
			end
		end
		end
		if ((matches[1]:lower() == 'checkexpire' ) or (matches[1] == 'اعتبار' )) and is_mod(msg) and matches[2] and is_admin(msg) then
if string.match(matches[2], '^-%d+$') then
			local check_time = redis:ttl('ExpireDate:'..matches[2])
			year = math.floor(check_time / 31536000)
			byear = check_time % 31536000
			month = math.floor(byear / 2592000)
			bmonth = byear % 2592000
			day = math.floor(bmonth / 86400)
			bday = bmonth % 86400
			hours = math.floor( bday / 3600)
			bhours = bday % 3600
			min = math.floor(bhours / 60)
			sec = math.floor(bhours % 60)
			if not lang then
				if check_time == -1 then
					remained_expire = '_Unlimited Charging!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_Expire until_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_Expire until_ '..min..' _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_Expire until_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_Expire until_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_Expire until_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_Expire until_ *'..year..'* _year_ *'..month..'* _month_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
			else
				if check_time == -1 then
					remained_expire = '_گروه به صورت نامحدود شارژ می باشد!_'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '_گروه به مدت_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '_گروه به مدت_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '_گروه به مدت_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '_گروه به مدت_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '_گروه به مدت_ *'..month..'* _ماه_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '_گروه به مدت_ *'..year..'* _سال_ *'..month..'* _ماه_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه شارژ می‌باشد_'
				end
				tdcli.sendMessage(msg.to.id, msg.id_, 1, remained_expire, 1, 'md')
			end
		end
	end
if ((matches[1]:lower() == "adminset" ) or (matches[1] == "افزودن ادمین" )) and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="adminprom"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="adminprom"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="adminprom"})
      end
   end
if ((matches[1]:lower() == "admindem" ) or (matches[1] == "حذف ادمین" )) and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.to.id,cmd="admindem"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="admindem"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="admindem"})
      end
   end

if ((matches[1]:lower() == 'creategroup' ) or (matches[1] == 'ساخت گروه' )) and is_admin(msg) then
local text = matches[2]
tdcli.createNewGroupChat({[0] = msg.from.id}, text, dl_cb, nil)
  if not lang then
return '_Ɠяσυρ Hαѕ Ɓєєη Ƈяєαтєɗ!_'
  else
return '_گروه ساخته شد!_'
   end
end

if ((matches[1]:lower() == 'createsuper' ) or (matches[1] == 'ساخت سوپر گروه' )) and is_admin(msg) then
local text = matches[2]
tdcli.createNewChannelChat(text, 1, '', (function(b, d) tdcli.addChatMember(d.id_, msg.from.id, 0, dl_cb, nil) end), nil)
   if not lang then 
return '_SυρєяƓяσυρ Hαѕ Ɓєєη Ƈяєαтєɗ αηɗ_ [`'..msg.from.id..'`] _Jσιηєɗ Ƭσ Ƭнιѕ SυρєяƓяσυρ._'
  else
return '_سوپرگروه ساخته شد و_ [`'..msg.from.id..'`] _به گروه اضافه شد._'
   end
end

if ((matches[1]:lower() == 'tosuper' ) or (matches[1] == 'تبدیل به سوپر' )) and is_admin(msg) then
local id = msg.to.id
tdcli.migrateGroupChatToChannelChat(id, dl_cb, nil)
  if not lang then
return '_Ɠяσυρ Hαѕ Ɓєєη Ƈнαηgєɗ Ƭσ SυρєяƓяσυρ!_'
  else
return '_گروه به سوپر گروه تبدیل شد!_'
   end
end

if ((matches[1]:lower() == 'import' ) or (matches[1] == 'ورود به' )) and is_admin(msg) then
if matches[2]:match("^([https?://w]*.?telegram.me/joinchat/.*)$") or matches[2]:match("^([https?://w]*.?t.me/joinchat/.*)$") then
local link = matches[2]
if link:match('t.me') then
link = string.gsub(link, 't.me', 'telegram.me')
end
tdcli.importChatInviteLink(link, dl_cb, nil)
   if not lang then
return '*Bot Success Joined :)*'
  else
return '*ربات با موفقیت وارد گروه شد :)*'
  end
  end
end

if ((matches[1]:lower() == 'setbotname' ) or (matches[1] == 'تغییر نام ربات' )) and is_sudo(msg) then
tdcli.changeName(matches[2])
   if not lang then
return '_Ɓσт Ɲαмє Ƈнαηgєɗ Ƭσ:_ *'..matches[2]..'*'
  else
return '_اسم ربات تغییر کرد به:_ \n*'..matches[2]..'*'
   end
end

if ((matches[1]:lower() == 'setbotusername' ) or (matches[1] == 'تغییر یوزرنیم ربات' )) and is_sudo(msg) then
tdcli.changeUsername(matches[2])
   if not lang then
return '_Ɓσт Uѕєяηαмє Ƈнαηgєɗ Ƭσ:_ @'..matches[2]
  else
return '_یوزرنیم ربات تغییر کرد به:_ \n@'..matches[2]..''
   end
end

if ((matches[1]:lower() == 'delbotusername' ) or (matches[1] == 'حذف یوزرنیم ربات' )) and is_sudo(msg) then
tdcli.changeUsername('')
   if not lang then
return '*Ɗσηє!*'
  else
return '*انجام شد!*'
  end
end

if ((matches[1]:lower() == 'markread' ) or (matches[1] == 'تیک دوم' )) and is_sudo(msg) then
if matches[2]:lower() == 'on' or matches[2] == 'فعال' then
redis:set('markread','on')
   if not lang then
return '_Mαякяєαɗ >_ *OƝ*'
else
return '_تیک دوم >_ *روشن*'
   end
end
if matches[2]:lower() == 'off' or matches[2] == 'غیرفعال' then
redis:set('markread','off')
  if not lang then
return '_Mαякяєαɗ >_ *OƑƑ*'
   else
return '_تیک دوم >_ *خاموش*'
      end
   end
end

if ((matches[1]:lower() == 'bc' ) or (matches[1] == 'ارسال' )) and is_admin(msg) then
		local text = matches[2]
tdcli.sendMessage(matches[3], 0, 0, text, 0)	
end

if ((matches[1]:lower() == 'broadcast' ) or (matches[1] == 'ارسال به همه' )) and is_sudo(msg) then		
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
end	
end

if ((matches[1]:lower() == 'sudolist' ) or  (matches[1] == 'لیست سودو' )) and is_sudo(msg) then
return sudolist(msg)
    end
if ((matches[1]:lower() == 'chats' ) or (matches[1] == 'لیست گروه ها' )) and is_admin(msg) then
return chat_list(msg)
end
   if ((matches[1]:lower() == 'join' ) or (matches[1] == 'افزودن' )) and matches[2] and is_admin(msg) and matches[2] then
	   tdcli.sendMessage(msg.to.id, msg.id, 1, 'I Iηνιтє уσυ ιη '..matches[2]..'', 1, 'html')
	   tdcli.sendMessage(matches[2], 0, 1, "Aɗмιη Jσιηєɗ! :)", 1, 'html')
    tdcli.addChatMember(matches[2], msg.from.id, 0, dl_cb, nil)
  end
		if ((matches[1]:lower() == 'rem') or (matches[1] == 'لغو نصب')) and matches[2] and is_admin(msg) then
    local data = load_data(_config.moderation.data)
			-- Group configuration removal
			data[tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = nil
				save_data(_config.moderation.data, data)
			end
			data[tostring(groups)][tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
	   tdcli.sendMessage(matches[2], 0, 1, "Ɠяσυρ нαѕ вєєη яємσνєɗ ву αɗмιη cσммαηɗ", 1, 'html')
    return '`Ɠяσυρ` *'..matches[2]..'* `яємσνєɗ`'
		end
if ((matches[1]:lower() == 'adminlist' ) or (matches[1] == 'لیست ادمین')) and is_admin(msg) then
return adminlist(msg)
    end
     if ((matches[1]:lower() == 'leave' ) or (matches[1] == 'خروج')) and is_admin(msg) then
  tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
   end
     if ((matches[1]:lower() == 'autoleave') or (matches[1] == 'خروج خودکار')) and is_admin(msg) then
local hash = 'auto_leave_bot'
--Enable Auto Leave
     if matches[2] == 'on' or matches[2] == 'فعال' then
    redis:del(hash)
   return 'Aυтσ Ɩєανє нαѕ вєєη єηαвƖєɗ'
--Disable Auto Leave
     elseif matches[2] == 'off' or matches[2] == 'غیرفعال' then
    redis:set(hash, true)
   return 'Aυтσ Ɩєανє нαѕ вєєη ɗιѕαвƖєɗ'
--Auto Leave Status
      elseif matches[2] == 'status' or  matches[2] == 'موقعیت' then
      if not redis:get(hash) then
   return 'Aυтσ Ɩєανє ιѕ єηαвƖє'
       else
   return 'Aυтσ Ɩєανє ιѕ ɗιѕαвƖє'
         end
      end
   end
if (matches[1]:lower() == 'matador' or matches[1] == 'ماتادور') and is_sudio(msg) then
local info_text = 
[[
》MaTaDoR Cli v7.5

An advanced administration bot based on https://valtman.name/telegram-cli

》Admins :
》@MahDiRoO ➣ Founder & Developer《
》@Xamarin\_Developer ➣ Algorithms《
》@SaberTiger ➣ Algorithms《

》Our channel :
》@MaTaDoRTeaM《

Shoper : ]]..check_markdown(paypingname)..[[

Info :]]..check_markdown(MaTaDoRby)..[[

]]..check_markdown(MaTaDoRch)..[[
]]
return tdcli.sendMessage(msg.to.id, msg.id, 1, info_text, 1, 'md')
end
end

return { 
patterns = {                                                                   
"^[!/#]([Ss]udoset)$", 
"^[!/#]([Ss]udodem)$",
"^[!/#]([S]sudolist)$",
"^[!/#]([Ss]udoset) (.*)$", 
"^[!/#]([Ss]udodem) (.*)$",
"^[!/#]([Aa]dminset)$", 
"^[!/#]([Aa]dmindem)$",
"^[!/#]([Aa]dminlist)$",
"^[!/#]([Aa]dminset) (.*)$", 
"^[!/#]([Aa]dmindem) (.*)$",
"^[!/#]([Ll]eave)$",
"^[!/#]([Aa]utoleave) (.*)$", 
"^[!/#]([Mm]atador)$",
"^[!/#]([Cc]reategroup) (.*)$",
"^[!/#]([Cc]reatesuper) (.*)$",
"^[!/#]([Tt]osuper)$",
"^[!/#]([Cc]hats)$",
"^[!/#]([Jj]oin) (-%d+)$",
"^[!/#]([Rr]em) (-%d+)$",
"^[!/#]([Ii]mport) (.*)$",
"^[!/#]([Ss]etbotname) (.*)$",
"^[!/#]([Ss]etbotusername) (.*)$",
"^[!/#]([Dd]elbotusername) (.*)$",
"^[!/#]([Mm]arkread) (.*)$",
"^[!/#]([Bb]c) +(.*) (-%d+)$",
"^[!/#]([Bb]roadcast) (.*)$",
"^[!/#]([Ss]endfile) (.*) (.*)$",
"^[!/#]([Ss]endplug) (.*)$",
"^[!/#]([Aa]dd)$",
"^[!/#]([Gg]id)$",
"^[!/#]([Cc]heckexpire)$",
"^[!/#]([Cc]heckexpire) (-%d+)$",
"^[!/#]([Cc]harge) (-%d+) (%d+)$",
"^[!/#]([Cc]harge) (%d+)$",
"^[!/#]([Jj]ointo) (-%d+)$",
"^[!/#]([Ll]eave) (-%d+)$",
"^[!/#]([Pp]lan) ([123]) (-%d+)$",
"^[!/#]([Rr]em)$",
"^([Ss]udoset)$", 
"^([Ss]udodem)$",
"^([Ss]udolist)$",
"^([Ss]udoset) (.*)$", 
"^([Ss]udodem) (.*)$",
"^([Aa]dminset)$", 
"^([Aa]dmindem)$",
"^([Aa]dminlist)$",
"^([Aa]dminset) (.*)$", 
"^([Aa]dmindem) (.*)$",
"^([Ll]eave)$",
"^([Aa]utoleave) (.*)$", 
"^([Mm]atador)$",
"^([Cc]reategroup) (.*)$",
"^([Cc]reatesuper) (.*)$",
"^([Tt]osuper)$",
"^([Cc]hats)$",
"^([Jj]oin) (-%d+)$",
"^([Rr]em) (-%d+)$",
"^([Ii]mport) (.*)$",
"^([Ss]etbotname) (.*)$",
"^([Ss]etbotusername) (.*)$",
"^([Dd]elbotusername) (.*)$",
"^([Mm]arkread) (.*)$",
"^([Bb]c) +(.*) (-%d+)$",
"^([Bb]roadcast) (.*)$",
"^([Ss]endfile) (.*) (.*)$",
"^([Ss]endplug) (.*)$",
"^([Aa]dd)$",
"^([Gg]id)$",
"^([Cc]heckexpire)$",
"^([Cc]heckexpire) (-%d+)$",
"^([Cc]harge) (-%d+) (%d+)$",
"^([Cc]harge) (%d+)$",
"^([Jj]ointo) (-%d+)$",
"^([Ll]eave) (-%d+)$",
"^([Pp]lan) ([123]) (-%d+)$",
"^([Rr]em)$",
"^[/#!]([Ss]etend) (.*)$",
"^([Ss]etend) (.*)$",
"^[/#!]([Dd]elend)$",
"^([Dd]elend)$",
"^(تنظیم پایان) (.*)$",
"^(حذف پایان)$",
	"^(نصب)$",
	"^(لغو نصب)$",
    "^(لغو نصب) (-%d+)$",	
	"^(لیست سودو)$",
	"^(گروه ایدی)$",
	"^(ساخت گروه) (.*)$",
	"^(ورود به) (-%d+)$",
	"^(ساخت گروه) (.*)$",
	"^(ساخت سوپرگروه) (.*)$",
	"^(افزودن سودو)$",
	"^(افزودن سودو) (.*)$",	
	"^(حذف سودو)$",
	"^(حذف سودو) (.*)$",	
	"^(افزودن ادمین)$",
	"^(افزودن ادمین) (.*)$",
	"^(حذف ادمین)$",
	"^(حذف ادمین) (.*)$",
	"^(ارسال فایل) (.*)$",
	"^(حذف یوزرنیم ربات) (.*)$",
    "^(تغییر یوزرنیم ربات) (.*)$",
	"^(تغییر نام ربات) (.*)$",
	"^(تبدیل به سوپرگروه)$",
	"^(ارسال به همه) (.*)$",
	"^(لیست گروه ها)$",
	"^(خروج)$",
	"^(خروج) (-%d+)$",	
	"^(ارسال پلاگین) (.*)$",
	"^(لیست ادمین)$",
	"^(خروج خودکار) (.*)$",
    "^(شارژ) (-%d+) (%d+)$",
    "^(شارژ) (%d+)$",	
    "^(پلن) ([123]) (-%d+)$",
    "^(اعتبار)$",
	"^(فعال سازی)$",
    "^(اعتبار) (-%d+)$",
    "^(تیک دوم) (.*)$",
    "^(ارسال) +(.*) (-%d+)$",
	"^(نصب) (-%d+)$",
	"^(ماتادور)$",
}, 
run = run, pre_process = pre_process
}
