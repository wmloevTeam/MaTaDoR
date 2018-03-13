local function action_by_reply(arg, data)
local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
  if cmd == "warn" then
local function warn_cb(arg, data)
local msg = arg.msg
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, data.id_) or 1
local max_warn = tonumber(redis:get('max_warn:'..arg.chat_id) or 5)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _I Can't Warn_ *My Self*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ `من نمیتوانم به خودم اخطار دهم`", 0, "md")
         end
     end
   if is_mod1(arg.chat_id, data.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _You Can't Warn_ *Mods,Owners and Bot Admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ `شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
   if is_admin1(data.id_)then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _You Can't Warn_ *Bot Admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ `شما نمیتوانید به ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(data.id_, arg.chat_id)
redis:hdel(hashwarn, data.id_, '0')
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n _Has Been_ *Kicked* _Because Max Warning_\nNumber Of Warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n به دلیل دریافت اخطار بیش از حد اخراج شد\nتعداد اخطار ها : "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, data.id_, tonumber(warnhash) + 1)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n_You've_ "..warnhash.." _Of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *شما یک اخطار دریافت کردید*\n*تعداد اخطار های شما : "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, warn_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_,msg=arg.msg})
  end
   if cmd == "unwarn" then
local function unwarn_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local hashwarn = arg.chat_id..':warn'
local warnhash = redis:hget(hashwarn, data.id_) or 1
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not redis:hget(hashwarn, data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n _Don't Have_ *Warning*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *هیچ اخطاری دریافت نکرده*", 0, "md")
    end
  else
redis:hdel(hashwarn, data.id_, '0')
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _All Warn Of_\n "..user_name.." *"..data.id_.."*\n _Has Been_ *Cleaned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _تمامی اخطار های_\n "..user_name.." *"..data.id_.."*\n *پاک شدند*", 0, "md")
      end
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unwarn_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
    end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "⇝ _کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "⇝ *User Not Found*", 0, "md")
      end
   end
end
local function action_by_username(arg, data)
if data.id_ then
local cmd = arg.cmd
local msg = arg.msg
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, data.id_) or 1
local max_warn = tonumber(redis:get('max_warn:'..arg.chat_id) or 5)
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
   if cmd == "warn" then
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *من نمیتوانم به خودم اخطار دهم*", 0, "md")
         end
     end
   if is_mod1(arg.chat_id, data.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
   if is_admin1(data.id_)then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *شما نمیتوانید به ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(data.id_, arg.chat_id)
redis:hdel(hashwarn, data.id_, '0')
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been_ *kicked* _because max warning_\nNumber of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n به دلیل دریافت اخطار بیش از حد اخراج شد\nتعداد اخطار ها : "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, data.id_, tonumber(warnhash) + 1)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *شما یک اخطار دریافت کردید*\n*تعداد اخطار های شما : "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
   if cmd == "unwarn" then
if not redis:hget(hashwarn, data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *هیچ اخطاری دریافت نکرده*", 0, "md")
    end
  else
redis:hdel(hashwarn, data.id_, '0')
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_All warn of_\n "..user_name.." *"..data.id_.."*\n _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_تمامی اخطار های_\n "..user_name.." *"..data.id_.."*\n *پاک شدند*", 0, "md")
    end
  end
end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User Not Found*", 0, "md")
      end
   end
end
	local function action_by_id(arg, data)
    if data.id_ then
local cmd = arg.cmd
local msg = arg.msg
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, data.id_) or 1
local max_warn = tonumber(redis:get('max_warn:'..arg.chat_id) or 5)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if cmd == "warn" then
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ `من نمیتوانم به خودم اخطار دهم`", 0, "md")
         end
     end
   if is_mod1(arg.chat_id, data.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ `شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
   if is_admin1(data.id_)then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ `شما نمیتوانید به ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(data.id_, arg.chat_id)
redis:hdel(hashwarn, data.id_, '0')
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n _has been_ *kicked* _because max warning_\n_Number of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n به دلیل دریافت اخطار بیش از حد اخراج شد\nتعداد اخطار ها : "..hashwarn.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, data.id_, tonumber(warnhash) + 1)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *شما یک اخطار دریافت کردید*\n*تعداد اخطار های شما : "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
   if cmd == "unwarn" then
if not redis:hget(hashwarn, data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User :*\n["..user_name.."] `[ "..data.id_.." ]`\n _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *هیچ اخطاری دریافت نکرده*", 0, "md")
    end
  else
redis:hdel(hashwarn, data.id_, '0')
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _All warn of_\n "..user_name.." *"..data.id_.."*\n _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _تمامی اخطار های_\n "..user_name.." *"..data.id_.."*\n *پاک شدند*", 0, "md")
    end
  end
end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ _کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "⇝ *User Not Found*", 0, "md")
      end
   end
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
		if ((matches[1]:lower() == 'clean' and matches[2] == 'warns' ) or (matches[1] == "پاک کردن" and matches[2] == 'اخطار ها' )) then
			if not is_owner(msg) then
				return
			end
    local hash = msg.to.id..':warn'
    redis:del(hash)
    if not lang then
     return "⇝ _All_ *warn* _of_ *users* _in this_ *group* _has been_ *cleaned*"
   else
     return "⇝ _تمام اخطار های کاربران این گروه پاک شد_"
		end
  end
if ((matches[1]:lower() == "warn" ) or (matches[1] == "اخطار" )) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="warn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="warn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="warn"})
      end
   end
if ((matches[1]:lower() == "unwarn" ) or (matches[1] == "حذف اخطار" )) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="unwarn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="unwarn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="unwarn"})
     end
	end
	if ((matches[1]:lower() == "warnlist" ) or (matches[1] == "لیست اخطار" )) and is_mod(msg) then
	local list = 'لیست اخطار :\n'
local empty = list
		for k,v in pairs (redis:hkeys(msg.to.id..':warn')) do
  		local user_info = redis:hgetall('user:'..v)
					local cont = redis:hget(msg.to.id..':warn', v)
		if user_info and user_info.user_name then
		list = list..k..'- '..check_markdown(user_info.user_name)..' [`'..v..'`] *اخطار : '..(cont - 1)..'*\n'
       else
		list = list..k..'- `'..v..'` *اخطار : '..(cont - 1)..'*\n'
      end
    end
		if list == empty then
		return '⇝ *لیست اخطار خالی میباشد*'
		else
		return list
		end
	end
end
local function pre_process(msg)
    local hash = 'user:'..msg.from.id
    if msg.from.username then
     user_name = '@'..msg.from.username
  else
     user_name = msg.from.print_name
    end
      redis:hset(hash, 'user_name', user_name)
end

return {
  patterns = {
  "^[#!/]([Ww]arn)$",
  "^[#!/]([Ww]arn) (.*)$",
  "^[#!/]([Uu]nwarn)$",
  "^[#!/]([Uu]nwarn) (.*)$",
  "^[#!/]([Cc]lean) (warns)$",
  "^[#!/]([Ww]arnlist)$",
  "^([Ww]arn)$",
  "^([Ww]arn) (.*)$",
  "^([Uu]nwarn)$",
  "^([Uu]nwarn) (.*)$",
  "^([Cc]lean) (warns)$",
  "^([Ww]arnlist)$",
  "^(اخطار)$",
  "^(اخطار) (.*)$",
  "^(حذف اخطار)$",
  "^(حذف اخطار) (.*)$",
  "^(پاک کردن) (اخطار ها)$",
  "^(لیست اخطار)$",

  },
  run = run,
  pre_process = pre_process
}

