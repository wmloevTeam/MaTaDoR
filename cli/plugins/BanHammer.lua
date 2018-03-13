local function pre_process(msg)
if msg.to.type ~= 'pv' then
chat = msg.to.id
user = msg.from.id
	local function check_newmember(arg, data)
		test = load_data(_config.moderation.data)
		lock_bots = test[arg.chat_id]['settings']['lock_bots']
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    if data.type_.ID == "UserTypeBot" then
      if not is_owner(arg.msg) and lock_bots == 'yes' then
kick_user(data.id_, arg.chat_id)
end
end
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_banned(data.id_, arg.chat_id) then
   if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Iѕ Ɓαηηє∂`", 0, "md")
   else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n `از گروه محروم است`", 0, "md")
end
kick_user(data.id_, arg.chat_id)
end
if is_gbanned(data.id_) then
     if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ Ɠℓσвαℓℓу Ɓαηηє∂`", 0, "md")
    else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n `از تمام گروه های ربات محروم است`", 0, "md")
   end
kick_user(data.id_, arg.chat_id)
     end
	end
	if msg.adduser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
	end
	if msg.joinuser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
	   end
   end
end
local function getChatId(chat_id)
  local chat = {}
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    local channel_id = chat_id:gsub('-100', '')
    chat = {ID = channel_id, type = 'channel'}
  else
    local group_id = chat_id:gsub('-', '')
    chat = {ID = group_id, type = 'group'}
  end
  return chat
end
local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
  local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
  if cmd == "ban" then
local function ban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т Ɓαη` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `من نمیتوانم خودم رو از گروه محروم کنم`", 0, "md")
         end
     end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Ƴσυ Ƈαη'т Ɓαη` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید مدیران،صاحبان گروه، و ادمین های ربات رو از گروه محروم کنید`", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ αℓяєα∂у` *Ɓαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n * از گروه محروم بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *Ɓαηηє∂*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه محروم شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
   if cmd == "unban" then
local function unban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ Ɲσт` *Ɓαηηє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه محروم نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
channel_unblock(arg.chat_id, data.id_)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *UnƁαηηє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از محرومیت گروه خارج شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "silent" then
local function silent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т ѕιℓєηт` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `من نمیتوانم توانایی چت کردن رو از خودم بگیرم`", 0, "md")
         end
     end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т ѕιℓєηт` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید`", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ αℓяєα∂у` *ѕιℓєηт*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از قبل توانایی چت کردن رو نداشت*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `α∂∂є∂ тσ` *Sιℓєηт Uѕєяѕ Lιѕт*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *توانایی چت کردن رو از دست داد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unsilent" then
local function unsilent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ Ɲσт` *ѕιℓєηт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از قبل توانایی چت کردن را داشت*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `яємσνє∂ ƒяσм` *Sιℓєηт Uѕєяѕ Lιѕт*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *توانایی چت کردن رو به دست آورد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "banall" then
local function gban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т Ɠℓσвαℓℓу Ɓαη` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `من نمیتوانم خودم رو از تمام گروه های ربات محروم کنم`", 0, "md")
         end
     end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Ƴσυ Ƈαη'т` *Ɠℓσвαℓℓу Ɓαη* `Oтнєя A∂мιηѕ`", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید ادمین های ربات رو از تمامی گروه های ربات محروم کنید`", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ αℓяєα∂у` *Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه های ربات محروم بود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از تمام گروه های ربات محروم شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unbanall" then
