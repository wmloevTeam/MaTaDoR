local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '*#》Ƴσυ αяє ησт вσт αɗмιη 🚷*\n*〰〰〰〰〰〰〰〰*\n💠 `Run this command only for Admins and deputies is`'
else
     return '#》 `شما` #مدیر `گروه نیستید` 🚷\n*〰〰〰〰〰〰〰〰*\n💠 اجرای این دستور فقط برای مدیران و معاونان است.'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '#》 *Ɠяσυρ ιѕ αƖяєαɗу αɗɗєɗ* ‼️\n*〰〰〰〰〰〰〰〰*\n💠 `The robot is already in the group, the robot was is no longer need to do not`'
else
return '#》 `ربات در` #لیست `گروه ربات از قبل بود` ‼️\n*〰〰〰〰〰〰〰〰*\n💠 ربات از قبل در لیست گروه های ربات بود است دیگر نیازی به این‌کار نیست.'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
			owners = {},
			mods ={},
			banned ={},
			is_silent_users ={},
			filterlist ={},
			whitelist ={},
			settings = {
				set_name = msg.to.title,
				lock_link = 'yes',
				lock_tag = 'no',
				lock_username = 'yes',
				lock_spam = 'yes',
				lock_webpage = 'yes',
				lock_mention = 'no',
				lock_markdown = 'no',
				lock_flood = 'yes',
				lock_bots = 'yes',
				lock_pin = 'no',
				welcome = 'no',
				lock_join = 'no',
				lock_edit = 'no',
				lock_arabic = 'no',
				lock_english = 'no',
				lock_all = 'no',
				num_msg_max = '50',
				set_char = '1000',
				time_check = '2',
				},
   mutes = {
                  mute_video_self = 'yes',
                  mute_forward = 'yes',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'warn',
                  mute_text = 'no',
                  mute_photo = 'no',
                  mute_gif = 'no',
                  mute_location = 'warn',
                  mute_document = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
				  mute_all = 'no',
				  mute_keyboard = 'warn',
				  mute_game = 'no',
				  mute_inline = 'warn',
				  mute_tgservice = 'no',
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '#》 *Ɠяσυρ нαѕ вєєη αɗɗєɗ* ✅🤖\n\n*Ɠяσυρ Ɲαмє :*'..msg.to.title..'\n*OяɗєяƁу :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]\n*〰〰〰〰〰〰〰〰*\n💠 `Group now to list the groups the robot was added`\n\n*Ɠяσυρ cнαяgєɗ 3 мιηυтєѕ  fσя ѕєттιηgѕ.*'
else
  return '#》 `گروه به` #لیست `گروه ربات اضافه شده` ✅🤖\n\n*اسم گروه :*'..msg.to.title..'\n*توسط :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]\n*〰〰〰〰〰〰〰〰*\n💠 گروه هم اکنون به لیست گروه ربات اضافه شد.\n\n_گروه به مدت_ *3* _دقیقه برای اجرای تنظیمات شارژ می‌باشد._'
end
end
----------------------------------------
local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '#》 *Ɠяσυρ ιѕ ησт αɗɗєɗ* 🚫\n*〰〰〰〰〰〰〰〰*\n💠 `Group from the first to the group list, the robot was not added`'
else
    return '#》 `گروه در` #لیست `گروه ربات  نیست` 🚫\n*〰〰〰〰〰〰〰〰*\n💠 گروه از اول به لیست گروه ربات اضافه نشده است .'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
       data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '#》 *Ɠяσυρ нαѕ вєєη яємσνєɗ* ❌🤖\n\n*Ɠяσυρ Ɲαмє :*'..msg.to.title..'\n*OяɗєяƁу :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]\n*〰〰〰〰〰〰〰〰*\n💠 `The group now from the list of groups, the robot was removed`'
 else
  return '#》 `گروه از` #لیست `گروه های ربات حدف شد` ❌🤖\n\n*اسم گروه :*'..msg.to.title..'\n*توسط :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]\n*〰〰〰〰〰〰〰〰*\n💠 گروه هم اکنون از لیست گروه ربات حذف شد.'
end
end
----------------------------------------
 local function config_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
  --print(serpent.block(data))
   for k,v in pairs(data.members_) do
   local function config_mods(arg, data)
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = v.user_id_
  }, config_mods, {chat_id=arg.chat_id,user_id=v.user_id_})
 
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
owner_id = v.user_id_
   local function config_owner(arg, data)
 -- print(serpent.block(data))
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = owner_id
  }, config_owner, {chat_id=arg.chat_id,user_id=owner_id})
   end
end
 if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*AƖƖ gяσυρ αɗмιηѕ нαѕ вєєη ρяσмσтєɗ αηɗ gяσυρ cяєαтσя ιѕ ησω gяσυρ σωηєя*👤😎", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "`تمام ادمین های گروه به مقام مدیر منتصب شدند و سازنده گروه به مقام مالک گروه منتصب شد`👤😎", 0, "md")
     end
 end
----------------------------------------
local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "*Ɯσяɗ* [`"..word.."`] *ιѕ αƖяєαɗу fιƖтєяєɗ*♻️⚠️"
            else
         return "*کلمه* [`"..word.."`] *از قبل فیلتر بود*♻️⚠️"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "*Ɯσяɗ* [`"..word.."`] *αɗɗєɗ тσ fιƖтєяєɗ ωσяɗѕ Ɩιѕт*✔️📝"
            else
         return "*کلمه* [`"..word.."`] *به لیست کلمات فیلتر شده اضافه شد*✔️📝"
    end
end
----------------------------------------
local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "*Ɯσяɗ* [`"..word.."`] *яємσνєɗ fяσм fιƖтєяєɗ ωσяɗѕ Ɩιѕт*❌📝"
       elseif lang then
         return "*کلمه* [`"..word.."`] *از لیست کلمات فیلتر شده حذف شد*❌📝"
     end
      else
       if not lang then
         return "*Ɯσяɗ* [`"..word.."`] *ιѕ ησт fιƖтєяєɗ*🚫👣"
       elseif lang then
         return "*کلمه* [`"..word.."`] *از قبل فیلتر نبود*🚫👣"
      end
   end
end
----------------------------------------
local function delmsg (MaTaDoR,MahDiRoO)
    msgs = MaTaDoR.msgs 
    for k,v in pairs(MahDiRoO.messages_) do
        msgs = msgs - 1
        tdcli.deleteMessages(v.chat_id_,{[0] = v.id_}, dl_cb, cmd)
        if msgs == 1 then
            tdcli.deleteMessages(MahDiRoO.messages_[0].chat_id_,{[0] = MahDiRoO.messages_[0].id_}, dl_cb, cmd)
            return false
        end
    end
    tdcli.getChatHistory(MahDiRoO.messages_[0].chat_id_, MahDiRoO.messages_[0].id_,0 , 100, delmsg, {msgs=msgs})
end
----------------------------------------
local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "#》 *Ɠяσυρ ιѕ ησт αɗɗєɗ* 🚫\n*〰〰〰〰〰〰〰〰*\n💠 `Group from the first to the group list, the robot was not added`"
 else
    return "#》 `گروه در` #لیست `گروه ربات  نیست` 🚫\n*〰〰〰〰〰〰〰〰*\n💠 گروه از اول به لیست گروه ربات اضافه نشده است ."
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "`Ɲσ` *MσɗєяαƬσя* `ιη Ƭнιѕ Ɠяσυρ`🚫⚠️"
else
   return "`در حال حاضر هیچ` #مدیری `برای گروه انتخاب نشده است`🚫⚠️"
  end
end
if not lang then
   message = '*⚜Lιѕт σf мσɗєяαтσяѕ :*\n'
else
   message = '*⚜لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end
----------------------------------------
local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "#》 *Ɠяσυρ ιѕ ησт αɗɗєɗ* 🚫\n*〰〰〰〰〰〰〰〰*\n💠 `Group from the first to the group list, the robot was not added`"
else
return "#》 `گروه در` #لیست `گروه ربات  نیست` 🚫\n*〰〰〰〰〰〰〰〰*\n💠 گروه از اول به لیست گروه ربات اضافه نشده است ."
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "`Ɲσ` *Oωηєя* `ιη Ƭнιѕ Ɠяσυρ`🚫⚠️"
else
    return "`در حال حاضر هیچ` #مالکی `برای گروه انتخاب نشده است`🚫⚠️"
  end
end
if not lang then
   message = '*⚜Lιѕт σf σωηєяѕ :*\n'
else
   message = '*⚜لیست مالکین گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end
----------------------------------------
local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "#》 *Ɠяσυρ ιѕ ησт αɗɗєɗ* 🚫\n*〰〰〰〰〰〰〰〰*\n💠 `Group from the first to the group list, the robot was not added`", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_#》 `گروه در` #لیست `گروه ربات  نیست` 🚫\n*〰〰〰〰〰〰〰〰*\n💠 گروه از اول به لیست گروه ربات اضافه نشده است ._", 0, "md")
     end
  end
if cmd == "setmanager" then
local function manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n_ιѕ Ɲσω Ƭнє_ *Ɠяσυρ Mαηαgєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n*ادمین گروه شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "remmanager" then
local function rem_manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσ Lσηgєя_ *Ɠяσυρ Mαηαgєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از ادمینی گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу ιη_ *Ɯнιтє Lιѕт*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη Aɗɗєɗ Ƭσ_ *Ɯнιтє Lιѕт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به لیست سفید اضافه شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσт ιη_ *Ɯнιтє Lιѕт*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη Rємσνєɗ Ƒяσм_ *Ɯнιтє Lιѕт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از لیست سفید حذف شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу α_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσω Ƭнє_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу α_ *Mσɗєяαтσя*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη_ *Mσɗєяαтσя*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσт α_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσ Lσηgєя α_ *Ɠяσυρ Oωηєя*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ ησт α_ *Mσɗєяαтσя*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη_ *Ɗємσтєɗ*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `کاربر یافت نشد`⚠️👣", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "> `Uѕєя Ɲσт Ƒσυηɗ`⚠️👣", 0, "md")
      end
   end
end
----------------------------------------
local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "#》 *Ɠяσυρ ιѕ ησт αɗɗєɗ* 🚫\n*〰〰〰〰〰〰〰〰*\n💠 `Group from the first to the group list, the robot was not added`", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_#》 `گروه در` #لیست `گروه ربات  نیست` 🚫\n*〰〰〰〰〰〰〰〰*\n💠 گروه از اول به لیست گروه ربات اضافه نشده است ._", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n_ιѕ Ɲσω Ƭнє_ *Ɠяσυρ Mαηαgєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n*ادمین گروه شد*", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσ Lσηgєя_ *Ɠяσυρ Mαηαgєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از ادمینی گروه برکنار شد*", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу ιη_ *Ɯнιтє Lιѕт*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη Aɗɗєɗ Ƭσ_ *Ɯнιтє Lιѕт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به لیست سفید اضافه شد*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσт ιη_ *Ɯнιтє Lιѕт*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη Rємσνєɗ Ƒяσм_ *Ɯнιтє Lιѕт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از لیست سفید حذف شد*", 0, "md")
   end
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу α_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσω Ƭнє_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу α_ *Mσɗєяαтσя*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη_ *Mσɗєяαтσя*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσт α_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσ Lσηgєя α_ *Ɠяσυρ Oωηєя*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ ησт α_ *Mσɗєяαтσя*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη_ *Ɗємσтєɗ*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "اطلاعات برای [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `کاربر یافت نشد`⚠️👣", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Uѕєя Ɲσт Ƒσυηɗ`⚠️👣", 0, "md")
      end
   end
end
----------------------------------------
local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "#》 *Ɠяσυρ ιѕ ησт αɗɗєɗ* 🚫\n*〰〰〰〰〰〰〰〰*\n💠 `Group from the first to the group list, the robot was not added`", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_#》 `گروه در` #لیست `گروه ربات  نیست` 🚫\n*〰〰〰〰〰〰〰〰*\n💠 گروه از اول به لیست گروه ربات اضافه نشده است ._", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n_ιѕ Ɲσω Ƭнє_ *Ɠяσυρ Mαηαgєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n*ادمین گروه شد*", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*✴️》Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]` _ιѕ Ɲσ Lσηgєя_ *Ɠяσυρ Mαηαgєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از ادمینی گروه برکنار شد*", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу ιη_ *Ɯнιтє Lιѕт*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη Aɗɗєɗ Ƭσ_ *Ɯнιтє Lιѕт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به لیست سفید اضافه شد*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσт ιη_ *Ɯнιтє Lιѕт*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη Rємσνєɗ Ƒяσм_ *Ɯнιтє Lιѕт*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از لیست سفید حذف شد*", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу α_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσω Ƭнє_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ AƖяєαɗу α_ *Mσɗєяαтσя*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη_ *Mσɗєяαтσя*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσт α_ *Ɠяσυρ Oωηєя*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ Ɲσ Lσηgєя α_ *Ɠяσυρ Oωηєя*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _ιѕ ησт α_ *Mσɗєяαтσя*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*Uѕєя :* ["..user_name.."]\n🆔》*IƊ :* `["..data.id_.."]`\n _нαѕ Ɓєєη_ *Ɗємσтєɗ*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "✴️》*کاربر :* ["..user_name.."]\n🆔》*ایدی :* `["..data.id_.."]`\n *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `Uѕєя Ɲσт Ƒσυηɗ`⚠️👣", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "> `کاربر یافت نشد`⚠️👣", 0, "md")
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
----------------------------------------
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
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "yes" then 
if not lang then
return "*>Ɛяяσя*\n`Iѕ AƖяєαɗу AƖƖ Uѕєя SιƖєηт` ♻️⚠️" 
elseif lang then
return "*>انجام نشد*\n`تمامی کاربران از قبل در حالت سکوت بودن` ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Ɗσηє*\n`AƖƖ Uѕєя SιƖєηт` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "*>انجام شد*\n`تمام کاربران در حالت سکوت قرار گرفتن` 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "no" then 
if not lang then
return "*>Ɛяяσя*\n`Iѕ Ɲσт AƖƖ Uѕєя SιƖєηт` ❌🔐" 
elseif lang then
return "*>انجام نشد*\n`تمام کاربران در حالت سکوت قرار نگرفتن` ❌🔐"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Ɗσηє*\n`AƖƖ Uѕєя UηѕιƖєηт` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "*>انجام شد*\n`تمام کاربران از حالت سکوت ازاد شدن` 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end 
end
end
---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == 'yes' then
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال لینک در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_link"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال لینک در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_link_ban = data[tostring(target)]["settings"]["lock_link"] 
if lock_link_ban == 'ban' then
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود لینک در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_link"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود لینک در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_link_kick = data[tostring(target)]["settings"]["lock_link"] 
if lock_link_kick == 'kick' then
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج لینک در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_link"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج لینک در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_link_warn = data[tostring(target)]["settings"]["lock_link"] 
if lock_link_warn == 'warn' then
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار لینک در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_link"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lιηк* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار لینک در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == 'no' then
if not lang then
return "*>Lιηк* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال لینک در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_link"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*>Lιηк* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال لینک در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == 'yes' then
if not lang then
 return "*Tag* `Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال تگ در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*Tag* `Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال تگ در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_tag_ban = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag_ban == 'ban' then
if not lang then
 return "*>Tag* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود تگ در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_tag"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Tag* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود تگ در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_tag_kick = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag_kick == 'kick' then