local function ungban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ Ɲσт` *Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه های ربات محروم نبود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *Ɠℓσвαℓℓу unƁαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از محرومیت گروه های ربات خارج شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "kick" then
     if data.sender_user_id_ == our_id then
  if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `I Ƈαη'т кιcк` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `من نمیتوانم خودم رو از گروه اخراج کنم کنم`", 0, "md")
         end
   elseif is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `Ƴσυ Ƈαη'т Ƙιcк` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو اخراج کنید`", 0, "md")
   end
  else
     kick_user(data.sender_user_id_, data.chat_id_)
    sleep(1)
channel_unblock(data.chat_id_, data.sender_user_id_)
     end
  end
  if cmd == "delall" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `Ƴσυ Ƈαη'т Ɗєℓєтє Mєѕѕαgєѕ` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `شما نمیتوانید پیام های مدیران،صاحبان گروه و ادمین های ربات رو پاک کنید`", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(data.chat_id_, data.sender_user_id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `Aℓℓ` *Mєѕѕαgєѕ* `Oƒ` `[ "..data.sender_user_id_.." ]` `Hαѕ Ɓєєη` *Ɗєℓєтє∂*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> *تمام پیام های* `[ "..data.sender_user_id_.." ]` *پاک شد*", 0, "md")
       end
    end
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
    local administration = load_data(_config.moderation.data)
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
  if cmd == "ban" then
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т вαη` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `من نمیتوانم خودم رو از گروه محروم کنم`", 0, "md")
         end
     end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Ƴσυ Ƈαη'т Ɓαη` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید مدیران،صاحبان گروه، و ادمین های ربات رو از گروه محروم کنید`", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ αℓяєα∂у` *Ɓαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n * از گروه محروم بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *Ɓαηηє∂*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه محروم شد*", 0, "md")
   end
end
   if cmd == "unban" then
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ Ɲσт` *Ɓαηηє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه محروم نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
channel_unblock(arg.chat_id, data.id_)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *UnƁαηηє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از محرومیت گروه خارج شد*", 0, "md")
   end
end
  if cmd == "silent" then
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т Sιℓєηт` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `من نمیتوانم توانایی چت کردن رو از خودم بگیرم`", 0, "md")
         end
     end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т ѕιℓєηт` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید`", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ αℓяєα∂у` *ѕιℓєηт*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از قبل توانایی چت کردن رو نداشت*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `α∂∂є∂ тσ` *Sιℓєηт Uѕєяѕ Lιѕт*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *توانایی چت کردن رو از دست داد*", 0, "md")
   end
end
  if cmd == "unsilent" then
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ Ɲσт` *ѕιℓєηт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از قبل توانایی چت کردن را داشت*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `яємσνє∂ ƒяσм` *Sιℓєηт Uѕєяѕ Lιѕт*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *توانایی چت کردن رو به دست آورد*", 0, "md")
   end
end
  if cmd == "banall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т Ɠℓσвαℓℓу Ɓαη` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `من نمیتوانم خودم رو از تمام گروه های ربات محروم کنم`", 0, "md")
         end
     end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Ƴσυ Ƈαη'т` *Ɠℓσвαℓℓу Ɓαη* `Oтнєя A∂мιηѕ`", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید ادمین های ربات رو از تمامی گروه های ربات محروم کنید`", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ αℓяєα∂у` *Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه های ربات محروم بود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از تمام گروه های ربات محروم شد*", 0, "md")
   end
end
  if cmd == "unbanall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `ιѕ Ɲσт` *Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از گروه های ربات محروم نبود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *Uѕєя :*\n["..user_name.."] `[ "..data.id_.." ]`\n `Hαѕ Ɓєєη` *Ɠℓσвαℓℓу unƁαηηє∂*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "> *کاربر :*\n["..user_name.."] `[ "..data.id_.." ]`\n *از محرومیت گروه های ربات خارج شد*", 0, "md")
   end
end
  if cmd == "kick" then
     if data.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `I Ƈαη'т кιcк` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `من نمیتوانم خودم رو از گروه اخراج کنم`", 0, "md")
         end
   elseif is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Ƴσυ Ƈαη'т Ƙιcк` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو اخراج کنید`", 0, "md")
   end
  else
     kick_user(data.id_, arg.chat_id)
  sleep(1)