if not lang then
 return "*>Tag* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج تگ در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_+"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Tag* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج تگ در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_tag_warn = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag_warn == 'warn' then
if not lang then
 return "*>Tag* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار تگ در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_tag"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Tag* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار تگ در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == 'no' then
if not lang then
return "*Tag* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال تگ در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*Tag* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال تگ در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Username-------------------
local function lock_username(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_username = data[tostring(target)]["settings"]["lock_username"] 
if lock_username == 'yes' then
if not lang then
 return "*username* `Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال نام کاربری در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_username"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*username* `Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال نام کاربری در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_username_ban = data[tostring(target)]["settings"]["lock_username"] 
if lock_username_ban == 'ban' then
if not lang then
 return "*>username* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود نام کاربری در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_+"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>username* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود نام کاربری در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_username_kick = data[tostring(target)]["settings"]["lock_username"] 
if lock_username_kick == 'kick' then
if not lang then
 return "*>username* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج نام کاربری در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_username"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>username* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج نام کاربری در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_username_warn = data[tostring(target)]["settings"]["lock_username"] 
if lock_username_warn == 'warn' then
if not lang then
 return "*>username* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار نام کاربری در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_username"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>username* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار نام کاربری در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_tag = data[tostring(target)]["settings"]["lock_username"]
 if lock_username == 'no' then
if not lang then
return "*username* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال نام کاربری در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_username"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*username* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال نام کاربری در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == 'yes' then
if not lang then
 return "*>Mєηтιση* `Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال فراخوانی افراد هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = 'yes'
save_data(_config.moderation.data, data)
if not lang then 
 return "*>Mєηтιση* `Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else 
 return "ارسال فراخوانی افراد در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_mention_ban = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention_ban == 'ban' then
if not lang then
 return "*>Mєηтιση* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود فراخوانی افراد در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_mention"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Mєηтιση* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود فراخوانی افراد در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_mention_kick = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention_kick == 'kick' then
if not lang then
 return "*>Mєηтιση* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج فراخوانی افراد در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_mention"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Mєηтιση* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج فراخوانی افراد در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_mention_warn = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention_warn == 'warn' then
if not lang then
 return "*>Mєηтιση* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار فراخوانی افراد در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_mention"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Mєηтιση* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار فراخوانی افراد در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == 'no' then
if not lang then
return "*>Mєηтιση* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال فراخوانی افراد در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*>Mєηтιση* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال فراخوانی افراد در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == 'yes' then
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال کلمات عربی/فارسی در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال کلمات عربی/فارسی در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_arabic_ban = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic_ban == 'ban' then
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود کلمات عربی/فارسی در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود کلمات عربی/فارسی در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_arabic_kick = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic_kick == 'kick' then
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج کلمات عربی/فارسی در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج کلمات عربی/فارسی در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_arabic_warn = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic_warn == 'warn' then
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار کلمات عربی/فارسی در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار کلمات عربی/فارسی در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == 'no' then
if not lang then
return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال کلمات عربی/فارسی در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*>Aяαвιc/Ƥєяѕιαη* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال کلمات عربی/فارسی در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock english--------------
local function lock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_english = data[tostring(target)]["settings"]["lock_english"] 
if lock_english == 'yes' then
if not lang then
 return "*english* `Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال کلمات انگلیسی در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_english"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*english* `Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال کلمات انگلیسی در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_english_ban = data[tostring(target)]["settings"]["lock_english"] 
if lock_english_ban == 'ban' then
if not lang then
 return "*>english* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود کلمات انگلیسی در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_english"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>english* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود کلمات انگلیسی در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_english_kick = data[tostring(target)]["settings"]["lock_english"] 
if lock_english_kick == 'kick' then
if not lang then
 return "*>english* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج کلمات انگلیسی در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_english"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>english* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج کلمات انگلیسی در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_english_warn = data[tostring(target)]["settings"]["lock_english"] 
if lock_english_warn == 'warn' then
if not lang then
 return "*>english* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار کلمات انگلیسی در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_+"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>english* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار کلمات انگلیسی در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_english = data[tostring(target)]["settings"]["lock_english"]
 if lock_english == 'no' then
if not lang then
return "*english* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال کلمات انگلیسی در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_english"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*english* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال کلمات انگلیسی در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == 'yes' then
if not lang then
 return "*>Ɛɗιтιηg* `Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ویرایش پیام هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɛɗιтιηg* `Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ویرایش پیام در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_edit_ban = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit_ban == 'ban' then
if not lang then
 return "*>Ɛɗιтιηg* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود ویرایش پیام در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_edit"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɛɗιтιηg* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود ویرایش پیام در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_edit_kick = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit_kick == 'kick' then
if not lang then
 return "*>Ɛɗιтιηg* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج ویرایش پیام در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_edit"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɛɗιтιηg* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج ویرایش پیام در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_edit_warn = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit_warn == 'warn' then
if not lang then
 return "*>Ɛɗιтιηg* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار ویرایش پیام در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_edit"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɛɗιтιηg* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار ویرایش پیام در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == 'no' then
if not lang then
return "*>Ɛɗιтιηg* `Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ویرایش پیام در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*>Ɛɗιтιηg* `Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ویرایش پیام در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == 'yes' then
if not lang then
 return "*>Sραм* `Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال هرزنامه در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Sραм* `Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال هرزنامه در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == 'no' then
if not lang then
return "*>Sραм* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
 return "ارسال هرزنامه در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = 'no' 
save_data(_config.moderation.data, data)
if not lang then 
return "*>Sραм* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
 return "ارسال هرزنامه در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_flood = data[tostring(target)]["settings"]["lock_flood"] 
if lock_flood == 'yes' then
if not lang then
 return "*>ƑƖσσɗιηg* `Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال پیام مکرر در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_flood"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>ƑƖσσɗιηg* `Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال پیام مکرر در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_flood = data[tostring(target)]["settings"]["lock_flood"]
 if lock_flood == 'no' then
if not lang then
return "*>ƑƖσσɗιηg* `Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال پیام مکرر در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_flood"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*>ƑƖσσɗιηg* `Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال پیام مکرر در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == 'yes' then
if not lang then
 return "*>Ɓσтѕ* `Ƥяσтєcтιση Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "محافظت از گروه در برابر ربات ها هم اکنون فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɓσтѕ* `Ƥяσтєcтιση Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖✅\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "محافظت از گروه در برابر ربات ها فعال شد 🤖✅\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)


local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == 'no' then
if not lang then
return "*>Ɓσтѕ* `Ƥяσтєcтιση Iѕ Ɲσт ƐηαвƖєɗ` ❌🔐" 
elseif lang then
return "محافظت از گروه در برابر ربات ها غیر فعال است  ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*>Ɓσтѕ* `Ƥяσтєcтιση Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖❌\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "محافظت از گروه در برابر ربات ها غیر فعال شد 🤖❌\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == 'yes' then
if not lang then
 return "*>Lσcк Jσιη* `Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ورود به گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_join"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Jσιη* `Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ورود به گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)


local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == 'no' then
if not lang then
return "*>Lσcк Jσιη* `Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ورود به گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_join"] = 'no'
save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Jσιη* `Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ورود به گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == 'yes' then
if not lang then 
 return "*>Mαякɗσωη* `Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال پیام های دارای فونت در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Mαякɗσωη* `Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال پیام های دارای فونت در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_markdown_ban = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown_ban == 'ban' then
if not lang then
 return "*>Mαякɗσωη* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود پیام های دارای فونت در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_markdown"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Mαякɗσωη* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود پیام های دارای فونت در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_markdown_kick = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown_kick == 'kick' then
if not lang then
 return "*>Mαякɗσωη* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج پیام های دارای فونت در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_markdown"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Mαякɗσωη* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج پیام های دارای فونت در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_markdown_warn = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown_warn == 'warn' then
if not lang then
 return "*>Mαякɗσωη* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار پیام های دارای فونت در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_markdown"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Mαякɗσωη* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار پیام های دارای فونت در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)


local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == 'no' then
if not lang then
return "*>Mαякɗσωη* `Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ` ❌🔐"
elseif lang then
return "ارسال پیام های دارای فونت در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = 'no' save_data(_config.moderation.data, data) 
if not lang then
return "*>Mαякɗσωη* `Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
return "ارسال پیام های دارای فونت در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == 'yes' then
if not lang then
 return "*>Ɯєвραgє* `Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "ارسال صفحات وب در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɯєвραgє* `Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "ارسال صفحات وب در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_webpage_ban = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage_ban == 'ban' then
if not lang then
 return "*>Ɯєвραgє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود صفحات وب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_webpage"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɯєвραgє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود صفحات وب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_webpage_kick = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage_kick == 'kick' then
if not lang then
 return "*>Ɯєвραgє* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج صفحات وب در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_webpage"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɯєвραgє* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج صفحات وب در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_webpage_warn = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage_warn == 'warn' then
if not lang then
 return "*>Ɯєвραgє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار صفحات وب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["settings"]["lock_webpage"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ɯєвραgє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار صفحات وب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)


local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == 'no' then
if not lang then
return "*>Ɯєвραgє* `Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "ارسال صفحات وب در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = 'no'
save_data(_config.moderation.data, data) 
if not lang then
return "*>Ɯєвραgє* `Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "ارسال صفحات وب در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == 'yes' then
if not lang then
 return "*>Ƥιηηєɗ Mєѕѕαgє* `Iѕ AƖяєαɗу Lσcкєɗ` ♻️⚠️"
elseif lang then
 return "سنجاق کردن پیام در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = 'yes'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Ƥιηηєɗ Mєѕѕαgє* `Hαѕ Ɓєєη Lσcкєɗ` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "سنجاق کردن پیام در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)


local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == 'no' then
if not lang then
return "*>Ƥιηηєɗ Mєѕѕαgє* `Iѕ Ɲσт Lσcкєɗ` ❌🔐" 
elseif lang then
return "سنجاق کردن پیام در گروه ممنوع نمی‌باشد ❌🔐"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = 'no'
save_data(_config.moderation.data, data) 
if not lang then
return "*>Ƥιηηєɗ Mєѕѕαgє* `Hαѕ Ɓєєη UηƖσcкєɗ` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "سنجاق کردن پیام در گروه آزاد شد 🤖🔓\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
--------Mutes---------
---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == 'yes' then
if not lang then
 return "*>Lσcк Ɠιf* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن تصاویر متحرک فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_gif"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then 
 return "*>Lσcк Ɠιf* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن تصاویر متحرک فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_gif_ban = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif_ban == 'ban' then
if not lang then
 return "*>Lσcк Ɠιf* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود تصاویر متحرک در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_gif"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ɠιf* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود تصاویر متحرک در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_gif_kick = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif_kick == 'kick' then
if not lang then
 return "*>Lσcк Ɠιf* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج تصاویر متحرک در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_gif"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ɠιf* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج تصاویر متحرک در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_gif_warn = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif_warn == 'warn' then
if not lang then
 return "*>Lσcк Ɠιf* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار تصاویر متحرک در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_+"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ɠιf* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار تصاویر متحرک در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == 'no' then
if not lang then
return "*>Lσcк Ɠιf* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن تصاویر متحرک غیر فعال بود ❌🔐"
end
else 
data[tostring(target)]["mutes"]["mute_gif"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Ɠιf* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن تصاویر متحرک غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == 'yes' then
if not lang then
 return "*>Lσcк Ɠαмє* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن بازی های تحت وب فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_game"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ɠαмє* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن بازی های تحت وب فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_game_ban = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game_ban == 'ban' then
if not lang then
 return "*>Lσcк Ɠαмє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود بازی های تحت وب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_game"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ɠαмє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود بازی های تحت وب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_game_kick = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game_kick == 'kick' then
if not lang then
 return "*>Lσcк Ɠαмє* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج بازی های تحت وب در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_game"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ɠαмє* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج بازی های تحت وب در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_game_warn = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game_warn == 'warn' then
if not lang then
 return "*>Lσcк Ɠαмє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار بازی های تحت وب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_game"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ɠαмє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار بازی های تحت وب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == 'no' then
if not lang then
return "*>Lσcк Ɠαмє* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن بازی های تحت وب غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_game"] = 'no'
 save_data(_config.moderation.data, data)
if not lang then 
return "*>Lσcк Ɠαмє* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن بازی های تحت وب غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == 'yes' then
if not lang then
 return "*>Lσcк IηƖιηє* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "قفل اینلاین فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_inline"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк IηƖιηє* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "قفل اینلاین فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_inline_ban = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline_ban == 'ban' then
if not lang then
 return "*>Lσcк IηƖιηє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود کیبورد شیشه ای در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_inline"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк IηƖιηє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود کیبورد شیشه ای در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_inline_kick = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline_kick == 'kick' then
if not lang then
 return "*>Lσcк IηƖιηє* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج اینلاین در گروه فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_inline"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк IηƖιηє* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج اینلاین در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_inline_warn = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline_warn == 'warn' then
if not lang then
 return "*>Lσcк IηƖιηє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار اینلاین در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_inline"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк IηƖιηє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار اینلاین در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == 'no' then
if not lang then
return "*>Lσcк IηƖιηє* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا  اینلاین غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_inline"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк IηƖιηє* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return " قفل اینلاین غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == 'yes' then
if not lang then
 return "*>Lσcк Ƭєxт* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن متن فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_text"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƭєxт* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن متن فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_text_ban = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text_ban == 'ban' then
if not lang then
 return "*>Lσcк Ƭєxт* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود متن در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_text"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƭєxт* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود متن در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_text_kick = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text_kick == 'kick' then
if not lang then
 return "*>Lσcк Ƭєxт* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج متن در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_text"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƭєxт* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج متن در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_text_warn = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text_warn == 'warn' then
if not lang then
 return "*>Lσcк Ƭєxт* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار متن در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_text"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƭєxт* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار متن در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == 'no' then
if not lang then
return "*>Lσcк Ƭєxт* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐"
elseif lang then
return "بیصدا کردن متن غیر فعال است  ♻️⚠️" 
end
else 
data[tostring(target)]["mutes"]["mute_text"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Ƭєxт* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن متن غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == 'yes' then
if not lang then
 return "*>Lσcк Ƥнσтσ* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن عکس فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_photo"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƥнσтσ* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن عکس فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_photo_ban = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo_ban == 'ban' then
if not lang then
 return "*>Lσcк Ƥнσтσ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود عکس در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_photo"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƥнσтσ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود عکس در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_photo_kick = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo_kick == 'kick' then
if not lang then
 return "*>Lσcк Ƥнσтσ* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج عکس در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_photo"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƥнσтσ* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج عکس در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_photo_warn = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo_warn == 'warn' then
if not lang then
 return "*>Lσcк Ƥнσтσ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار عکس در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_photo"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƥнσтσ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار عکس در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == 'no' then
if not lang then
return "*>Lσcк Ƥнσтσ* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن عکس غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_photo"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Ƥнσтσ* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن عکس غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == 'yes' then
if not lang then
 return "*>Lσcк Ʋιɗєσ* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن فیلم فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_video"] = 'yes' 
save_data(_config.moderation.data, data)
if not lang then 
 return "*>Lσcк Ʋιɗєσ* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن فیلم فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Video-------------------