channel_unblock(arg.chat_id, data.id_)
     end
  end
  if cmd == "delall" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Ƴσυ Ƈαη'т Ɗєℓєтє Mєѕѕαgєѕ` *Mσ∂ѕ,Oωηєяѕ Aη∂ Ɓσт A∂мιηѕ*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `شما نمیتوانید پیام های مدیران،صاحبان گروه و ادمین های ربات رو پاک کنید`", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(arg.chat_id, data.id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Aℓℓ` *Mєѕѕαgєѕ* `Oƒ` "..user_name.." *[ "..data.id_.." ]* `Hαѕ Ɓєєη` *Ɗєℓєтє∂*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> *تمام پیام های* "..user_name.." *[ "..data.id_.." ]* *پاک شد*", 0, "md")
       end
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
local function run(msg, matches)
local userid = tonumber(matches[2])
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
chat = msg.to.id
user = msg.from.id
   if msg.to.type ~= 'pv' then
 if (matches[1]:lower() == "kick" and is_mod(msg) ) or (matches[1] == "اخراج" and is_mod(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="kick"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if userid == our_id then
  if not lang then
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `I Ƈαη'т кιcк` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `من نمیتوانم خودم رو از گروه اخراج کنم`", 0, "md")
         end
   elseif is_mod1(msg.to.id, userid) then
   if not lang then
     tdcli.sendMessage(msg.to.id, "", 0, "> `Ƴσυ cαη'т кιcк мσ∂ѕ,σωηєяѕ σя вσт α∂мιηѕ`", 0, "md")
   elseif lang then
     tdcli.sendMessage(msg.to.id, "", 0, "> `شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو اخراج کنید`", 0, "md")
         end
     else
kick_user(matches[2], msg.to.id)
   sleep(1)
channel_unblock(msg.to.id, matches[2])
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="kick"})
         end
      end
 if (matches[1]:lower() == "delall" and is_mod(msg) ) or (matches[1] == "حذف پیام" and is_mod(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="delall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "> `Ƴσυ cαη'т ∂єℓєтє мєѕѕαgєѕ мσ∂ѕ,σωηєяѕ σя вσт α∂мιηѕ`", 0, "md")
     elseif lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "> `شما نمیتوانید پیام های مدیران،صاحبان گروه و ادمین های ربات رو پاک کنید`", 0, "md")
   end
     else
tdcli.deleteMessagesFromUser(msg.to.id, matches[2], dl_cb, nil)
    if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "> `Aℓℓ` *Mєѕѕαgєѕ* `Oƒ` *[ "..matches[2].." ]* `Hαѕ Ɓєєη` *Ɗєℓєтє∂*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "> *تمامی پیام های* *[ "..matches[2].." ]* *پاک شد*", 0, "md")
         end
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="delall"})
         end
      end
   end
 if (matches[1]:lower() == "gban" and is_admin(msg) ) or (matches[1] == "سوپر مسدود" and is_admin(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="banall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if userid == our_id then
  if not lang then
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `I Ƈαη'т Ɠℓσвαℓℓу Ɓαη` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `من نمیتوانم خودم رو از تمام گروه های ربات محروم کنم`", 0, "md")
         end
     end
   if is_admin1(userid) then
   if not lang then
    return tdcli.sendMessage(msg.to.id, "", 0, "> `Ƴσυ cαη'т gℓσвαℓℓу вαη σтнєя α∂мιηѕ`", 0, "md")
else
    return tdcli.sendMessage(msg.to.id, "", 0, "> `شما نمیتوانید ادمین های ربات رو از گروه های ربات محروم کنید`", 0, "md")
        end
     end
   if is_gbanned(matches[2]) then
   if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "> *Uѕєя "..matches[2].." Iѕ Aℓяєα∂у Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
    else
  return tdcli.sendMessage(msg.to.id, "", 0, "> *کاربر "..matches[2].." از گروه های ربات محروم بود*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *Uѕєя "..matches[2].." Hαѕ Ɓєєη Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
    else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *کاربر "..matches[2].." از تمام گروه هار ربات محروم شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="banall"})
      end
   end
 if (matches[1]:lower() == "ungban" and is_admin(msg) ) or (matches[1] == "رفع سوپر مسدود" and is_admin(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unbanall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_gbanned(matches[2]) then
     if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "> *Uѕєя "..matches[2].." Iѕ Ɲσт Ɠℓσвαℓℓу Ɓαηηє∂*", 0, "md")
    else
   return tdcli.sendMessage(msg.to.id, "", 0, "> *کاربر "..matches[2].." از گروه های ربات محروم نبود*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *Uѕєя "..matches[2].." Hαѕ Ɓєєη Ɠℓσвαℓℓу UnƁαηηє∂*", 0, "md")
   else
return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *کاربر "..matches[2].." از محرومیت گروه های ربات خارج شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unbanall"})
      end
   end
   if msg.to.type ~= 'pv' then
 if (matches[1]:lower() == "ban" and is_mod(msg) ) or (matches[1] == "مسدود" and is_mod(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="ban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if userid == our_id then
  if not lang then
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `I Ƈαη'т вαη` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `من نمیتوانم خودم رو از گروه محروم کنم`", 0, "md")
         end
     end
   if is_mod1(msg.to.id, userid) then
     if not lang then
    return tdcli.sendMessage(msg.to.id, "", 0, "> `Ƴσυ cαη'т вαη мσ∂ѕ,σωηєяѕ σя вσт α∂мιηѕ`", 0, "md")
    else
    return tdcli.sendMessage(msg.to.id, "", 0, "> `شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو از گروه محروم کنید`", 0, "md")
        end
     end
   if is_banned(matches[2], msg.to.id) then
   if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "> *Uѕєя "..matches[2].." Iѕ Aℓяєα∂у Ɓαηηє∂*", 0, "md")
  else
  return tdcli.sendMessage(msg.to.id, "", 0, "> *کاربر "..matches[2].." از گروه محروم بود*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *Uѕєя "..matches[2].." Hαѕ Ɓєєη Ɓαηηє∂*", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *کاربر "..matches[2].." از گروه محروم شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
     tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ban"})
      end
   end
 if (matches[1]:lower() == "unban" and is_mod(msg) ) or (matches[1] == "رفع مسدود" and is_mod(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_banned(matches[2], msg.to.id) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "> *Uѕєя "..matches[2].." Iѕ Ɲσт Ɓαηηє∂*", 0, "md")
  else
   return tdcli.sendMessage(msg.to.id, "", 0, "> *کاربر "..matches[2].." از گروه محروم نبود*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
channel_unblock(msg.to.id, matches[2])
   if not lang then
return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *Uѕєя "..matches[2].." Hαѕ Ɓєєη unƁαηηє∂*", 0, "md")
   else
return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *کاربر "..matches[2].." از محرومیت گروه خارج شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unban"})
      end
   end
 if (matches[1]:lower() == "muteuser" and is_mod(msg) ) or (matches[1] == "سکوت" and is_mod(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="silent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
    if userid == our_id then
  if not lang then
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `I Ƈαη'т Sιℓєηт` *Mу Sєℓƒ*", 0, "md")
   else
  return tdcli.sendMessage(msg.to.id, msg.id, 0, "> `من نمیتوانم توانایی چت کردن رو از خودم بگیرم`", 0, "md")
         end
     end
   if is_mod1(msg.to.id, userid) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "> `Ƴσυ cαη'т ѕιℓєηт мσ∂ѕ,ℓєα∂єяѕ σя вσт α∂мιηѕ`", 0, "md")
 else
   return tdcli.sendMessage(msg.to.id, "", 0, "> `شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه و ادمین های ربات بگیرید`", 0, "md")
        end
     end
   if is_silent_user(matches[2], chat) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "> *Uѕєя"..matches[2].." Iѕ Aℓяєα∂у Sιℓєηт*", 0, "md")
   else
   return tdcli.sendMessage(msg.to.id, "", 0, "> *کاربر "..matches[2].." از قبل توانایی چت کردن رو نداشت*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
    if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *Uѕєя"..matches[2].." A∂∂є∂ Ƭσ Sιℓєηт Uѕєяѕ Lιѕт*", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *کاربر "..matches[2].." توانایی چت کردن رو از دست داد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="silent"})
      end
   end
 if (matches[1]:lower() == "unmuteuser" and is_mod(msg) ) or (matches[1] == "رفع سکوت" and is_mod(msg) ) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unsilent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_silent_user(matches[2], chat) then
     if not lang then
     return tdcli.sendMessage(msg.to.id, "", 0, "> *Uѕєя"..matches[2].." Iѕ Ɲσт Sιℓєηт*", 0, "md")
   else
     return tdcli.sendMessage(msg.to.id, "", 0, "> *کاربر "..matches[2].." از قبل توانایی چت کردن رو داشت*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *Uѕєя"..matches[2].." Rємσνє∂ Ƒяσм Sιℓєηт Uѕєяѕ Lιѕт*", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "> *کاربر "..matches[2].." توانایی چت کردن رو به دست آورد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unsilent"})
      end
   end
		if (matches[1]:lower() == "clean" and is_owner(msg) ) or (matches[1] == "پاک کردن" and is_owner(msg) ) then
			if (matches[2] == 'bans' ) or (matches[2] == 'لیست مسدود' ) then
				if next(data[tostring(chat)]['banned']) == nil then
     if not lang then
					return "> `Ɲσ` *Ɓαηηє∂* `Uѕєяѕ ιη Ƭнιѕ Ɠяσυρ`"
   else
					return "> `هیچ کاربری از این گروه محروم نشده`"
              end
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
     if not lang then
				return "> `Aℓℓ` *Ɓαηηє∂* `Uѕєяѕ Hαѕ Ɓєєη UnƁαηηє∂`"
    else
				return "> `تمام کاربران محروم شده از گروه از محرومیت خارج شدند`"
           end
			end
			if (matches[2] == 'muteuserlist' ) or (matches[2] == 'لیست سکوت' ) then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
        if not lang then
					return "> `Ɲσ` *Sιℓєηт* `Uѕєяѕ ιη Ƭнιѕ Ɠяσυρ`"
   else
					return "> `لیست کاربران سایلنت شده خالی است`"
             end
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
       if not lang then
				return "> *Sιℓєηт ℓιѕт* `Hαѕ Ɓєєη cℓєαηє∂`"
   else
				return "> `لیست کاربران سایلنت شده پاک شد`"
               end
			    end
				if matches[2] == 'bot' or matches[2] == 'ربات'then
  function clbot(arg, data)
    for k, v in pairs(data.members_) do
      kick_user(v.user_id_, msg.to.id)
	end
	if not lang then
    tdcli.sendMessage(msg.to.id, msg.id, 1, '> *Aℓℓ Ɓσтѕ ωαѕ cℓєαяє∂.*', 1, 'md')
	else
	tdcli.sendMessage(msg.to.id, msg.id, 1, '> `تمام ربات های مخرب پاکسازی شد.`', 1, 'md')
	end
  end
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, clbot, nil)
  end
    if matches[2] == 'blacklist' or matches[2] == 'لیست سیاه' then
    local function cleanbl(ext, res)
      if tonumber(res.total_count_) == 0 then
	  if not lang then
        return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '> *ƁℓαcкLιѕт Ɠяσυρ ιѕ Ɛмρту*', 1, 'md')
		else
		return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '> `لیست مسدودی های گروه خالی است`', 1, 'md')
		end
      end
      local x = 0
      for x,y in pairs(res.members_) do
        x = x + 1
        tdcli.changeChatMemberStatus(ext.chat_id, y.user_id_, 'Left', dl_cb, nil)
      end
	  if not lang then
      return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '> *Uѕєяѕ σƒ тнє вℓαcк ℓιѕт gяσυρ ωαѕ*', 1, 'md')
	  else
	  return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '> `کاربر از لیست مسدودی های گروه آزاد شدند`', 1, 'md')
	  end
    end
	
    return tdcli.getChannelMembers(msg.to.id, 0, 'Kicked', 200, cleanbl, {chat_id = msg.to.id, msg_id = msg.id})
  end
  if (matches[2] == 'deleted' or matches[2] == 'اکانت پاک شده') and msg.to.type == "channel" then 
  function check_deleted(TM, MR) 
    for k, v in pairs(MR.members_) do 
local function clean_cb(TM, MR)
if not MR.first_name_ then
kick_user(MR.id_, msg.to.id) 
end
end
tdcli.getUser(v.user_id_, clean_cb, nil)
 end 
if not lang then
    tdcli.sendMessage(msg.to.id, msg.id, 1, '> *Aℓℓ Ɗєℓєтє∂ Accσυηт ωαѕ cℓєαяє∂*', 1, 'md')
else
    tdcli.sendMessage(msg.to.id, msg.id, 1, '> `تمام اکانتی های پاک شده پاکسازی شدند`', 1, 'md')	
end
  end 
  tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,offset_ = 0,limit_ = 200}, check_deleted, nil)