local function mute_video_self(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video_self = data[tostring(target)]["mutes"]["mute_video_self"] 
if mute_video_self == 'yes' then
if not lang then
 return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن فیلم سلف فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_video_self"] = 'yes' 
save_data(_config.moderation.data, data)
if not lang then 
 return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن فیلم سلف فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
local function unmute_video_self(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video_self = data[tostring(target)]["mutes"]["mute_video_self"]
 if mute_video_self == 'no' then
if not lang then
return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن فیلم سلف غیرفعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_video_self"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن فیلم سلف غیرفعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

----------------kick--------------------
local function kick_video_self(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video_kick = data[tostring(target)]["mutes"]["mute_video_self"] 
if mute_video_kick == 'kick' then
if not lang then
 return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج فیلم سلف در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_video_self"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج فیلم سلف در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_video_self(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video_warn = data[tostring(target)]["mutes"]["mute_video_self"] 
if mute_video_warn == 'warn' then
if not lang then
 return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار فیلم سلف در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_video_self"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋιɗєσ Ѕεlғ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار فیلم سلف در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video_ban = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video_ban == 'ban' then
if not lang then
 return "*>Lσcк Ʋιɗєσ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود فیلم در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_video"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋιɗєσ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود فیلم در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video_kick = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video_kick == 'kick' then
if not lang then
 return "*>Lσcк Ʋιɗєσ* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج فیلم در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_video"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋιɗєσ* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج فیلم در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video_warn = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video_warn == 'warn' then
if not lang then
 return "*>Lσcк Ʋιɗєσ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار فیلم در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_video"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋιɗєσ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار فیلم در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == 'no' then
if not lang then
return "*>Lσcк Ʋιɗєσ* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن فیلم غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_video"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Ʋιɗєσ* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن فیلم غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == 'yes' then
if not lang then
 return "*>Lσcк Aυɗισ* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن آهنگ فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_audio"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Aυɗισ* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else 
return "بیصدا کردن آهنگ فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_audio_ban = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio_ban == 'ban' then
if not lang then
 return "*>Lσcк Aυɗισ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود آهنگ در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_audio"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Aυɗισ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود آهنگ در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_audio_kick = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio_kick == 'kick' then
if not lang then
 return "*>Lσcк Aυɗισ* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج + در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_audio"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Aυɗισ* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج آهنگ در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_audio_warn = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio_warn == 'warn' then
if not lang then
 return "*>Lσcк Aυɗισ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار آهنگ در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_audio"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Aυɗισ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار آهنگ در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == 'no' then
if not lang then
return "*>Lσcк Aυɗισ* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن آهنک غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_audio"] = 'no'
 save_data(_config.moderation.data, data)
if not lang then 
return "*>Lσcк Aυɗισ* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
return "بیصدا کردن آهنگ غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == 'yes' then
if not lang then
 return "*>Lσcк Ʋσιcє* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن صدا فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_voice"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋσιcє* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن صدا فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_voice_ban = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice_ban == 'ban' then
if not lang then
 return "*>Lσcк Ʋσιcє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود صدا در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_voice"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋσιcє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود صدا در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_voice_kick = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice_kick == 'kick' then
if not lang then
 return "*>+* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج صدا در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_voice"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋσιcє* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج صدا در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_voice_warn = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice_warn == 'warn' then
if not lang then
 return "*>Lσcк Ʋσιcє* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار صدا در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_voice"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ʋσιcє* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار صدا در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == 'no' then
if not lang then
return "*>Lσcк Ʋσιcє* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن صدا غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_voice"] = 'no'
 save_data(_config.moderation.data, data)
if not lang then 
return "*>Lσcк Ʋσιcє* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن صدا غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == 'yes' then
if not lang then
 return "*>Lσcк Sтιcкєя* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن برچسب فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_sticker"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Sтιcкєя* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن برچسب فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_sticker_ban = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker_ban == 'ban' then
if not lang then
 return "*>Lσcк Sticker* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود برچسب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_sticker"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Sticker* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود برچسب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_sticker_kick = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker_kick == 'kick' then
if not lang then
 return "*>Lσcк Sticker* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج برچسب در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_sticker"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Sticker* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج برچسب در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_sticker_warn = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker_warn == 'warn' then
if not lang then
 return "*>Lσcк Sticker* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار برچسب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_sticker"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Sticker* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار برچسب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == 'no' then
if not lang then
return "*>Lσcк Sтιcкєя* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن برچسب غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_sticker"] = 'no'
 save_data(_config.moderation.data, data)
if not lang then 
return "*>Lσcк Sticker* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
return "بیصدا کردن برچسب غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == 'yes' then
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن مخاطب فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_contact"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن مخاطب فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_contact_ban = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact_ban == 'ban' then
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود مخاطب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_contact"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود مخاطب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_contact_kick = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact_kick == 'kick' then
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج مخاطب در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_contact"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج مخاطب در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_contact_warn = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact_warn == 'warn' then
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار مخاطب در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_contact"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƈσηтαcт* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار مخاطب در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == 'no' then
if not lang then
return "*>Lσcк Ƈσηтαcт* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن مخاطب غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_contact"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Ƈσηтαcт* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن مخاطب غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == 'yes' then
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن نقل قول فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_forward"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن نقل قول فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_forward_ban = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward_ban == 'ban' then
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود نقل قول در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_forward"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود نقل قول در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_forward_kick = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward_kick == 'kick' then
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج نقل قول در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_forward"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج نقل قول در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_forward_warn = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward_warn == 'warn' then
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار نقل قول در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_forward"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƒσяωαяɗ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار نقل قول در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == 'no' then
if not lang then
return "*>Lσcк Ƒσяωαяɗ* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐"
elseif lang then
return "بیصدا کردن نقل قول غیر فعال است  ♻️⚠️"
end 
else 
data[tostring(target)]["mutes"]["mute_forward"] = 'no'
 save_data(_config.moderation.data, data)
if not lang then 
return "*>Lσcк Ƒσяωαяɗ* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن نقل قول غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == 'yes' then
if not lang then
 return "*>Lσcк Lσcαтιση* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن موقعیت فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_location"] = 'yes' 
save_data(_config.moderation.data, data)
if not lang then
 return "*>Lσcк Lσcαтιση* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن موقعیت فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_location_ban = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location_ban == 'ban' then
if not lang then
 return "*>Lσcк Lσcαтιση* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود موقعیت در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_location"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Lσcαтιση* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود موقعیت در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_location_kick = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location_kick == 'kick' then
if not lang then
 return "*>Lσcк Lσcαтιση* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج موقعیت در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_location"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Lσcαтιση* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج موقعیت در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_location_warn = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location_warn == 'warn' then
if not lang then
 return "*>Lσcк Lσcαтιση* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار موقعیت در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_location"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Lσcαтιση* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار موقعیت در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == 'no' then