end
        end
     end
		if (matches[1]:lower() == "clean" and is_sudo(msg) ) or (matches[1] == "پاک کردن" and is_sudo(msg) ) then
			if (matches[2] == 'gbans' ) or (matches[2] == 'لیست سوپر مسدود' ) then
				if next(data['gban_users']) == nil then
    if not lang then
					return "> `Ɲσ` *Ɠℓσвαℓℓу Ɓαηηє∂* `Uѕєяѕ Aναιℓαвℓє`"
   else
					return "> `هیچ کاربری از گروه های ربات محروم نشده`"
             end
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
      if not lang then
				return "> `Aℓℓ` *Ɠℓσвαℓℓу Ɓαηηє∂* Uѕєяѕ Hαѕ Ɓєєη UnƁαηηє∂`"
   else
				return "> `تمام کاربرانی که از گروه های ربات محروم بودند از محرومیت خارج شدند`"
          end
			end
     end
 if (matches[1]:lower() == "gbanlist" and is_admin(msg) ) or (matches[1] == "لیست سوپر مسدود" and is_admin(msg) ) then
  return gbanned_list(msg)
 end
   if msg.to.type ~= 'pv' then
 if (matches[1]:lower() == "muteuserlist" and is_mod(msg) ) or (matches[1] == "لیست سکوت" and is_mod(msg) ) then
  return silent_users_list(chat)
 end
 if (matches[1]:lower() == "banlist" and is_mod(msg) ) or (matches[1] == "لیست مسدود" and is_mod(msg) ) then
  return banned_list(chat)
     end
  end