if not lang then
return "*>Lσcк Lσcαтιση* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن موقعیت غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_location"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Lσcαтιση* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن موقعیت غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == 'yes' then
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن اسناد فعال لست"
end
else
 data[tostring(target)]["mutes"]["mute_document"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "بیصدا کردن اسناد فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_document_ban = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document_ban == 'ban' then
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود اسناد در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_document"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود اسناد در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_document_kick = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document_kick == 'kick' then
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج اسناد در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_document"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج اسناد در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_document_warn = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document_warn == 'warn' then
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار اسناد در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_document"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار اسناد در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == 'no' then
if not lang then
return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐" 
elseif lang then
return "بیصدا کردن اسناد غیر فعال است  ♻️⚠️"
end
else 
data[tostring(target)]["mutes"]["mute_document"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Dᴏᴄᴜᴍᴇɴᴛ* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "بیصدا کردن اسناد غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == 'yes' then
if not lang then
 return "*>Lσcк ƬgSєяνιcє* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن خدمات تلگرام فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_tgservice"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк ƬgSєяνιcє* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
return "بیصدا کردن خدمات تلگرام فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == 'no' then
if not lang then
return "*>Lσcк ƬgSєяνιcє* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐"
elseif lang then
return "بیصدا کردن خدمات تلگرام غیر فعال است  ♻️⚠️"
end 
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк ƬgSєяνιcє* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
return "بیصدا کردن خدمات تلگرام غیر فعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == 'yes' then
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
elseif lang then
 return "بیصدا کردن صفحه کلید فعال است  ♻️⚠️"
end
else
 data[tostring(target)]["mutes"]["mute_keyboard"] = 'yes' 
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
return "بیصدا کردن صفحه کلید فعال شد 🤖🔇\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------ban--------------------
local function ban_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_keyboard_ban = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard_ban == 'ban' then
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɓαηιηg` ♻️⚠️"
elseif lang then
 return "مسدود صفحه کلید در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_keyboard"] = 'ban'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɓαηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "مسدود صفحه کلید در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------kick--------------------
local function kick_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_keyboard_kick = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard_kick == 'kick' then
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Ƥσѕтιηg Iѕ AƖяєαɗу кιcкιηg` ♻️⚠️"
elseif lang then
 return "اخراج صفحه کلید در گروه هم اکنون ممنوع است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_keyboard"] = 'kick'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Ƥσѕтιηg Hαѕ Ɓєєη кιcкιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخراج صفحه کلید در گروه ممنوع شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------warn--------------------
local function warn_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_keyboard_warn = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard_warn == 'warn' then
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Ƥσѕтιηg Iѕ AƖяєαɗу Ɯαяηιηg` ♻️⚠️"
elseif lang then
 return "اخطار صفحه کلید در گروه هم اکنون فعال است ♻️⚠️"
end
else
data[tostring(target)]["mutes"]["mute_keyboard"] = 'warn'
save_data(_config.moderation.data, data) 
if not lang then
 return "*>Lσcк Ƙєувσαяɗ* `Ƥσѕтιηg Hαѕ Ɓєєη Ɯαяηιηg` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
 return "اخطار صفحه کلید در گروه فعال شد 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
end
----------------------------------------
local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == 'no' then
if not lang then
return "*>Lσcк Ƙєувσαяɗ* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐"
elseif lang then
return "بیصدا کردن صفحه کلید غیرفعال است  ♻️⚠️"
end 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = 'no'
 save_data(_config.moderation.data, data) 
if not lang then
return "*>Lσcк Ƙєувσαяɗ* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
else
return "بیصدا کردن صفحه کلید غیرفعال شد 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end 
end
end
----------------------------------------
function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"
else
  return "شما مدیر گروه نمیباشید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 1000
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = 'yes'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_username"] then			
data[tostring(target)]["settings"]["lock_username"] = 'yes'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_english"] then			
data[tostring(target)]["settings"]["lock_english"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = 'yes'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = 'yes'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = 'no'		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = 'no'		
 end
 end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_all"] then			
 data[tostring(target)]["settings"]["lock_all"] = 'no'		
 end
 end
if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = 'no'		
 end
 end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_all"] then			
data[tostring(target)]["mutes"]["mute_all"] = 'no'		
end
local hash = "muteall:"..msg.to.id
if redis:get(hash) then
data[tostring(target)]["mutes"]["mute_all"] = 'yes'
end	
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video_self"] then			
data[tostring(target)]["mutes"]["mute_video_self"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = 'no'		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = 'no'		
end
end

local hash = "muteall:"..msg.to.id
local check_time = redis:ttl(hash)
day = math.floor(check_time / 86400)
MRay = check_time % 86400
hours = math.floor( MRay / 3600)
bhours = MRay % 3600
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if not lang then
if not redis:get(hash) or check_time == -1 then
 mute_all1 = 'n time'
elseif tonumber(check_time) > 1 and check_time < 60 then
 mute_all1 = '_enable for_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 mute_all1 = '_enable for_ '..min..' _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 mute_all1 = '_enable for_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 86400 then
 mute_all1 = '_enable for_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
 end
elseif lang then
if not redis:get(hash) or check_time == -1 then
 mute_all2 = 'n time'
elseif tonumber(check_time) > 1 and check_time < 60 then
 mute_all2 = '_فعال برای_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 mute_all2 = '_فعال برای_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 mute_all2 = '_فعال برای_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 86400 then
 mute_all2 = '_فعال برای_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
 end
end

 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
local cmdss = redis:hget('group:'..msg.to.id..':cmd', 'bot')
	local cmdsss = ''
	if lang then
	if cmdss == 'owner' then
	cmdsss = cmdsss..'اونر و بالاتر'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'مدیر و بالاتر'
	else
	cmdsss = cmdsss..'کاربر و بالاتر'
	end
	else
	if cmdss == 'owner' then
	cmdsss = cmdsss..'Owner or higher'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'Moderator or higher'
	else
	cmdsss = cmdsss..'Member or higher'
	end
	end
local t1 = redis:get("atolct1"..msg.chat_id_)
local t2 = redis:get("atolct2"..msg.chat_id_)
if t1 and t2 then
stats1 = ''..t1..' && '..t2..''
else
if lang then
	stats1 = '`تنظیم نشده`'
else
	stats1 = '`No Set`'
end
end
if not lang then
local settings = data[tostring(target)]["settings"]
local mutes = data[tostring(target)]["mutes"]
text ="*MαƬαƊσR SєƬƬιηgѕ :*\n\n🔐 `ƓяσUρ` #Lσcк `Ƥяσ Lιѕт :`\n\n*>Lιηк :* "..settings.lock_link.."\n*>Ɛɗιт :* "..settings.lock_edit.."\n*>Uѕєяηαмє :* "..settings.lock_username.."\n*>Ƭαg :* "..settings.lock_tag.."\n*>Mєηтιση :* "..settings.lock_mention.."\n*>Ɯєвραgє :* "..settings.lock_webpage.."\n*>Aяαвιc :* "..settings.lock_arabic.."\n*>ƐηgƖιѕн :* "..settings.lock_english.."\n*>Mαякɗσωη :* "..settings.lock_markdown.."\n*>Ɠιf :* "..mutes.mute_gif.."\n*>Ƭєxт :* "..mutes.mute_text.."\n*>IηƖιηє :* "..mutes.mute_inline.."\n*>Ɠαмє :* "..mutes.mute_game.."\n*>Ƥнσтσ :* "..mutes.mute_photo.."\n*>Ʋιɗєσ :* "..mutes.mute_video.."\n*>Ѕεlғ Ʋιdεσ :* "..mutes.mute_video_self.."\n*>Aυɗισ :* "..mutes.mute_audio.."\n*>Ʋσιcє :* "..mutes.mute_voice.."\n*>Sтιcкєя :* "..mutes.mute_sticker.."\n*>Ƈσηтαcт :* "..mutes.mute_contact.."\n*>Ƒσяωαяɗ :* "..mutes.mute_forward.."\n*>Lσcαтιση :* "..mutes.mute_location.."\n*>Ɗσcυмєηт :* "..mutes.mute_document.."\n*>ƘєуƁσαяɗ :* "..mutes.mute_keyboard.."\n=============\n🔐 `ƓяσUρ` #Lσcк `Lιѕт :`\n\n*>SιƖєηт Ɠρ :* "..mutes.mute_all.."\n*>Lσcк Ƭιмє :* "..mute_all1.."\n*>Lσcк ƬƓѕєяνιcє :* "..mutes.mute_tgservice.."\n*>Lσcк Jσιη :* "..settings.lock_join.."\n*>Lσcк Spam :* "..settings.lock_spam.."\n*>Lσcк ƑƖσσɗ :* "..settings.lock_flood.."\n*>Ƥιη Mєѕѕαgє :* "..settings.lock_pin.."\n=============\n💠 `ƓяσUρ` #OƬнƐя `SєттιηƓѕ :`\n\n*>Ɠяσυρ ƜєƖcσмє :* "..settings.welcome.."\n*>Ɓσтѕ Ƥяσтєcтιση :* "..settings.lock_bots.."\n*>ƑƖσσɗ Sєηѕιтινιту :* `"..NUM_MSG_MAX.."`\n*>ƑƖσσɗ Ƈнєcк Ƭιмє :* `"..TIME_CHECK.."`\n*>Ƈнαяαcтєя Sєηѕιтινιту :* `"..SETCHAR.."`\n*>Ɓσтѕ Ƈσммαηɗѕ :* "..cmdsss.."\n*>Ɛxριяє Ɗαтє :* `"..expire_date.."`\n*>Auto lock :* "..stats1.."\n\n=============\n🌐 `IηfσRмαƬιση :`\n\n*>Ɠяσυρ Ɲαмє :* "..(check_markdown(msg.to.title) or "").."\n*>Ɠяσυρ IƊ :* `"..msg.to.id.."`\n*>Ƴσυя Ɲαмє :* "..(check_markdown(msg.from.first_name) or "No ɳαɱҽ").."\n*>Ƴσυя IƊ :* `"..msg.from.id.."`\n*>Uѕєяηαмє :* @"..check_markdown(msg.from.username or "").."\n\n=============\n*>ƇнαηηєƖ :* "..check_markdown(MaTaDoRch).."\n*>Ƥσωєяєɗ Ɓу :* "..check_markdown(MaTaDoRby).."\n*>Ɠяσυρ Lαηgυαgє :* `Eɴ`"
else
local settings = data[tostring(target)]["settings"]
local mutes = data[tostring(target)]["mutes"] 
text ="*تنظیمات ماتادور :*\n\n🔐 `لیست` #قفل `پیشرفته گروه :`\n\n*>لینک :* "..settings.lock_link.."\n*>ویرایش :* "..settings.lock_edit.."\n*>یوزرنیم :* "..settings.lock_username.."\n*>هشتگ :* "..settings.lock_tag.."\n*>فراخوانی :* "..settings.lock_mention.."\n*>صفحات وب :* "..settings.lock_webpage.."\n*>عربی :* "..settings.lock_arabic.."\n*>انگلیسی :* "..settings.lock_english.."\n*>فونت :* "..settings.lock_markdown.."\n*>گیف :* "..mutes.mute_gif.."\n*>متن :* "..mutes.mute_text.."\n*>اینلاین :* "..mutes.mute_inline.."\n*>بازی :* "..mutes.mute_game.."\n*>عکس :* "..mutes.mute_photo.."\n*>فیلم :* "..mutes.mute_video.."\n*>فیلم سلفی :* "..mutes.mute_video_self.."\n*>آهنگ :* "..mutes.mute_audio.."\n*>ویس :* "..mutes.mute_voice.."\n*>استیکر :* "..mutes.mute_sticker.."\n*>مخاطب :* "..mutes.mute_contact.."\n*>نقل قول :* "..mutes.mute_forward.."\n*>مکان :* "..mutes.mute_location.."\n*>فایل :* "..mutes.mute_document.."\n*>دکمه شیشه ای :* "..mutes.mute_keyboard.."\n=============\n🔐 `لیست` #قفل ها `گروه :`\n\n*>گروه سکوت :* "..mutes.mute_all.."\n*>قفل زمان بیصدا :* "..mute_all2.."\n*>قفل خدمات تلگرام :* "..mutes.mute_tgservice.."\n*>قفل ورود :* "..settings.lock_join.."\n*>قفل هرزنامه :* "..settings.lock_spam.."\n*>قفل رگباری :* "..settings.lock_flood.."\n*>سنجاق پیام :* "..settings.lock_pin.."\n=============\n💠 `لیست` #دیگر `تنظیمات گروه :`\n\n*>خوش آمدگویی :* "..settings.welcome.."\n*>محافظت در برابر ربات :* "..settings.lock_bots.."\n*>حداکثر پیام رگباری :* `"..NUM_MSG_MAX.."`\n*>زمان بررسی رگباری :* `"..TIME_CHECK.."`\n*>حداکثر کاراکتر مجاز :* `"..SETCHAR.."`\n*>دستورات ربات :* "..cmdsss.."\n*>تاریخ انقضا :* `"..expire_date.."`\n*>قفل خودکار :* "..stats1.."\n\n=============\n🌐 `اطلاعات :`\n\n*>نام گروه :* "..(check_markdown(msg.to.title) or "").."\n*>آیدی گروه :* `"..msg.to.id.."`\n*>نام شما :* "..(check_markdown(msg.from.first_name) or "No ɳαɱҽ").."\n*>آیدی شما :* `"..msg.from.id.."`\n*>یوزرنیم شما :* @"..check_markdown(msg.from.username or "").."\n\n=============\n*>کانال :* "..check_markdown(MaTaDoRch).."\n*>برنامه نویس :* "..check_markdown(MaTaDoRby).."\n*>زبان گروه :* `فارسی`"
end
if not lang then
text = string.gsub(text, "yes", "`Enable ✅`")
text = string.gsub(text, "no", "`Disable ❌`")
text = string.gsub(text, 'warn', "`Warn ⚠️`")
text = string.gsub(text, 'kick', "`Kick 👣`")
 else
text = string.gsub(text, "yes", "#فعال ✅")
text = string.gsub(text, "no", "#غیرفعال ❌")
text = string.gsub(text, 'warn', "#اخطار ⚠️")
text = string.gsub(text, 'kick', "#اخراج 👣")
 end
return text
end
----------------------------------------
local function run(msg, matches)
if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end
local cmd = redis:hget('group:'..msg.to.id..':cmd', 'bot')
local mutealll = redis:get('group:'..msg.to.id..':muteall')
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
local uhash = 'user:'..msg.from.id
local user = redis:hgetall(uhash)
if cmd == 'moderator' and not is_mod(msg) or cmd == 'owner' and not is_owner(msg) or mutealll and not is_mod(msg) then
else
if msg.to.type ~= 'pv' then
if (matches[1]:lower() == "id" ) or (matches[1] == 'ایدی' ) then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
 if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,"Ɠяσυρ ηαмє : "..(check_markdown(msg.to.title)).."\nƓяσυρ IƊ : "..msg.to.id.."\nƝαмє : "..(msg.from.first_name or "----").."\nUѕєяƝαмє : @"..(msg.from.username or "----").."\nUѕєя IƊ : "..msg.from.id.."",dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,"نام گروه : "..(check_markdown(msg.to.title)).."\nشناسه گروه : "..msg.to.id.."\nنام شما : "..(msg.from.first_name or "----").."\nنام کاربری : @"..(msg.from.username or "----").."\nشناسه شما : "..msg.from.id.."",dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_شما هیچ عکسی ندارید...!_\n\n> _شناسه گروه :_ `"..msg.to.id.."`\n_شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
end
	   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)	
end
if msg.reply_id and not matches[2] then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if ((matches[1]:lower() == "pin" ) or (matches[1] == 'سنجاق' )) and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سنجاق شد"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سنجاق شد"
end
end
end
if ((matches[1]:lower() == 'unpin' ) or (matches[1] == 'حذف سنجاق' )) and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
end
end
if ((matches[1]:lower() == "add" ) or (matches[1] == 'نصب' )) and is_sudo(msg) then
redis:set('ExpireDate:'..msg.to.id,true)
redis:setex('ExpireDate:'..msg.to.id, 180, true)
if not redis:get('CheckExpire::'..msg.to.id) then
redis:set('CheckExpire::'..msg.to.id,true)
end
return modadd(msg)
end
if ((matches[1]:lower() == "rem" ) or (matches[1] == 'لغو نصب' ))and is_admin(msg) then
			if redis:get('CheckExpire::'..msg.to.id) then
				redis:del('CheckExpire::'..msg.to.id)
			end
			redis:del('ExpireDate:'..msg.to.id)
return modrem(msg)
end
if ((matches[1]:lower() == "setmanager" ) or (matches[1] == 'ادمین گروه' )) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setmanager"})
      end
   end
if ((matches[1]:lower() == "remmanager" ) or (matches[1] == 'حذف ادمین گروه' )) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remmanager"})
      end
   end
if ((matches[1]:lower() == "whitelist" ) or (matches[1] == 'لیست سفید' )) and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if ((matches[1]:lower() == "whitelist" ) or (matches[1] == 'لیست سفید' )) and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if ((matches[1]:lower() == "setowner" ) or (matches[1] == 'مالک' )) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if ((matches[1]:lower() == "remowner" ) or (matches[1] == 'حذف مالک' )) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if ((matches[1]:lower() == "promote") or (matches[1] == 'مدیر')) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if ((matches[1]:lower() == "demote" ) or (matches[1] == 'حذف مدیر' )) and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end
local target = msg.to.id
if ((matches[1]:lower() == "link" ) or (matches[1] == "لینک" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_link(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_link(msg, data, target)
end
end
--------------------------------------
if ((matches[1]:lower() == "tag" ) or (matches[1] == "تگ" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_tag(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_tag(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "username" ) or (matches[1] == "نام کاربری" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_username(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_username(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "mention" ) or (matches[1] == "فراخوانی" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_mention(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_mention(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "arabic" ) or (matches[1] == "عربی" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_arabic(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_arabic(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "english" ) or (matches[1] == "انگلیسی" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_english(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_english(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "edit" ) or (matches[1] == "ویرایش" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_edit(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_edit(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "join" ) or (matches[1] == "ورود" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_join(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_join(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "markdown" ) or (matches[1] == "فونت" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_markdown(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_markdown(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "webpage" ) or (matches[1] == "وب" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_webpage(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_webpage(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "gif" ) or (matches[1] == "گیف" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_gif(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_gif(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "text" ) or (matches[1] == "متن" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_text(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_text(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "photo" ) or (matches[1] == "عکس" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_photo(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_photo(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "video" ) or (matches[1] == "فیلم" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_video(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_video(msg, data, target)
end
end

----------------------------------------
if ((matches[1]:lower() == "self" ) or (matches[1] == "سلف" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_video_self(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_video_self(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "audio" ) or (matches[1] == "اهنگ" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_audio(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_audio(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "voice" ) or (matches[1] == "ویس" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_voice(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_voice(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "sticker" ) or (matches[1] == "استیکر" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_sticker(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_sticker(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "contact" ) or (matches[1] == "مخاطب" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_contact(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_contact(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "forward" ) or (matches[1] == "فوروارد" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_forward(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_forward(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "location" ) or (matches[1] == "مکان" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_location(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_location(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "document" ) or (matches[1] == "فایل" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_document(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_document(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "inline" ) or (matches[1] == "اینلاین" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_inline(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_inline(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "game" ) or (matches[1] == "بازی" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_game(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_game(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "keyboard" ) or (matches[1] == "صفحه کلید" )) and is_mod(msg) then
if ((matches[2] == "warn" ) or (matches[2] == "اخطار" )) then
return warn_keyboard(msg, data, target)
end
if ((matches[2] == "kick" ) or (matches[2] == "اخراج" )) then
return kick_keyboard(msg, data, target)
end
end
----------------------------------------
if ((matches[1]:lower() == "lock" ) or (matches[1] == "قفل" )) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "self" ) or (matches[2] == "سلف" )) then
return mute_video_self(msg, data, target)
end
if ((matches[2] == "gif" ) or (matches[2] == "گیف" )) then
return mute_gif(msg, data, target)
end
if ((matches[2] == "text" ) or (matches[2] == "متن" )) then
return mute_text(msg ,data, target)
end
if ((matches[2] == "photo" ) or (matches[2] == "عکس" )) then
return mute_photo(msg ,data, target)
end
if ((matches[2] == "video" ) or (matches[2] == "فیلم" )) then
return mute_video(msg ,data, target)
end
if ((matches[2] == "audio" ) or (matches[2] == "اهنگ" )) then
return mute_audio(msg ,data, target)
end
if ((matches[2] == "voice" ) or (matches[2] == "ویس" )) then
return mute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" ) or (matches[2] == "استیکر" )) then
return mute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" ) or (matches[2] == "مخاطب" )) then
return mute_contact(msg ,data, target)
end
if ((matches[2] == "forward" ) or (matches[2] == "فوروارد" )) then
return mute_forward(msg ,data, target)
end
if ((matches[2] == "location" ) or (matches[2] == "مکان" )) then
return mute_location(msg ,data, target)
end
if ((matches[2] == "document" ) or (matches[2] == "فایل" )) then
return mute_document(msg ,data, target)
end
if ((matches[2] == "inline" ) or (matches[2] == "اینلاین" )) then
return mute_inline(msg ,data, target)
end
if ((matches[2] == "game" ) or (matches[2] == "بازی" )) then
return mute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" ) or (matches[2] == "صفحه کلید" )) then
return mute_keyboard(msg ,data, target)
end
if ((matches[2] == "link" ) or (matches[2] == "لینک" )) then
return lock_link(msg, data, target)
end
if ((matches[2] == "join" ) or (matches[2] == "ورود" )) then
return lock_join(msg, data, target)
end
if ((matches[2] == "tag" ) or (matches[2] == "تگ" )) then
return lock_tag(msg, data, target)
end
if ((matches[2] == "username" ) or (matches[2] == "نام کاربری" )) then
return lock_username(msg, data, target)
end
if ((matches[2] == "mention" ) or (matches[2] == "فراخوانی" )) then
return lock_mention(msg, data, target)
end
if ((matches[2] == "arabic" ) or (matches[2] == "عربی" )) then
return lock_arabic(msg, data, target)
end
if ((matches[2] == "english" ) or (matches[2] == "انگلیسی" )) then
return lock_english(msg, data, target)
end
if ((matches[2] == "edit" ) or (matches[2] == "ویرایش" )) then
return lock_edit(msg, data, target)
end
if ((matches[2] == "markdown" ) or (matches[2] == "فونت" )) then
return lock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" ) or (matches[2] == "وب" )) then
return lock_webpage(msg, data, target)
end
if ((matches[2] == "bots" ) or (matches[2] == "ربات" )) then
return lock_bots(msg, data, target)
end
if ((matches[2] == "pin" ) or (matches[2] == "سنجاق" )) and is_owner(msg) then
return lock_pin(msg, data, target)
end
if ((matches[2] == "spam" ) or (matches[2] == "هرزنامه" )) then
return lock_spam(msg, data, target)
end
if ((matches[2] == "flood" ) or (matches[2] == "پیام مکرر" )) then
return lock_flood(msg, data, target)
end
if ((matches[2] == "tgservice" ) or (matches[2] == "سرویس تلگرام" )) then
return mute_tgservice(msg ,data, target)
end
if ((matches[2]:lower() == 'cmds') or (matches[2]:lower() == 'دستورات')) and is_owner(msg) then
			redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
			if not lang then
			return '>Ƈмɗѕ нαѕ вєєη Ɩσcкєɗ fσя мємвєя🤖🔒\n*OяɗєяƁу :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]'
			else
			return 'دستورات برای کاربر عادی قفل شد 🤖🔒\n*سفارش توسط :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]'
			end
			end
end
if ((matches[1]:lower() == "unlock" ) or (matches[1] == "بازکردن" )) and is_mod(msg) then
local target = msg.to.id	
if ((matches[2] == "self" ) or (matches[2] == "سلف" )) then
return unmute_video_self(msg, data, target)
end
if ((matches[2] == "gif" ) or (matches[2] == "گیف" )) then
return unmute_gif(msg, data, target)
end
if ((matches[2] == "text" ) or (matches[2] == "متن" )) then
return unmute_text(msg ,data, target)
end
if ((matches[2] == "photo" ) or (matches[2] == "عکس" )) then
return unmute_photo(msg ,data, target)
end
if ((matches[2] == "video" ) or (matches[2] == "فیلم" )) then
return unmute_video(msg ,data, target)
end
if ((matches[2] == "audio" ) or (matches[2] == "اهنگ" )) then
return unmute_audio(msg ,data, target)
end
if ((matches[2] == "voice" ) or (matches[2] == "ویس" )) then
return unmute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" ) or (matches[2] == "استیکر" )) then
return unmute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" ) or (matches[2] == "مخاطب" )) then
return unmute_contact(msg ,data, target)
end
if ((matches[2] == "forward" ) or (matches[2] == "فوروارد" )) then
return unmute_forward(msg ,data, target)
end
if ((matches[2] == "location" ) or (matches[2] == "مکان" )) then
return unmute_location(msg ,data, target)
end
if ((matches[2] == "document" ) or (matches[2] == "فایل" )) then
return unmute_document(msg ,data, target)
end
if ((matches[2] == "inline" ) or (matches[2] == "اینلاین" )) then
return unmute_inline(msg ,data, target)
end
if ((matches[2] == "game" ) or (matches[2] == "بازی" )) then
return unmute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" ) or (matches[2] == "صفحه کلید" )) then
return unmute_keyboard(msg ,data, target)
end
if ((matches[2] == "link" ) or (matches[2] == "لینک" )) then
return unlock_link(msg, data, target)
end
if ((matches[2] == "join" ) or (matches[2] == "ورود" )) then
return unlock_join(msg, data, target)
end
if ((matches[2] == "tag" ) or (matches[2] == "تگ" )) then
return unlock_tag(msg, data, target)
end
if ((matches[2] == "username" ) or (matches[2] == "نام کاربری" )) then
return unlock_username(msg, data, target)
end
if ((matches[2] == "mention" ) or (matches[2] == "فراخوانی" )) then
return unlock_mention(msg, data, target)
end
if ((matches[2] == "arabic" ) or (matches[2] == "عربی" )) then
return unlock_arabic(msg, data, target)
end
if ((matches[2] == "english" ) or (matches[2] == "انگلیسی" )) then
return unlock_english(msg, data, target)
end
if ((matches[2] == "edit" ) or (matches[2] == "ویرایش" )) then
return unlock_edit(msg, data, target)
end
if ((matches[2] == "markdown" ) or (matches[2] == "فونت" )) then
return unlock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" ) or (matches[2] == "وب" )) then
return unlock_webpage(msg, data, target)
end
if ((matches[2] == "bots" ) or (matches[2] == "ربات" )) then
return unlock_bots(msg, data, target)
end
if ((matches[2] == "pin" ) or (matches[2] == "سنجاق" )) and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if ((matches[2] == "spam" ) or (matches[2] == "هرزنامه" )) then
return unlock_spam(msg, data, target)
end
if ((matches[2] == "flood" ) or (matches[2] == "پیام مکرر" )) then
return unlock_flood(msg, data, target)
end
if ((matches[2] == "tgservice" ) or (matches[2] == "سرویس تلگرام" )) then
return unmute_tgservice(msg ,data, target)
end		
if ((matches[2]:lower() == 'cmds') or (matches[2]:lower() == 'دستورات')) and is_owner(msg) then
			redis:del('group:'..msg.to.id..':cmd')
			if not lang then
			return '>Ƈмɗѕ нαѕ вєєη υηƖσcкєɗ fσя мємвєя 🤖🔓\n*OяɗєяƁу :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]'
			else
			return 'دستورات برای کاربر عادی باز شد 🤖🔓\n*سفارش توسط :* [@'..check_markdown(msg.from.username or '')..'*|*`'..msg.from.id..'`]'
			end
end
 if matches[2]:lower() == 'mutetime' or matches[2] == 'زمان بیصدا' then
         local hash = 'muteall:'..msg.to.id
        redis:del(hash)
		if not lang then
          return "*>Lσcк тιмє* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
		  else
		  return "گروه ازاد شد و افراد می توانند دوباره پست بگذارند 🤖🔊\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
		  end
end
end
if ((matches[1]:lower() == "lock gp" ) or (matches[1] == "قفل گروه" )) and is_mod(msg) then
local hash = 'muteall:'..msg.to.id
redis:set(hash, true)
if not lang then
return "*>Ɗσηє*\n`AƖƖ Uѕєя SιƖєηт` 🤖🔒\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "*>انجام شد*\n`تمام کاربران در حالت سکوت قرار گرفتن` 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end
end
if ((matches[1]:lower() == "unlock gp" ) or (matches[1] == "بازکردن گروه" )) and is_mod(msg) then
local hash = 'muteall:'..msg.to.id
        redis:del(hash)
		if not lang then
return "*>Ɗσηє*\n`AƖƖ Uѕєя UηѕιƖєηт` 🤖🔓\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]" 
else
return "*>انجام شد*\n`تمام کاربران از حالت سکوت ازاد شدن` 🤖🔒\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
end 
end
if ((matches[1]:lower() == 'cmds' ) or (matches[1] == 'دستورات' )) and is_owner(msg) then 
		if matches[2]:lower() == 'owners' or matches[2] == 'مالک' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner')
        if not lang then		
		return 'cmds set for owner or higher'
		else
		return 'دستورات برای مدیرکل به بالا دیگر جواب می دهد'
        end		
		end
		if matches[2]:lower() == 'mods' or matches[2] == 'مدیر' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
		if not lang then
		return 'cmds set for moderator or higher'
		else
		return 'دستورات برای مدیر به بالا دیگر جواب می دهد'
		end
		end 
		if matches[2]:lower() == 'members' or matches[2] == 'کاربر' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'member') 
		if not lang then
		return 'cmds set for member or higher' 
		else
		return 'دستورات برای کاربر عادی به بالا دیگر جواب می دهد'
		end
		end 
	end
if ((matches[1]:lower() == "gpinfo" ) or (matches[1] == 'اطلاعات گروه' )) and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
if not lang then
ginfo = "*Group Info :*\n_Admin Count :_ *"..data.administrator_count_.."*\n_Member Count :_ *"..data.member_count_.."*\n_Kicked Count :_ *"..data.kicked_count_.."*\n_Group ID :_ *"..data.channel_.id_.."*"
elseif lang then
ginfo = "*اطلاعات گروه :*\n_تعداد مدیران :_ *"..data.administrator_count_.."*\n_تعداد اعضا :_ *"..data.member_count_.."*\n_تعداد اعضای حذف شده :_ *"..data.kicked_count_.."*\n_شناسه گروه :_ *"..data.channel_.id_.."*"
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if ((matches[1]:lower() == 'newlink' ) or (matches[1] == 'لینک جدید' )) and is_mod(msg) and not matches[2] then
	local function callback_link (arg, data)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if ((matches[1]:lower() == 'setlink' ) or (matches[1] == 'تنظیم لینک' )) and is_owner(msg) then
		if not matches[2] then
		data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
			if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return 'لطفا لینک گروه خود را ارسال کنید'
       end
	   end
		 data[tostring(chat)]['settings']['linkgp'] = matches[2]
			 save_data(_config.moderation.data, data)
      if not lang then
			return '_Group Link Was Saved Successfully._'
    else 
         return 'لینک گروه شما با موفقیت ذخیره شد'
       end
		end
		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "لینک جدید ذخیره شد"
		 	end
       end
		end
if ((matches[1]:lower() == "link") or (matches[1] == "لینک")) and is_mod(msg) and not matches[2] then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
    if not lang then
    texth = "Tab Here For Join To 👉"
        elseif lang then
    texth = "برای وارد شدن به گروه کلیک کنید 👈"
    end
local function inline_link_cb(TM, MR)
      if MR.results_ and MR.results_[0] then
tdcli.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, MR.inline_query_id_, MR.results_[0].id_, dl_cb, nil)
    else
     if not lang then
       text = "<b>Bold is offline</b>\n\n<b>Group Link :</b>\n"..linkgp
     else
      text = "<i>ربات Bold خاموش است</i>\n\n<b>لینک گروه :</b>\n"..linkgp
         end
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "html")
   end
end
tdcli.getInlineQueryResults(107705060, msg.to.id, 0, 0, ""..texth.."[ "..msg.to.title.."]("..linkgp..")", 0, inline_link_cb, nil)
end
  if ((matches[1]:lower() == "setrules" ) or (matches[1] == 'تنظیم قوانین' )) and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "قوانین گروه ثبت شد"
   end
  end
  if (matches[1]:lower() == "rules" ) or (matches[1] == 'قوانین' ) then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban."
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود."
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if ((matches[1]:lower() == "res" ) or (matches[1] == 'کاربری' )) and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if ((matches[1]:lower() == "whois" ) or (matches[1] == 'شناسه' )) and matches[2] and string.match(matches[2], '^%d+$') and is_mod(msg) then
local texten = "Click To See The User's Profile..!"
local textfa = "کلیک کنید برای دیدن مشخصات کاربر..!"
local id = matches[2]
if not lang then
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_= texten, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=34, user_id_=id}}}}, dl_cb, nil)
else
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_= textfa, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=35, user_id_=id}}}}, dl_cb, nil)
end
end

if ((matches[1]:lower() == 'setchar' ) or (matches[1]:lower() == 'حداکثر حروف مجاز' )) then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "*Character sensitivity* _has been set to :_ *[ "..matches[2].." ]*"
   else
     return "_حداکثر حروف مجاز در پیام تنظیم شد به :_ *[ "..matches[2].." ]*"
		end
  end
  if ((matches[1]:lower() == 'setflood' ) or (matches[1] == 'تنظیم پیام مکرر' )) and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "_Wrong number, range is_ *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
    else
    return '_محدودیت پیام مکرر به_ *'..tonumber(matches[2])..'* _تنظیم شد._'
    end
       end
  if ((matches[1]:lower() == 'setfloodtime' ) or (matches[1] == 'تنظیم زمان بررسی' )) and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "_Wrong number, range is_ *[2-10]*"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _check time has been set to :_ *[ "..matches[2].." ]*"
    else
    return "_حداکثر زمان بررسی پیام های مکرر تنظیم شد به :_ *[ "..matches[2].." ]*"
    end
       end
	   if matches[1] == 'addkick' and is_admin(msg) then
        if gp_type(msg.to.id) == "channel" then
            tdcli.getChannelMembers(msg.to.id, 0, "Kicked", 200, function (i, naji)
                for k,v in pairs(naji.members_) do
                    tdcli.addChatMember(i.chat_id, v.user_id_, 50, dl_cb, nil)
                end
            end, {chat_id=msg.to.id})
            return "`اعضای محروم از گروه به گروه دعوت شدند`"
        end
        return "_😐 فقط در _`سوپر گروه`_ ممکن است_"
    end
		if ((matches[1]:lower() == 'clean' ) or (matches[1] == 'پاک کردن' )) and is_owner(msg) then
					if matches[2]:lower() == 'bans' or matches[2] == 'لیست بن' then
				if next(data[tostring(chat)]['banned']) == nil then
                     if not lang then
					return "_No_ *banned* _users in this group_"
					else
					return "*هیچ کاربری از این گروه محروم نشده*"
					end
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				if not lang then
				return "_All_ *banned* _users has been unbanned_"
				else
				return "*تمام کاربران محروم شده از گروه از محرومیت خارج شدند*"
				end
			end
			if matches[2]:lower() == 'silentlist' or matches[2] == 'لیست سکوت' then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
				if not lang then
					return "_No_ *silent* _users in this group_"
					else
					return "*لیست کاربران سایلنت شده خالی است*"
					end
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
					if not lang then
				return "*Silent list* _has been cleaned_"
				else
				return "*لیست کاربران سایلنت شده پاک شد*"
				end
			    end
			if matches[2] == 'mods' or matches[2] == 'مدیران' then
				if next(data[tostring(chat)]['mods']) == nil then
				if not lang then
					return "_No_ *moderators* _in this group_"
					else
					return "هیچ مدیری برای گروه انتخاب نشده است"
					end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				if not lang then
				return "_All_ *moderators* _has been demoted_"
				else
				return "تمام مدیران گروه تنزیل مقام شدند"
				end
         end
           if matches[2] == 'filterlist' or matches[2] == 'لیست فیلتر' then
				if next(data[tostring(chat)]['filterlist']) == nil then
				if not lang then
					return "*Filtered words list* _is empty_"
					else
					return "_لیست کلمات فیلتر شده خالی است_"
					end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				if not lang then
				return "*Filtered words list* _has been cleaned_"
				else
				return "_لیست کلمات فیلتر شده پاک شد_"
				end
			end
			if matches[2] == 'rules' or matches[2] == 'قوانین' then
				if not data[tostring(chat)]['rules'] then
				if not lang then
					return "_No_ *rules* _available_"
					else
					return "قوانین برای گروه ثبت نشده است"
					end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
					if not lang then
				return "*Group rules* _has been cleaned_"
				else
				return "قوانین گروه پاک شد"
				end
       end
			if matches[2] == 'welcome' or matches[2] == 'خوشآمد' then
				if not data[tostring(chat)]['setwelcome'] then
				if not lang then
					return "*Welcome Message not set*"
					else
					return "پیام خوشآمد گویی ثبت نشده است"
					end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
					if not lang then
				return "*Welcome message* _has been cleaned_"
				else
				return "پیام خوشآمد گویی پاک شد"
				end
       end
			if matches[2] == 'about' or matches[2] == 'درباره' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
				if not lang then
					return "_No_ *description* _available_"
					else
					return "پیامی مبنی بر درباره گروه ثبت نشده است"
					end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
			if not lang then
				return "*Group description* _has been cleaned_"
			else
				return "پیام مبنی بر درباره گروه پاک شد"
			end
		   	end
        end
		if ((matches[1]:lower() == 'clean' ) or (matches[1] == 'پاک کردن' )) and is_admin(msg) then
			if matches[2] == 'owners' or matches[2] == 'مالکان' then
				if next(data[tostring(chat)]['owners']) == nil then
				if not lang then
					return "_No_ *owners* _in this group_"
					else
					return "مالکی برای گروه انتخاب نشده است"
					end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				if not lang then
				return "_All_ *owners* _has been demoted_"
				else
				return "تمامی مالکان گروه تنزیل مقام شدند"
				end
			end
     end
if ((matches[1]:lower() == "setname" ) or (matches[1] == 'تنظیم نام' )) and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if ((matches[1]:lower() == "setabout" ) or (matches[1] == 'تنظیم درباره' )) and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "پیام مبنی بر درباره گروه ثبت شد"
      end
  end
  if ((matches[1]:lower() == "about" ) or (matches[1] == 'درباره' )) and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if ((matches[1]:lower() == 'filter' ) or (matches[1] == 'فیلتر' ))and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if ((matches[1]:lower() == 'unfilter' ) or (matches[1] == 'حذف فیلتر' ))and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if ((matches[1]:lower() == 'config' ) or (matches[1] == 'پیکربندی' )) and is_admin(msg) then
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, config_cb, {chat_id=msg.to.id})
  end
  if ((matches[1]:lower() == 'filterlist' ) or (matches[1] == 'لیست فیلتر' )) and is_mod(msg) then
    return filter_list(msg)
  end
if (matches[1]:lower() == "modlist" ) or (matches[1] == 'لیست مدیران' ) then
return modlist(msg)
end
if ((matches[1]:lower() == "whitelist" ) or (matches[1] == 'لیست سفید' )) and not matches[2] then
return whitelist(msg.to.id)
end
if ((matches[1]:lower() == "ownerlist" ) or (matches[1] == 'لیست مالکان' )) and is_owner(msg) then
return ownerlist(msg)
end
if ((matches[1]:lower() == "option" ) or (matches[1] == 'تنظیمات کلی' )) and is_mod(msg) then
local function inline_query_cb(arg, data)
      if data.results_ and data.results_[0] then
tdcli.sendInlineQueryResultMessage(msg.chat_id_, msg.id_, 0, 1, data.inline_query_id_, data.results_[0].id_)
redis:setex("ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true)
redis:setex("ReqMenu:" .. msg.to.id, 260, true)
    else
    if not lang then
    text = "*Helper is offline*\n\n"
        elseif lang then
    text = "_ربات هلپر خاموش است_\n\n"
    end
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdcli.getInlineQueryResults(helper_id, msg.to.id, 0, 0, msg.to.id, 0, inline_query_cb, nil)
end
end
if ((matches[1]:lower() == "settings" ) or (matches[1] == 'تنظیمات' )) and is_mod(msg) then
return group_settings(msg, target)
end
if (matches[1]:lower() == "setlang") and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if matches[2] == "fa" then
redis:set(hash, true)
return "*زبان گروه تنظیم شد به : فارسی*"
end
end
if (matches[1] == 'زبان انگلیسی') and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "_Group Language Set To:_ EN"
end
if ((matches[1]:lower() == 'setwarn' ) or (matches[1] == "حداکثر اخطار" )) and is_owner(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 20 then
     if not lang then
				return "`Wroɴɢ ɴυмвer, rαɴɢe ιѕ` *[1-20]*"
    else
				return "`لطفا عددی بین` *[1-20]* `را انتخاب کنید`"
      end
    end
			local warn_max = matches[2]
   redis:set('max_warn:'..msg.to.id, warn_max)
    if not lang then
     return "*Wαrɴ Mαхιмυм* `Hαѕ Beeɴ Seт To :` *[*`"..matches[2].."`*]*"
   else
     return "`حداکثر اخطار تنظیم شد به :` *[*`"..matches[2].."`*]*"
		end
end
 if ((matches[1]:lower() == 'mutetime' ) or (matches[1] == 'زمان بیصدا' )) and is_mod(msg) then
local hash = 'muteall:'..msg.to.id
local hour = tonumber(matches[2])
local num1 = (tonumber(hour) * 3600)
local minutes = tonumber(matches[3])
local num2 = (tonumber(minutes) * 60)
local second = tonumber(matches[4])
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "_Mute all has been enabled for_ \n⏺ *hours :* `"..matches[2].."`\n⏺ *minutes :* `"..matches[3].."`\n⏺ *seconds :* `"..matches[4].."`"
 elseif lang then
 return "بی صدا کردن فعال شد 🤖✅\nدر \n⏺ ساعت : "..matches[2].."\n⏺ دقیقه : "..matches[3].."\n⏺ ثانیه : "..matches[4]
 end
 end
 if ((matches[1]:lower() == 'mutehours' ) or (matches[1]== 'ساعت بیصدا' )) and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local hour = matches[2]
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[2]
 elseif lang then
 return "بی صدا کردن فعال شد 🤖✅\nدر \n⏺ ساعت : "..matches[2]
 end
 end
  if ((matches[1]:lower() == 'muteminutes' ) or (matches[1]== 'دقیقه بیصدا' ))  and is_mod(msg) then
 local hash = 'muteall:'..msg.to.id
local minutes = matches[2]
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ minutes : "..matches[2]
 elseif lang then
 return "بی صدا کردن فعال شد 🤖✅\nدر \n⏺ دقیقه : "..matches[2]
 end
 end
  if ((matches[1]:lower() == 'muteseconds' ) or (matches[1] == 'ثانیه بیصدا' ))  and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local second = matches[2]
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "Mute all has been enabled for \n⏺ seconds : "..matches[2]
 elseif lang then
 return "بی صدا کردن فعال شد 🤖✅\nدر \n⏺ ثانیه : "..matches[2]
 end
 end
 if ((matches[1]:lower() == 'muteall' ) or (matches[1] == 'موقعیت' )) and ((matches[2]:lower() == 'status' ) or (matches[2] == 'بیصدا' )) and is_mod(msg) then
         local hash = 'muteall:'..msg.to.id
      local mute_time = redis:ttl(hash)
		
		if tonumber(mute_time) < 0 then
		if not lang then
		return '_Mute All is Disable._'
		else
		return '_بیصدا بودن گروه غیر فعال است  ♻️⚠️._'
		end
		else
		if not lang then
          return mute_time.." Sec"
		  elseif lang then
		  return mute_time.."ثانیه"
		end
		end
  end
--------------------------------
if ((matches[1]:lower() == 'rmsg' ) or (matches[1] == 'پاکسازی' )) and is_mod(msg) then
        if tostring(msg.to.id):match("^-100") then 
            if tonumber(matches[2]) > 1000 or tonumber(matches[2]) < 1 then
                return  '🚫 *1000*> _تعداد پیام های قابل پاک سازی در هر دفعه_ >*1* 🚫'
            else
        if not lang then  
				tdcli.getChatHistory(msg.to.id, msg.id,0 , 100, delmsg, {msgs=matches[2]})
				return "`"..matches[2].." `A recent message was cleared"
				else
				tdcli.getChatHistory(msg.to.id, msg.id,0 , 100, delmsg, {msgs=matches[2]})
				return "`"..matches[2].." `*پیام اخیر پاکسازی شد*"
				end
            end
        else
            return '⚠️ _این قابلیت فقط در سوپرگروه ممکن است_ ⚠️'
        end
    end
	--------------------------------
if ((matches[1]:lower() == "dev" ) or (matches[1] == "برنامه نویس" )) and is_mahdiroo(msg) then 
      tdcli.sendContact(msg.chat_id_, msg.id_, 0, 1, nil, 989015858478, 'MahDi', 'Mohseni', 377450049)
end
--------------------------------
	if (matches[1]:lower() == "info" ) or (matches[1] == "اطلاعات ایدی" ) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, info_by_reply, {chat_id=msg.chat_id_})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id_) == 0 then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, info_by_id, {chat_id=msg.chat_id_,user_id=matches[2],msgid=msg.id_})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id_) == 0 then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, info_by_username, {chat_id=msg.chat_id_,username=matches[2],msgid=msg.id_})
      end
  if not matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
local function info2_cb(arg, data)
      if tonumber(data.id_) then
    if data.username_ then
  username = "@"..check_markdown(data.username_)
    else
  username = ""
  end
    if data.first_name_ then
  firstname = check_markdown(data.first_name_)
    else
  firstname = ""
  end
    if data.last_name_ then
  lastname = check_markdown(data.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n\n"
		    if data.id_ == tonumber(SUDO) then
		       text = text..'_Rank :_ *Executive Admin*\n\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n\n'
		 end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = msg.from.id,
  }, info_by_id, {chat_id=msg.chat_id_,user_id=msg.from.id,msgid=msg.id_})
      end
   end
if ((matches[1]:lower() == "del" ) or (matches[1] == "حذف" ))  and msg.reply_to_message_id_ ~= 0 and is_mod(msg) then
        tdcli.deleteMessages(msg.to.id,{[0] = tonumber(msg.reply_id),msg.id})
end
if (matches[1]:lower() == 'mydel' ) or (matches[1] == 'پاکسازی پیام های من' ) then  
tdcli.deleteMessagesFromUser(msg.to.id, msg.sender_user_id_, dl_cb, cmd)
     if not lang then   
           tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '*Done :)*', 1, 'md')
		   else
		   tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '_انجام شد :)_', 1, 'md')
	 end
end
if matches[1] == "test" then
            local utf8 = dofile('./data/MenTion.lua')
local id = matches[2]
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=matches[3], disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=utf8.len(matches[3]), user_id_=id}}}}, dl_cb, nil)
end
if (matches[1]:lower() == 'ping' ) or (matches[1] == 'انلاینی' ) then
if not lang then
return "*PonG 🤖✅* `>["..(msg.from.username or ':|').."]<`"
   else
return "*آنلاینم 🤖✅* `>["..(msg.from.username or ':|').."]<`" 
   end
end
--------------------- Welcome -----------------------
	if ((matches[1]:lower() == "welcome" ) or (matches[1] == 'خوشآمد' )) and is_mod(msg) then
		if matches[2]:lower() == "enable" or matches[2] == "فعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
			if not lang then
				return "_Group_ *welcome* `Iѕ AƖяєαɗу ƐηαвƖєɗ` ♻️⚠️"
				else
				return "_خوشآمد گویی از قبل فعال بود_"
				end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
		if not lang then
				return "_Group_ *welcome* `Hαѕ Ɓєєη ƐηαвƖєɗ` 🤖🔇\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
				else
			    return "_خوشآمد گویی فعال شد 🤖✅\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]_"
				end
			end
		end
		
		if matches[2]:lower() == "disable" or matches[2] == "غیرفعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
			if not lang then
				return "_Group_ *Welcome* `Iѕ AƖяєαɗу ƊιѕαвƖєɗ` ❌🔐"
				else
				return "_خوشآمد گویی از قبل فعال نبود_"
				end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
		if not lang then
				return "_Group_ *welcome* `Hαѕ Ɓєєη ƊιѕαвƖєɗ` 🤖🔊\n*OяɗєяƁу :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]"
				else
				return "_خوشآمد گویی غیرفعال شد 🤖✅\n*سفارش توسط :* [@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]_"
				end
			end
		end
	end
	if ((matches[1]:lower() == "setwelcome" ) or (matches[1] == 'تنظیم خوشآمد' )) and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{time} ➣ Show time english _\n_{date} ➣ Show date english _\n_{timefa} ➣ Show time persian _\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{time} ➣ ساعت به زبان انگلیسی _\n_{date} ➣ تاریخ به زبان انگلیسی _\n_{timefa} ➣ ساعت به زبان فارسی _\n_{datefa} ➣ تاریخ به زبان فارسی _\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"
        end
     end 
end
redis:incr("allmsg")
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match('-100(%d+)') then
if not redis:sismember("su",msg.chat_id_) then
redis:sadd("su",msg.chat_id_)
end
elseif id:match('-(%d+)') then
if not redis:sismember("gp",msg.chat_id_) then
redis:sadd("gp",msg.chat_id_)
end
elseif id:match('') then
if not redis:sismember("user",msg.chat_id_) then
redis:sadd("user",msg.chat_id_)
end
end
end
if ((matches[1]:lower() == 'stats') or (matches[1] == 'آمار')) and is_sudo(msg) then
-------------------------------------------------
local allmsg = redis:get("allmsg")
-------------------------------------------------
local gps = redis:scard("su")
-------------------------------------------------
local gp = redis:scard("gp")
-------------------------------------------------
local user = redis:scard("user")
-------------------------------------------------
       return '> گزارش ربات: \n\n> تمام پیام های دریافتی : '..allmsg..'\n\n> تعداد سوپر گروه ها : '..gps..'\n\n> تعداد گروه ها : '..gp..'\n\n> کاربران پیوی: '..user..'\n'
end
if matches[1]:lower() == "nerkh" or matches[1] == 'نرخ' then
text = [[
*💵 نرخ فروش ربات* 
*⚜️  ᴹᵃ̶ᵀ̶ᵃ̶ᴰ̶ᵒ̶ᴿ̶ ̶P̶l̶u̶s ⚜️*

*✳️برای تمام گروه ها‌*
 
*➰1 ماهه 10 هزا تومان 
➰2 ماهه  15 هزار تومان
➰3 ماهه  20 هزار تومان
➰4 ماهه  25 هزار تومان*

_🔰 نکته مهم :_

`🎖توجه داشته باشید ربات به مدت  ۴۸ ساعت رایگان برای تست در گروه نصب می‌شود و بعد تست و رضایت کامل اعمالات صورت می‌گیرد`

*برای خرید به گروه پشتیبانی مراجعه و اعلام کنید:*
🆔 : ]]
return text..MaTaDoRch
end
end
----------------------------------------
local checkmod = true
local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdcli.sendMessage(msg.to.id, 0, 1, '_Robot isn\'t Administrator, Please promote to Admin!_', 1, "md")
			else
				return tdcli.sendMessage(msg.to.id, 0, 1, '_لطفا برای کارکرد کامل دستورات، ربات را به مدیر گروه ارتقا دهید._', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://probot.000webhostapp.com/api/time.php/')
          if res ~= 200 then return "No connection" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_خوش آمدید_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@BeyondTeam"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@BeyondTeam"
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end

 end
----------------------------------------
return {
patterns ={
 "^[!#/]([Ss]tats)$",
 "^([Ss]tats)$",
 "^(آمار)$",
 "^([Ii][Dd])$",
 "^([Mm][Ee])$",
 "^([Oo][Pp][Tt][Ii][Oo][Nn])$",
 "^([Aa][Dd][Dd])$",
 "^([Rr][Ee][Mm])$",
 "^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
 "^([Pp][Ii][Nn])$",
 "^([Uu][Nn][Pp][Ii][Nn])$",
 "^([Gg][Pp][Ii][Nn][Ff][Oo])$",
 "^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
 "^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt])$",
 "^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr])$",
 "^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr])$",
 "^([Pp][Rr][Oo][Mm][Oo][Tt][Ee])$",
 "^([Dd][Ee][Mm][Oo][Tt][Ee])$",
 "^([Mm][Oo][Dd][Ll][Ii][Ss][Tt])$",
 "^([Oo][Ww][Nn][Ee][Rr][Ll][Ii][Ss][Tt])$",
 "^([Ll][Ii][Nn][Kk])$",
 "^([Ss][Ee][Tt][Ll][Ii][Nn][Kk])$",
 "^([Nn][Ee][Ww][Ll][Ii][Nn][Kk])$",
 "^([Rr][Uu][Ll][Ee][Ss])$",
 "^([Ss][Ee][Tt][Tt][Ii][Nn][Gg][Ss])$",
 "^([Aa][Bb][Oo][Uu][Tt])$",
 "^([Hh][Ee][Ll][Pp])$",
 "^([Ff][Ii][Ll][Tt][Ee][Rr][Ll][Ii][Ss][Tt])$",
 "^([Cc][Oo][Nn][Ff][Ii][Gg])$",
 "^([Tt]ime)$",
 "^([Nn]erkh)$",
 "^([Hh]elpfun)$",
 "^([Tt]ophoto)$",
 "^([Tt]osticker)$",
 "^([Pp]raytime)$",
 "^([Aa]zan)$",
 "^([Aa]dminset)$", 
 "^([Aa]dmindem)$",
 "^([Aa]dminlist)$",
 "^([Hh]elptools)$", 
 "^([Ss]udoset)$", 
 "^([Ss]udodem)$",
 "^([Ss]udolist)$",
 "^([Ll]eave)$",
 "^([Tt]osuper)$",
 "^([Cc]hats)$",
 "^([Mm]ydel)$",
 "^([Mm]atador)$",
 "^([Gg]id)$",
 "^([Cc]heckexpire)$",
 "^([Cc]lear cache)$",
 "^([Bb]anlist)$",
 "^([Ss]ilent)$",
 "^([Ii][Nn][Vv][Ii]te)$",
 "^([Gg]banlist)$",
 "^([Bb]an)$",
 "^([Rr]eload)$",
 "^([Hh]elpmod)$", 
 "^([Hh]elpmute)$", 
 "^([Hh]elplock)$",
 "^([Pp]list)$",
 "^([Dd]el)$",
 "^([Ii]nfo)$",
 "^([Kk]ick)$",
 "^([Uu]nsilent)$",
 "^([Bb]anall)$",
 "^([Uu]nbanall)$",
 "^([Uu]nban)$",
 "^([Ss]ilentlist)$",
 '^([Hh]elpmute)$',
 "^([Dd]elall)$",
 '^([P][Ii][Nn][Gg])$',
 "^[#!/]([Ii][Dd])$",
 '^([Ll]ock gp)$',
 '^(قفل گروه)$',
 '^(بازکردن گروه)$',
 '^([Uu]nlock gp)$',
 "^[#!/]([Ll]ock gp)$",
 "^[#!/]([Uu]nlock gp)$",
 "^[#!/]([Mm][Ee])$",
 "^[#!/]([Oo][Pp][Tt][Ii][Oo][Nn])$",
 "^[#!/]([Aa][Dd][Dd])$",
 "^[#!/]([Rr][Ee][Mm])$",
 "^[#!/]([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
 "^[#!/]([Pp][Ii][Nn])$",
 "^[#!/]([Uu][Nn][Pp][Ii][Nn])$",
 "^[#!/]([Gg][Pp][Ii][Nn][Ff][Oo])$",
 "^[#!/]([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
 "^[#!/]([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt])$",
 "^[#!/]([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr])$",
 "^[#!/]([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr])$",
 "^[#!/]([Pp][Rr][Oo][Mm][Oo][Tt][Ee])$",
 "^[#!/]([Dd][Ee][Mm][Oo][Tt][Ee])$",
 "^[#!/]([Mm][Oo][Dd][Ll][Ii][Ss][Tt])$",
 "^[#!/]([Oo][Ww][Nn][Ee][Rr][Ll][Ii][Ss][Tt])$",
 "^[#!/]([Ll][Ii][Nn][Kk])$",
 "^[#!/]([Ss][Ee][Tt][Ll][Ii][Nn][Kk])$",
 "^[#!/]([Nn][Ee][Ww][Ll][Ii][Nn][Kk])$",
 "^[#!/]([Rr][Uu][Ll][Ee][Ss])$",
 "^[#!/]([Ss][Ee][Tt][Tt][Ii][Nn][Gg][Ss])$",
 "^[#!/]([Aa][Bb][Oo][Uu][Tt])$",
 "^[#!/]([Hh][Ee][Ll][Pp])$",
 "^[#!/]([Ff][Ii][Ll][Tt][Ee][Rr][Ll][Ii][Ss][Tt])$",
 "^[#!/]([Cc][Oo][Nn][Ff][Ii][Gg])$",
 "^[#!/]([Tt]ime)$",
 "^[#!/]([Nn]erkh)$",
 "^[#!/]([Hh]elpfun)$",
 "^[#!/]([Tt]ophoto)$",
 "^[#!/]([Tt]osticker)$",
 "^[#!/]([Pp]raytime)$",
 "^[#!/]([Aa]zan)$",
 "^[#!/]([Aa]dminset)$", 
 "^[#!/]([Aa]dmindem)$",
 "^[#!/]([Aa]dminlist)$",
 "^[#!/]([Hh]elptools)$", 
 "^[#!/]([Ss]udoset)$", 
 "^[#!/]([Ss]udodem)$",
 "^[#!/]([Ss]udolist)$",
 "^[#!/]([Ll]eave)$",
 "^[#!/]([Tt]osuper)$",
 "^[#!/]([Cc]hats)$",
 "^[#!/]([Mm]ydel)$",
 "^[#!/]([Mm]atador)$",
 "^[#!/]([Gg]id)$",
 "^[#!/]([Cc]heckexpire)$",
 "^[#!/]([Cc]lear cache)$",
 "^[#!/]([Bb]anlist)$",
 "^[#!/]([Ss]ilent)$",
 "^[#!/]([Ii][Nn][Vv][Ii]te)$",
 "^[#!/]([Gg]banlist)$",
 "^[#!/]([Bb]an)$",
 "^[#!/]([Rr]eload)$",
 "^[#!/]([Hh]elpmod)$", 
 "^[#!/]([Hh]elpmute)$", 
 "^[#!/]([Hh]elplock)$",
 "^[#!/]([Pp]list)$",
 "^[#!/]([Dd]el)$",
 "^[#!/]([Ii]nfo)$",
 "^[#!/]([Kk]ick)$",
 "^[#!/]([Uu]nsilent)$",
 "^[#!/]([Bb]anall)$",
 "^[#!/]([Uu]nbanall)$",
 "^[#!/]([Uu]nban)$",
 "^[#!/]([Ss]ilentlist)$",
 '^[#!/]([Hh]elpmute)$',
 "^[#!/]([Dd]elall)$",
 '^[#!/]([P][Ii][Nn][Gg])$',
 '^(openchat)$',
'^(اطلاعات گروه)$',
'^(لینک جدید)$',
'^(حذف مالک)$',
'^(مدیر)$',
'^(لیست سفید)$',
'^(مالک)$',
'^(حذف ادمین گروه)$',
'^(تنظیمات)$',
'^(سنجاق)$',
'^(حذف سنجاق)$',
'^(نصب)$',
'^(لغو نصب)$',
'^(ادمین گروه)$',
'^(تنظیمات کلی)$',
'^(ایدی)$',
'^(اطلاعات من)$',
'^(راهنما بیصدا)$',
'^(لیست فیلتر)$',
'^(لیست بیصدا)$',
'^(لیست مالکان)$',
'^(لیست مدیران)$',
'^(راهنما مدیریتی)$',
'^(راهنما)$',
'^(پیکربندی)$',
'^(درباره)$',
'^(حذف)$',
'^(قوانین)$',
'^(لینک)$',
'^(تنظیم لینک)$',
"^(تبدیل به عکس)$",
"^(تبدیل به استیکر)$",
"^(اذان)$",
"^(ساعات شرعی)$",
"^(ساعت)$",
"^(لیست گروه ها)$",
"^(خروج)$",
"^(تبدیل به سوپر)$",
"^(حذف ادمین)$",
"^(افزودن ادمین)$",
"^(حذف سودو)$",
"^(راهنما ابزار)$",
"^(راهنما قفلی)$",
"^(لیست سودو)$",
"^(اطلاعات)$",
"^(نرخ)$",
"^(پیام منشی)$",
"^(اطلاعات ایدی)$",
"^(بارگذاری)$",
"^(لیست پلاگین)$",
"^(حذف پیام)$",
"^(افزودن)$",
"^(لیست سکوت)$",
"^(اخراج)$",
"^(پاکسازی پیام های من)$",
"^(حذف سکوت)$",
"^(لیست بن)$",
"^(سکوت)$",
"^(حذف بن)$",
"^(لیست سوپر بن)$",
"^(بن)$",
"^(حذف سوپر بن)$",
"^(پاک کردن حافظه)$",
"^(ماتادور)$",
"^(سوپر بن)$",
"^(اعتبار)$",
"^(لیست ادمین)$",
"^(افزودن سودو)$",
'^(زبان انگلیسی)$',
"^(راهنما سرگرمی)$",
'^(حذف مدیر)$',
'^(انلاینی)$',
"^[#!/]([Ii][Dd]) (.*)$",
"^([Ii][Dd]) (.*)$",
"^(ایدی) (.*)$",
"^[#!/]([Rr][Ee][Mm]) (.*)$",
"^([Rr][Ee][Mm]) (.*)$",
"^(لغو نصب) (.*)$",
"^[#!/]([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^(ادمین گروه) (.*)$",
"^[#!/]([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^(حذف ادمین گروه) (.*)$",
"^[#!/]([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-])$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-])$",
"^[#!/]([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-]) (.*)$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-]) (.*)$",
"^(لیست سفید) ([+-])$",
"^(لیست سفید) ([+-]) (.*)$",
"^[#!/]([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^(مالک) (.*)$",
"^[#!/]([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^(حذف مالک) (.*)$",
"^[#!/]([Pp][Rr][Oo][Mm][Oo][Tt][Ee]) (.*)$",
"^([Pp][Rr][Oo][Mm][Oo][Tt][Ee]) (.*)$",
"^(مدیر) (.*)$",
"^[#!/]([Dd][Ee][Mm][Oo][Tt][Ee]) (.*)$",
"^([Dd][Ee][Mm][Oo][Tt][Ee]) (.*)$",
"^(حذف مدیر) (.*)$",
"^[#!/]([Ll][Oo][Cc][Kk]) (.*)$",
"^([Ll][Oo][Cc][Kk]) (.*)$",
"^[#!/]([Un][Nn][Ll][Oo][Cc][Kk]) (.*)$",
"^([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)$",
"^(قفل) (.*)$",
"^(بازکردن) (.*)$",
"^[!/#]([Pp][Hh][Oo][Tt][Oo]) (.*)$",
"^([Pp][Hh][Oo][Tt][Oo]) (.*)$",
"^(عکس) (.*)$",
"^[!/#]([Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt]) (.*)$",
"^([Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt]) (.*)$",
"^(فایل) (.*)$",
"^[!/#]([Ss][Tt][Ii][Cc][Kk][Ee][Rr]) (.*)$",
"^([Ss][Tt][Ii][Cc][Kk][Ee][Rr]) (.*)$",
"^(استیکر) (.*)$",
"^[!/#]([Kk][Ee][Yy][Bb][Oo][Aa][Rr][Dd]) (.*)$",
"^([Kk][Ee][Yy][Bb][Oo][Aa][Rr][Dd]) (.*)$",
"^(صفحه کلید) (.*)$",
"^[!/#]([Vv][Ii][Dd][Ee][Oo]) (.*)$",
"^([Vv][Ii][Dd][Ee][Oo]) (.*)$",
"^(فیلم) (.*)$",
"^[!/#]([Ss][Ee][Ll][Ff]) (.*)$",
"^([Ss][Ee][Ll][Ff]) (.*)$",
"^(سلف) (.*)$",
"^[!/#]([Tt][Ee][Xx][Tt]) (.*)$",
"^([Tt][Ee][Xx][Tt]) (.*)$",
"^(متن) (.*)$",
"^[!/#]([Ff][Oo][Rr][Ww][Aa][Rr][Dd]) (.*)$",
"^([Ff][Oo][Rr][Ww][Aa][Rr][Dd]) (.*)$",
"^(فوروارد) (.*)$",
"^[!/#]([Ll][Oo][Cc][Aa][Tt][Ii][Oo][Nn]) (.*)$",
"^([Ll][Oo][Cc][Aa][Tt][Ii][Oo][Nn]) (.*)$",
"^(مکان) (.*)$",
"^[!/#]([Aa][Uu][Dd][Ii][Oo]) (.*)$",
"^([Aa][Uu][Dd][Ii][Oo]) (.*)$",
"^(اهنگ) (.*)$",
"^[!/#]([Vv][Oo][Ii][Cc][Ee]) (.*)$",
"^([Vv][Oo][Ii][Cc][Ee]) (.*)$",
"^(ویس) (.*)$",
"^[!/#]([Cc][Oo][Nn][Tt][Aa][Cc][Tt]) (.*)$",
"^([Cc][Oo][Nn][Tt][Aa][Cc][Tt]) (.*)$",
"^(مخاطب) (.*)$",
"^[!/#]([Ii][Nn][Ll][Ii][Nn][Ee]) (.*)$",
"^([Ii][Nn][Ll][Ii][Nn][Ee]) (.*)$",
"^(اینلاین) (.*)$",
"^[!/#]([Gg][Aa][Mm][Ee]) (.*)$",
"^([Gg][Aa][Mm][Ee]) (.*)$",
"^(بازی) (.*)$",
"^[!/#]([Ll][Ii][Nn][Kk]) (.*)$",
"^([Ll][Ii][Nn][Kk]) (.*)$",
"^(لینک) (.*)$",
"^[!/#]([Ee][Dd][Ii][Tt]) (.*)$",
"^([Ee][Dd][Ii][Tt]) (.*)$",
"^(ویرایش) (.*)$",
"^[!/#]([Tt][Aa][Gg]) (.*)$",
"^([Tt][Aa][Gg]) (.*)$",
"^(تگ) (.*)$",
"^[!/#]([Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee]) (.*)$",
"^([Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee]) (.*)$",
"^(نام کاربری) (.*)$",
"^[!/#]([Aa][Rr][Aa][Bb][Ii][Cc]) (.*)$",
"^([Aa][Rr][Aa][Bb][Ii][Cc]) (.*)$",
"^(عربی) (.*)$",
"^[!/#]([Ww][Ee][Bb][Pp][Aa][Gg][Ee]) (.*)$",
"^([Ww][Ee][Bb][Pp][Aa][Gg][Ee]) (.*)$",
"^(وب) (.*)$",
"^[!/#]([Mm][Aa][Rr][Kk][Dd][Oo][Ww][Nn]) (.*)$",
"^([Mm][Aa][Rr][Kk][Dd][Oo][Ww][Nn]) (.*)$",
"^(فراخوانی) (.*)$",
"^[!/#]([Mm][Ee][Nn][Tt][Ii][Oo][Nn]) (.*)$",
"^([Mm][Ee][Nn][Tt][Ii][Oo][Nn]) (.*)$",
"^(فونت) (.*)$",
"^[!/#]([Ee][Nn][Gg][Ll][Ii][Ss][Hh]) (.*)$",
"^([Ee][Nn][Gg][Ll][Ii][Ss][Hh]) (.*)$",
"^(انگلیسی) (.*)$",
"^[#!/]([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[#!/]([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?t.me/joinchat/%S+)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?t.me/joinchat/%S+)$",
"^(تنظیم لینک) ([https?://w]*.?telegram.me/joinchat/%S+)$",
"^(تنظیم لینک) ([https?://w]*.?t.me/joinchat/%S+)$",
"^[#!/]([Bb][Aa][Nn]) (.*)$",
"^([Bb][Aa][Nn]) (.*)$",
"^(بن) (.*)$",
"^[#!/]([Uu][Nn][Bb][Aa][Nn]) (.*)$",
"^([Uu][Nn][Bb][Aa][Nn]) (.*)$",
"^(حذف بن) (.*)$",
"^[#!/]([Mm][Uu][Tt][Ee][Aa][Ll][Ll]) ([Ss][Tt][Aa][Tt][Uu][Ss])$",
"^([Mm][Uu][Tt][Ee][Aa][Ll][Ll]) ([Ss][Tt][Aa][Tt][Uu][Ss])$",
"^[#!/]([Mm][Uu][Tt][Ee][Tt][Ii][Mm][Ee]) (%d+) (%d+) (%d+)$",
"^([Mm][Uu][Tt][Ee][Tt][Ii][Mm][Ee]) (%d+) (%d+) (%d+)$",
"^[#!/]([Mm][Uu][Tt][Ee][Hh][Oo][Uu][Rr][Ss]) (%d+)$",
"^([Mm][Uu][Tt][Ee][Hh][Oo][Uu][Rr][Ss]) (%d+)$",
"^[#!/]([Mm][Uu][Tt][Ee][Mm][Ii][Nn][Uu][Tt][Ee][Ss]) (%d+)$",
"^([Mm][Uu][Tt][Ee][Mm][Ii][Nn][Uu][Tt][Ee][Ss]) (%d+)$",
"^[#!/]([Mm][Uu][Tt][Ee][Ss][Ee][Cc][Oo][Nn][Dd][Ss]) (%d+)$",
"^([Mm][Uu][Tt][Ee][Ss][Ee][Cc][Oo][Nn][Dd][Ss]) (%d+)$",
"^(بیصدا) (موقعیت)$",
"^(زمان بیصدا) (%d+) (%d+) (%d+)$",
"^(ساعت بیصدا) (%d+)$",
"^(دقیقه بیصدا) (%d+)$",
"^(ثانیه بیصدا) (%d+)$",
"^[#!/]([Pp][Ll]) (+) ([%w_%.%-]+)$",
"^([Pp][Ll]) (+) ([%w_%.%-]+)$",
"^[#!/]([Pp][Ll]) (-) ([%w_%.%-]+)$",
"^([Pp][Ll]) (-) ([%w_%.%-]+)$",
"^[#!/]([Pp][Ll]) (+) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])$",
"^([Pp][Ll]) (+) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])$",
"^[#!/]([Pp][Ll]) (-) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])$",
"^([Pp][Ll]) (-) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])$",
"^[#!/]([Pp][Ll]) (*)$",
"^([Pp][Ll]) (*)$",
"^(پلاگین) (+) ([%w_%.%-]+)$",
"^(پلاگین) (-) ([%w_%.%-]+)$",
"^(پلاگین) (+) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])$",
"^(پلاگین) (-) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])$",
"^(پلاگین) (*)$",
"^[#!/]([Ss][Uu][Dd][Oo][Ss][Ee][Tt]) (.*)$",
"^([Ss][Uu][Dd][Oo][Ss][Ee][Tt]) (.*)$",
"^(افزودن سودو) (.*)$",
"^[#!/]([Ss][Uu][Dd][Oo][Dd][Ee][Mm]) (.*)$",
"^([Ss][Uu][Dd][Oo][Dd][Ee][Mm]) (.*)$",
"^(حذف سودو)$",
"^(حذف سودو) (.*)$",
"^[#!/]([Aa][Dd][Mm][Ii][Nn][Ss][Ee][Tt]) (.*)$",
"^([Aa][Dd][Mm][Ii][Nn][Ss][Ee][Tt]) (.*)$",
"^(افزودن ادمین)$",
"^(افزودن ادمین) (.*)$",
"^[#!/]([Aa][Dd][Mm][Ii][Nn][Dd][Ee][Mm]) (.*)$",
"^([Aa][Dd][Mm][Ii][Nn][Dd][Ee][Mm]) (.*)$",
"^(حذف ادمین)$",
"^(حذف ادمین) (.*)$",
"^[#!/]([Cc][Hh][Ee][Cc][Kk][Ee][Xx][Pp][Ii][Rr][Ee]) (.*)$",
"^([Cc][Hh][Ee][Cc][Kk][Ee][Xx][Pp][Ii][Rr][Ee]) (.*)$",
"^[#!/]([Cc][Hh][Aa][Rr][Gg][Ee]) (.*) (%d+)$",
"^([Cc][Hh][Aa][Rr][Gg][Ee]) (.*) (%d+)$",
"^[#!/]([Cc][Hh][Aa][Rr][Gg][Ee]) (%d+)$",
"^([Cc][Hh][Aa][Rr][Gg][Ee]) (%d+)$",
"^(اعتبار) (.*)$",
"^(شارژ) (.*) (%d+)$",
"^(شارژ) (%d+)$",
"^[#!/]([Ss][Ee][Tt][Rr][Uu][Ll][Ee][Ss]) (.*)$",
"^([Ss][Ee][Tt][Rr][Uu][Ll][Ee][Ss]) (.*)$",
"^(تنظیم قوانین) (.*)$",
"^[#!/]([Ss][Ee][Tt][Aa][Bb][Oo][Uu][Tt]) (.*)$",
"^([Ss][Ee][Tt][Aa][Bb][Oo][Uu][Tt]) (.*)$",
"^(تنظیم درباره) (.*)$",
"^[#!/]([Ss][Ee][Tt][Nn][Aa][Mm][Ee]) (.*)$",
"^([Ss][Ee][Tt][Nn][Aa][Mm][Ee]) (.*)$",
"^(تنظیم نام) (.*)$",
"^[#!/]([Cc][Ll][Ee][Aa][Nn]) (.*)$",
"^([Cc][Ll][Ee][Aa][Nn]) (.*)$",
"^(پاک کردن) (.*)$",
"^[#!/]([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd]) (%d+)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd]) (%d+)$",
"^[#!/]([Ss][Ee][Tt][Cc][Hh][Aa][Rr]) (%d+)$",
"^([Ss][Ee][Tt][Cc][Hh][Aa][Rr]) (%d+)$",
"^[#!/]([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd][Tt][Ii][Mm][Ee]) (%d+)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd][Tt][Ii][Mm][Ee]) (%d+)$",
"^(تنظیم پیام مکرر) (%d+)$",
"^(حداکثر حروف مجاز) (%d+)$",
"^(تنظیم زمان بررسی) (%d+)$",
"^[#!/]([Rr][Ee][Ss]) (.*)$",
"^([Rr][Ee][Ss]) (.*)$",
"^[#!/]([Ww][Hh][Oo][Ii][Ss]) (%d+)$",
"^([Ww][Hh][Oo][Ii][Ss]) (%d+)$",
"^(کاربری) (.*)$",
"^(شناسه) (%d+)$",
"^[#!/]([Cc][Mm][Dd][Ss]) (.*)$",
"^([Cc][Mm][Dd][Ss]) (.*)$",
"^(دستورات) (.*)$",
"^[#!/]([Ss][Ee][Tt][Ll][Aa][Nn][Gg]) ([Ff][Aa])$",
"^([Ss][Ee][Tt][Ll][Aa][Nn][Gg]) ([Ff][Aa])$",
"^[#!/]([Ss][Ee][Tt][Cc][Mm][Dd]) ([Ff][Aa])$",
"^([Ss][Ee][Tt][Cc][Mm][Dd]) ([Ff][Aa])$",
"^[#!/]([Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^(فیلتر) (.*)$",
"^[#!/]([Uu][Nn][Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Uu][Nn][Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^(حذف فیلتر) (.*)$",
"^[#!/]([Ss][Ee][Tt][Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)$",
"^([Ss][Ee][Tt][Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)$",
"^[#!/]([Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)$",
"^([Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)$",
"^(تنظیم خوشآمد) (.*)$",
"^(خوشآمد) (.*)$",
"^[#!/]([Ww][Ee][Aa][Tt][Hh][Ee][Rr]) (.*)$",
"^([Ww][Ee][Aa][Tt][Hh][Ee][Rr]) (.*)$",
"^[#!/]([Aa][Zz][Aa][Nn]) (.*)$",
"^([Aa][Zz][Aa][Nn]) (.*)$",
"^[#!/]([Cc][Aa][Ll][Cc]) (.*)$",
"^([Cc][Aa][Ll][Cc]) (.*)$",
"^[#!/]([Tt][Rr]) ([^%s]+) (.*)$",
"^([Tt][Rr]) ([^%s]+) (.*)$",
"^[#!/]([Ss][Hh][Oo][Rr][Tt]) (.*)$",
"^([Ss][Hh][Oo][Rr][Tt]) (.*)$",
"^[#!/]([Gg][Ii][Ff]) (.*)$",
"^([Gg][Ii][Ff]) (.*)$",
"^(گیف) (.*)$",
"^[#!/]([Ss][Tt][Ii][Cc][Kk][Ee][Rr]) (.+)$",
"^(اب و هوا) (.*)$",
"^(اذان) (.*)$",
"^(حساب کن) (.*)$",
"^(ترجمه) ([^%s]+) (.*)$",
"^(لینک کوتاه) (.*)$",
"^[#!/]([Dd][Ee][Ll][Aa][Ll][Ll]) (.*)$",
"^([Dd][Ee][Ll][Aa][Ll][Ll]) (.*)$",
"^[#!/]([Rr][Mm][Ss][Gg]) (%d*)$",
"^([Rr][Mm][Ss][Gg]) (%d*)$",
"^(پاکسازی) (%d*)$",
"^(حذف پیام) (.*)$",
"^[#!/]([Ll][Ee][Aa][Vv][Ee]) (.*)$",
"^([Ll][Ee][Aa][Vv][Ee]) (.*)$",
"^(خروج) (.*)$",
"^[#!/]([Ww][Rr][Ii][Tt][Ee]) (.*)$",
"^([Ww][Rr][Ii][Tt][Ee]) (.*)$",
"^(نوشتن) (.*)$",
"^[#!/]([Aa][Uu][Tt][Oo][Ll][Ee][Aa][Vv][Ee]) (.*)$",
"^([Aa][Uu][Tt][Oo][Ll][Ee][Aa][Vv][Ee]) (.*)$",
"^(خروج خودکار) (.*)$",
"^[#!/]([Cc][Rr][Ee][Aa][Tt][Ee][Gg][Rr][Oo][Uu][Pp]) (.*)$",
"^([Cc][Rr][Ee][Aa][Tt][Ee][Gg][Rr][Oo][Uu][Pp]) (.*)$",
"^[#!/]([Cc][Rr][Ee][Aa][Tt][Ee][Ss][Uu][Pp][Ee][Rr]) (.*)$",
"^([Cc][Rr][Ee][Aa][Tt][Ee][Ss][Uu][Pp][Ee][Rr]) (.*)$",
"^(ساخت گروه) (.*)$",
"^(ساخت سوپر گروه) (.*)$",
"^[#!/]([Jj][Oo][Ii][Nn]) (.*)$",
"^([Jj][Oo][Ii][Nn]) (.*)$",
"^[#!/]([Jj][Oo][Ii][Nn][Tt][Oo]) (.*)$",
"^([Jj][Oo][Ii][Nn][Tt][Oo]) (.*)$",
"^(ورود به) (.*)$",
"^(ورود) (.*)$",
"^[#!/]([Ss][Ee][Tt][Bb][Oo][Tt][Nn][Aa][Mm][Ee]) (.*)$",
"^([Ss][Ee][Tt][Bb][Oo][Tt][Nn][Aa][Mm][Ee]) (.*)$",
"^[#!/]([Ss][Ee][Tt][Bb][Oo][Tt][Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee]) (.*)$",
"^([Ss][Ee][Tt][Bb][Oo][Tt][Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee]) (.*)$",
"^[#!/]([Dd][Ee][Ll][Bb][Oo][Tt][Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee]) (.*)$",
"^([Dd][Ee][Ll][Bb][Oo][Tt][Uu][Ss][Ee][Rr][Nn][Aa][Mm][Ee]) (.*)$",
"^(حذف یوزرنیم ربات) (.*)$",
"^(تغییر یوزرنیم ربات) (.*)$",
"^(تغییر نام ربات) (.*)$",
"^[#!/]([Bb][Aa][Nn][Aa][Ll][Ll]) (.*)$",
"^([Bb][Aa][Nn][Aa][Ll][Ll]) (.*)$",
"^[#!/]([Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll]) (.*)$",
"^([Uu][Nn][Bb][Aa][Nn][Aa][Ll][Ll]) (.*)$",
"^[#!/]([Ss][Ii][Ll][Ee][Nn][Tt]) (.*)$",
"^([Ss][Ii][Ll][Ee][Nn][Tt]) (.*)$",
"^[#!/]([Uu][Nn][Ss][Ii][Ll][Ee][Nn][Tt]) (.*)$",
"^([Uu][Nn][Ss][Ii][Ll][Ee][Nn][Tt]) (.*)$",
"^(سوپر بن) (.*)$",
"^(حذف سوپر بن)$",
"^(حذف سوپر بن) (.*)$",
"^(سکوت) (.*)$",
"^(حذف سکوت)$",
"^(حذف سکوت) (.*)$",
"^[#!/]([Kk][Ii][Cc][Kk]) (.*)$",
"^([Kk][Ii][Cc][Kk]) (.*)$",
"^(اخراج) (.*)$",
"^[#!/]([Ii][Nn][Ff][Oo]) (.*)$",
"^([Ii][Nn][Ff][Oo]) (.*)$",
"^(اطلاعات ایدی) (.*)$",
"^[#!/]([Ii][Mm][Pp][Oo][Rr][Tt]) (.*)$",
"^([Ii][Mm][Pp][Oo][Rr][Tt]) (.*)$",
"^[#!/]([Mm][Aa][Rr][Kk][Rr][Ee][Aa][Dd]) (.*)$",
"^([Mm][Aa][Rr][Kk][Rr][Ee][Aa][Dd]) (.*)$",
"^[#!/]([Bb][Cc]) +(.*) (.*)$",
"^([Bb][Cc]) +(.*) (.*)$",
"^[#!/]([Bb][Rr][Oo][Aa][Dd][Cc][Aa][Ss][Tt]) (.*)$",
"^([Bb][Rr][Oo][Aa][Dd][Cc][Aa][Ss][Tt]) (.*)$",
"^[#!/]([Ss][Ee][Nn][Dd][Ff][Ii][Ll][Ee]) (.*) (.*)$",
"^([Ss][Ee][Nn][Dd][Ff][Ii][Ll][Ee]) (.*) (.*)$",
"^[#!/]([Ss][Ee][Nn][Dd][Pp][Ll][Uu][Gg]) (.*)$",
"^([Ss][Ee][Nn][Dd][Pp][Ll][Uu][Gg]) (.*)$",
"^[#!/]([Pp][Ll][Aa][Nn]) ([123]) (.*)$",
"^([Pp][Ll][Aa][Nn]) ([123]) (.*)$",
"^(ارسال فایل) (.*)$",
"^(ارسال به همه) (.*)$",
"^(ارسال پلاگین) (.*)$",
"^(پلن) ([123]) (.*)$",
"^(تیک دوم) (.*)$",
"^(ارسال) +(.*) (.*)$",
"^(ورود لینک (.*)$",
"^[!/#]([Ss][Ee][Tt][Ww][Aa][Rr][Nn]) (%d+)$",
"^([Ss][Ee][Tt][Ww][Aa][Rr][Nn]) (%d+)$",
"^(حداکثر اخطار) (%d+)$",
"^[!/#]([Ss][Ee][Tt][Ee][Nn][Dd]) (.*)$",
"^([Ss][Ee][Tt][Ee][Nn][Dd]) (.*)$",
"^(تنظیم پایان) (.*)$",
"^[!/#]([Oo][Pp][Ee][Nn]) (.*)$",
"^([Oo][Pp][Ee][Nn]) (.*)$",
"^[!/#]([Cc][Hh][Ee][Cc][Kk]) (.*)$",
"^([Cc][Hh][Ee][Cc][Kk]) (.*)$",
"^(چک) (.*)$",
"^(باز گپ) (.*)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$"
},
run=run,
pre_process = pre_process,
}