end
return {
	patterns = {
		"^[!/#]([Gg]ban)$",
		"^[!/#]([Gg]ban) (.*)$",
		"^[!/#]([Uu]ngban)$",
		"^[!/#]([Uu]ngban) (.*)$",
		"^[!/#]([Gg]banlist)$",
		"^[!/#]([Bb]an)$",
		"^[!/#]([Bb]an) (.*)$",
		"^[!/#]([Uu]nban)$",
		"^[!/#]([Uu]nban) (.*)$",
		"^[!/#]([Bb]anlist)$",
		"^[!/#]([Mm]uteuser)$",
		"^[!/#]([Mm]uteuser) (.*)$",
		"^[!/#]([Uu]nmuteuser)$",
		"^[!/#]([Uu]nmuteuser) (.*)$",
		"^[!/#]([Mm]uteuserlist)$",
		"^[!/#]([Kk]ick)$",
		"^[!/#]([Kk]ick) (.*)$",
		"^[!/#]([Dd]elall)$",
		"^[!/#]([Dd]elall) (.*)$",
		"^[!/#]([Cc]lean) (.*)$",
		"^([Gg]ban)$",
		"^([Gg]ban) (.*)$",
		"^([Uu]ngban)$",
		"^([Uu]ngban) (.*)$",
		"^([Gg]banlist)$",
		"^([Bb]an)$",
		"^([Bb]an) (.*)$",
		"^([Uu]nban)$",
		"^([Uu]nban) (.*)$",
		"^([Bb]anlist)$",
		"^([Mm]uteuser)$",
		"^([Mm]uteuser) (.*)$",
		"^([Uu]nmuteuser)$",
		"^([Uu]nmuteuser) (.*)$",
		"^([Mm]uteuserlist)$",
		"^([Kk]ick)$",
		"^([Kk]ick) (.*)$",
		"^([Dd]elall)$",
		"^([Dd]elall) (.*)$",
		"^([Cc]lean) (.*)$",
		"^(سوپر مسدود)$",
		"^(سوپر مسدود) (.*)$",
		"^(رفع سوپر مسدود)$",
		"^(رفع سوپر مسدود) (.*)$",
		"^(لیست سوپر مسدود)$",
		"^(مسدود)$",
		"^(مسدود) (.*)$",
		"^(رفع مسدود)$",
		"^(رفع مسدود) (.*)$",
		"^(لیست مسدود)$",
		"^(سکوت)$",
		"^(سکوت) (.*)$",
		"^(رفع سکوت)$",
		"^(رفع سکوت) (.*)$",
		"^(لیست سکوت)$",
		"^(اخراج)$",
		"^(اخراج) (.*)$",
		"^(حذف پیام)$",
		"^(حذف پیام) (.*)$",
		"^(پاک کردن) (.*)$",
	},
	run = run,
pre_process = pre_process
}
