local function lic_reply(arg, data)
	if tonumber(data.sender_user_id_) == bot_id then
		if arg.cmd == "active" then
			redis:set("License",true)
		end
		if arg.cmd == "deactive" then
			redis:del("License")
		end
	end
	return
end
local function pre_process(msg)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
local is_channel = msg.to.type == "channel"
local is_chat = msg.to.type == "chat"
local auto_leave = 'auto_leave_bot'
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local muteallchk = 'muteall:'..msg.to.id
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, user) or 1
local max_warn = tonumber(redis:get('max_warn:'..chat) or 3)
if not redis:get('autodeltime') then
	redis:setex('autodeltime', 3600, true)
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
	 run_bash("rm -rf ./data/photos/*")
end
   if is_channel or is_chat then
        local TIME_CHECK = 2
        if data[tostring(chat)] then
          if data[tostring(chat)]['settings']['time_check'] then
            TIME_CHECK = tonumber(data[tostring(chat)]['settings']['time_check'])
          end
        end
    if msg.text then
  if msg.text:match("(.*)") then
    if not data[tostring(msg.to.id)] and not redis:get(auto_leave) and not is_admin(msg) then
  tdcli.sendMessage(msg.to.id, "", 0, "*> این گروه در لیست گروه های ربات ثبت نشده است !*\n`برای خرید ربات و اطلاعات بیشتر به ایدی زیر مراجعه کنید.`\n\n"..MaTaDoRby.."", 0, "md")
  tdcli.changeChatMemberStatus(chat, our_id, 'Left', dl_cb, nil)
      end
   end
end
if redis:get(muteallchk) and not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) then
  if is_channel then
    del_msg(chat, tonumber(msg.id))
	elseif is_chat then
	kick_user(user, chat)
  end
  end
    if data[tostring(chat)] and data[tostring(chat)]['mutes'] then
		mutes = data[tostring(chat)]['mutes']
	else
		return
	end
	if mutes.mute_all then
		mute_all = mutes.mute_all
	else
		mute_all = 'no'
	end
	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = 'no'
	end
   if mutes.mute_photo then
		mute_photo = mutes.mute_photo
	else
		mute_photo = 'no'
	end
	if mutes.mute_sticker then
		mute_sticker = mutes.mute_sticker
	else
		mute_sticker = 'no'
	end
	if mutes.mute_contact then
		mute_contact = mutes.mute_contact
	else
		mute_contact = 'no'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = 'no'
	end
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = 'no'
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = 'no'
	end
	if mutes.mute_keyboard then
		mute_keyboard = mutes.mute_keyboard
	else
		mute_keyboard = 'no'
	end
	if mutes.mute_forward then
		mute_forward = mutes.mute_forward
	else
		mute_forward = 'no'
	end
	if mutes.mute_location then
		mute_location = mutes.mute_location
	else
		mute_location = 'no'
	end
   if mutes.mute_document then
		mute_document = mutes.mute_document
	else
		mute_document = 'no'
	end
	if mutes.mute_voice then
		mute_voice = mutes.mute_voice
	else
		mute_voice = 'no'
	end
	if mutes.mute_audio then
		mute_audio = mutes.mute_audio
	else
		mute_audio = 'no'
	end
	if mutes.mute_video then
		mute_video = mutes.mute_video
	else
		mute_video = 'no'
	end
	if mutes.mute_video_self then
		mute_video_self = mutes.mute_video_self
	else
		mute_video_self = 'no'
	end
	if mutes.mute_tgservice then
		mute_tgservice = mutes.mute_tgservice
	else
		mute_tgservice = 'no'
	end
	if mutes.mute_gif then
		mute_gif_kick = mutes.mute_gif
	else
		mute_gif_kick = 'no'
	end
	if mutes.mute_gif then
		mute_gif_warn = mutes.mute_gif
	else
		mute_gif_warn = 'no'
	end
	if mutes.mute_photo then
		mute_photo_kick = mutes.mute_photo
	else
		mute_photo_kick = 'no'
	end
	if mutes.mute_photo then
		mute_photo_warn = mutes.mute_photo
	else
		mute_photo_warn = 'no'
	end
	if mutes.mute_sticker then
		mute_sticker_kick = mutes.mute_sticker
	else
		mute_sticker_kick = 'no'
	end
	if mutes.mute_sticker then
		mute_sticker_warn = mutes.mute_sticker
	else
		mute_sticker_warn = 'no'
	end
	if mutes.mute_contact then
		mute_contact_kick = mutes.mute_contact
	else
		mute_contact_kick = 'no'
	end
	if mutes.mute_contact then
		mute_contact_warn = mutes.mute_contact
	else
		mute_contact_warn = 'no'
	end
	if mutes.mute_inline then
		mute_inline_kick = mutes.mute_inline
	else
		mute_inline_kick = 'no'
	end
	if mutes.mute_inline then
		mute_inline_warn = mutes.mute_inline
	else
		mute_inline_warn = 'no'
	end
	if mutes.mute_game then
		mute_game_kick = mutes.mute_game
	else
		mute_game_kick = 'no'
	end
	if mutes.mute_game then
		mute_game_warn = mutes.mute_game
	else
		mute_game_warn = 'no'
	end
	if mutes.mute_text then
		mute_text_kick = mutes.mute_text
	else
		mute_text_kick = 'no'
	end
	if mutes.mute_text then
		mute_text_warn = mutes.mute_text
	else
		mute_text_warn = 'no'
	end
	if mutes.mute_keyboard then
		mute_keyboard_kick = mutes.mute_keyboard
	else
		mute_keyboard_kick = 'no'
	end
	if mutes.mute_keyboard then
		mute_keyboard_warn = mutes.mute_keyboard
	else
		mute_keyboard_warn = 'no'
	end
	if mutes.mute_forward then
		mute_forward_kick = mutes.mute_forward
	else
		mute_forward_kick = 'no'
	end
	if mutes.mute_forward then
		mute_forward_warn = mutes.mute_forward
	else
		mute_forward_warn = 'no'
	end
	if mutes.mute_location then
		mute_location_kick = mutes.mute_location
	else
		mute_location_kick = 'no'
	end
	if mutes.mute_location then
		mute_location_warn = mutes.mute_location
	else
		mute_location_warn = 'no'
	end
	if mutes.mute_document then
		mute_document_kick = mutes.mute_document
	else
		mute_document_kick = 'no'
	end
	if mutes.mute_document then
		mute_document_warn = mutes.mute_document
	else
		mute_document_warn = 'no'
	end
	if mutes.mute_voice then
		mute_voice_kick = mutes.mute_voice
	else
		mute_voice_kick = 'no'
	end
	if mutes.mute_voice then
		mute_voice_warn = mutes.mute_voice
	else
		mute_voice_warn = 'no'
	end
	if mutes.mute_audio then
		mute_audio_kick = mutes.mute_audio
	else
		mute_audio_kick = 'no'
	end
	if mutes.mute_audio then
		mute_audio_warn = mutes.mute_audio
	else
		mute_audio_warn = 'no'
	end
	if mutes.mute_video then
		mute_video_kick = mutes.mute_video
	else
		mute_video_kick = 'no'
	end
	if mutes.mute_video then
		mute_video_warn = mutes.mute_video
	else
		mute_video_warn = 'no'
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
		settings = data[tostring(chat)]['settings']
	else
		return
	end
	if settings.lock_link then
		lock_self = settings.lock_self
	else
		lock_self = 'no'
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = 'no'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = 'no'
	end
	if settings.lock_self then
		lock_self = settings.lock_self
	else
		lock_self = 'no'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = 'no'
	end
	if settings.lock_username then
		lock_username = settings.lock_username
	else
		lock_username = 'no'
	end
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = 'no'
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = 'no'
	end
	if settings.lock_english then
		lock_english = settings.lock_english
	else
		lock_english = 'no'
	end
	if settings.lock_mention then
		lock_mention = settings.lock_mention
	else
		lock_mention = 'no'
	end
	if settings.lock_edit then
		lock_edit = settings.lock_edit
	else
		lock_edit = 'no'
	end
	if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = 'no'
	end
	if settings.lock_flood then
		lock_flood = settings.lock_flood
	else
		lock_flood = 'no'
	end
	if settings.lock_markdown then
		lock_markdown = settings.lock_markdown
	else
		lock_markdown = 'no'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = 'no'
	end
	if settings.lock_link then
		lock_link_warn = settings.lock_link
	else
		lock_link_warn = 'no'
	end
	if settings.lock_link then
		lock_link_kick = settings.lock_link
	else
		lock_link_kick = 'no'
	end
	if settings.lock_tag then
		lock_tag_kick = settings.lock_tag
	else
		lock_tag_kick = 'no'
	end
	if settings.lock_tag then
		lock_tag_warn = settings.lock_tag
	else
		lock_tag_warn = 'no'
	end
	if settings.lock_username then
		lock_username_kick = settings.lock_username
	else
		lock_username_kick = 'no'
	end
	if settings.lock_username then
		lock_username_warn = settings.lock_username
	else
		lock_username_warn = 'no'
	end
	if settings.lock_arabic then
		lock_arabic_kick = settings.lock_arabic
	else
		lock_arabic_kick = 'no'
	end
	if settings.lock_arabic then
		lock_arabic_warn = settings.lock_arabic
	else
		lock_arabic_warn = 'no'
	end
    if settings.lock_english then
		lock_english_kick = settings.lock_english
	else
		lock_english_kick = 'no'
	end	
    if settings.lock_english then
		lock_english_warn = settings.lock_english
	else
		lock_english_warn = 'no'
	end		
	if settings.lock_mention then
		lock_mention_kick = settings.lock_mention
	else
		lock_mention_kick = 'no'
	end
	if settings.lock_mention then
		lock_mention_warn = settings.lock_mention
	else
		lock_mention_warn = 'no'
	end
	if settings.lock_edit then
		lock_edit_kick = settings.lock_edit
	else
		lock_edit_kick = 'no'
	end
	if settings.lock_edit then
		lock_edit_warn = settings.lock_edit
	else
		lock_edit_warn = 'no'
	end
	if settings.lock_markdown then
		lock_markdown_kick = settings.lock_markdown
	else
		lock_markdown_kick = 'no'
	end
	if settings.lock_markdown then
		lock_markdown_warn = settings.lock_markdown
	else
		lock_markdown_warn = 'no'
	end
	if settings.lock_webpage then
		lock_webpage_kick = settings.lock_webpage
	else
		lock_webpage_kick = 'no'
	end
	if settings.lock_webpage then
		lock_webpage_warn = settings.lock_webpage
	else
		lock_webpage_warn = 'no'
	end
  if msg.adduser or msg.joinuser or msg.deluser then
  if mute_tgservice == "yes" then
del_msg(chat, tonumber(msg.id))
  end
end
if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and msg.from.id ~= our_id then
	if msg.adduser or msg.joinuser then
		if lock_join == 'yes' then
			function join_kick(arg, data)
				kick_user(data.id_, msg.to.id)
			end
			if msg.adduser then
				tdcli.getUser(msg.adduser, join_kick, nil)
			elseif msg.joinuser then
				tdcli.getUser(msg.joinuser, join_kick, nil)
			end
		end
	end
end
   if msg.pinned and is_channel then
  if lock_pin == 'yes' then
     if is_owner(msg) then
      return
     end
     if tonumber(msg.from.id) == our_id then
      return
     end
    local pin_msg = data[tostring(chat)]['pin']
      if pin_msg then
  tdcli.pinChannelMessage(msg.to.id, pin_msg, 1)
       elseif not pin_msg then
   tdcli.unpinChannelMessage(msg.to.id)
          end
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '<b>User ID :</b> <code>'..msg.from.id..'</code>\n<b>Username :</b> '..('@'..msg.from.username or '<i>No Username</i>')..'\n<i>شما اجازه دسترسی به سنجاق پیام را ندارید، به همین دلیل پیام قبلی مجدد سنجاق میگردد</i>', 0, "html")
     elseif not lang then
    tdcli.sendMessage(msg.to.id, msg.id, 0, '<b>User ID :</b> <code>'..msg.from.id..'</code>\n<b>Username :</b> '..('@'..msg.from.username or '<i>No Username</i>')..'\n<i>You Have Not Permission To Pin Message, Last Message Has Been Pinned Again</i>', 0, "html")
          end
      end
  end
if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and msg.from.id ~= our_id then
------------------------------------
  if msg.edited and lock_edit == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
    end
  end
if msg.edited and lock_edit_ban == 'ban' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `ویرایش مسدود`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه مسدود شد 🚷⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Edit Ban`\n\n*Uѕєя ɗυє тσ ρσѕт мєɗια, υηαυтнσяιzєɗ fяσм тнιѕ gяσυρ ωєяє вƖσcкєɗ 🚷⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
end
  elseif is_chat then
kick_user(user, chat)
end
end
if msg.edited and lock_edit_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `ویرایش اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Edit Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
    end
  end 
if msg.edited and lock_edit_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `ویرایش اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Edit Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `ویرایش اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Edit Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
end
end
------------------------------------
if msg.forward_info_ and mute_forward == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
    end
end
if msg.forward_info_ and mute_forward_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `فوروارد اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Forward Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
    end
  end 
if msg.forward_info_ and mute_forward_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فوروارد اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Forward Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فوروارد اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Forward Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.photo_ and mute_photo == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.photo_ and mute_photo_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `عکس اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Photo Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.photo_ and mute_photo_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `عکس اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Photo Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `عکس اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Photo Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.video_ and mute_video == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.video_ and mute_video_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `فیلم اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Video Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.video_ and mute_video_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فیلم اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Video Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فیلم اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Video Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.unsupported_ and mute_video_self == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end

if msg.unsupported_ and mute_video_self == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `فیلم سلفی اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Self Video Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.unsupported_ and mute_video_self == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فیلم سلفی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Self Video Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فیلم سلفی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Self Video Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.document_ and mute_document == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.document_ and mute_document_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `فایل اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Document Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.document_ and mute_document_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فایل اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Document Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فایل اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Document Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
end
end
------------------------------------
if msg.sticker_ and mute_sticker == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.sticker_ and mute_sticker_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `استیکر اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Sticker Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.sticker_ and mute_sticker_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `استیکر اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Sticker Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `استیکر اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Sticker Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.animation_ and mute_gif == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.animation_ and mute_gif_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `گیف اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Gif Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.animation_ and mute_gif_warn == 'warn' then
if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `گیف اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Gif Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `گیف اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Gif Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.contact_ and mute_contact == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.contact_ and mute_contact_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Contact Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.contact_ and mute_contact_warn == 'warn' then
if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Contact Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Contact Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.location_ and mute_location == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.location_ and mute_location_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `مکان اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Location Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.location_ and mute_location_warn == 'warn' then
if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `مکان اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Location Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `مکان اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Location Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.voice_ and mute_voice == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.voice_ and mute_voice_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `ویس اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Voice Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.voice_ and mute_voice_warn == 'warn' then
if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `ویس اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Voice Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `ویس اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Voice Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.content_ and mute_keyboard == 'yes' then
  if msg.reply_markup_ and  msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
   end
end
if msg.content_ and mute_keyboard_kick == 'kick' then
  if msg.reply_markup_ and  msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `کیبورد اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Keyboard Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
      end
   end
end
if msg.content_ and mute_keyboard_warn == 'warn' then
 if msg.reply_markup_ and  msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" then
if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `کیبورد اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Keyboard Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `کیبورد اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Keyboard Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
  end
end
------------------------------------
if tonumber(msg.via_bot_user_id_) ~= 0 and mute_inline == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and mute_inline_ban == 'ban' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `دکمه شیشه ای مسدود`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه مسدود شد 🚷⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Inline Ban`\n\n*Uѕєя ɗυє тσ ρσѕт мєɗια, υηαυтнσяιzєɗ fяσм тнιѕ gяσυρ ωєяє вƖσcкєɗ 🚷⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
end
  elseif is_chat then
kick_user(user, chat)
   end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and mute_inline_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `دکمه شیشه ای اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Inline Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and mute_inline_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `دکمه شیشه ای اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Inline Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `دکمه شیشه ای اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Inline Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.game_ and mute_game == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.game_ and mute_game_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `بازی اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Game Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.game_ and mute_game_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `بازی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Game Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `بازی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Game Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.audio_ and mute_audio == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.audio_ and mute_audio_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
  if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `آهنگ اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Audio Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.audio_ and mute_audio_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `آهنگ اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Audio Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `آهنگ اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Audio Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if msg.media.caption then
local webpage_caption = msg.media.caption:match(".[Ii][Rr]") or msg.media.caption:match(".[Cc][Oo][Mm]") or msg.media.caption:match("//[Ww][Ww][Ww].") or msg.media.caption:match("[Ww][Ww][Ww].")
if webpage_caption and lock_webpage == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_caption
and lock_link == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_caption and lock_link_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `لینک اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Link Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_caption and lock_link_warn == "warn" then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `لینک اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Link Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `لینک اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Link Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
local tag_caption = msg.media.caption:match("#")
if tag_caption and lock_tag == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local tag_caption = msg.media.caption:match("#")
if tag_caption and lock_tag_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `تگ اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Tag Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local tag_caption = msg.media.caption:match("#")
if tag_caption and lock_tag_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `تگ اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Tag Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `تگ اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Tag Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
local username_caption = msg.media.caption:match("@")
if username_caption and lock_username == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local username_caption = msg.media.caption:match("@")
if username_caption and lock_username_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `نام کاربری اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Username Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local username_caption = msg.media.caption:match("@")
if username_caption and lock_username_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `نام کاربری اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Username Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `نام کاربری اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Username Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
local english_caption = msg.media.caption:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]")
if english_caption and lock_english == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local english_caption = msg.media.caption:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]")
if english_caption and lock_english_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `انگلیسی اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `English Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local english_caption = msg.media.caption:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]")
if english_caption and lock_english_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `انگلیسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `English Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `انگلیسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `English Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if is_filter(msg, msg.media.caption) then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
 end
------------------------------------
local arabic_caption = msg.media.caption:match("[\216-\219][\128-\191]")
if arabic_caption and lock_arabic == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
end
local arabic_caption = msg.media.caption:match("[\216-\219][\128-\191]")
if arabic_caption and lock_arabic_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `فارسی اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Arabic Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
      end
end
local arabic_caption = msg.media.caption:match("[\216-\219][\128-\191]")
if arabic_caption and lock_arabic_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فارسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Arabic Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فارسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Arabic Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
end
if msg.text then
			local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
        local max_chars = 40
        if data[tostring(msg.to.id)] then
          if data[tostring(msg.to.id)]['settings']['set_char'] then
            max_chars = tonumber(data[tostring(msg.to.id)]['settings']['set_char'])
          end
        end
			 local _nl, real_digits = string.gsub(msg.text, '%d', '')
			local max_real_digits = tonumber(max_chars) * 50
			local max_len = tonumber(max_chars) * 51
			if lock_spam == 'yes' then
			if string.len(msg.text) > max_len or ctrl_chars > max_chars or real_digits > max_real_digits then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
   end
end
------------------------------------
local webpage_msg = msg.text:match(".[Ii][Rr]") or msg.text:match(".[Cc][Oo][Mm]") or msg.text:match("//[Ww][Ww][Ww].") or msg.text:match("[Ww][Ww][Ww].")
if webpage_msg and lock_webpage == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_msg and lock_link == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_msg and lock_link_kick == "kick" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `لینک اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Link Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
  sleep(1)
  channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_msg and lock_link_warn == "warn" then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `لینک اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Link Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `لینک اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Link Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
local tag_msg = msg.text:match("#")
if tag_msg and lock_tag == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local tag_msg = msg.text:match("#")
if tag_msg and lock_tag_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `تگ اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Tag Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
  sleep(1)
  channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local tag_msg = msg.text:match("#")
if tag_msg and lock_tag_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `تگ اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Tag Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `تگ اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Tag Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
local username_msg = msg.text:match("@")
if username_msg and lock_username == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local username_msg = msg.text:match("@")
if username_msg and lock_username_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `نام کاربری اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Username Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local username_msg = msg.text:match("@")
if username_msg and lock_username_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `نام کاربری اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Username Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `نام کاربری اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Username Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
local english_msg = msg.text:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]") 
if english_msg and lock_english == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local english_msg = msg.text:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]") 
if english_msg and lock_english_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `انگلیسی اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `English Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local english_msg = msg.text:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]") 
if english_msg and lock_english_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `انگلیسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `English Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `انگلیسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `English Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if is_filter(msg, msg.text) then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
    end
------------------------------------
local arabic_msg = msg.text:match("[\216-\219][\128-\191]")
if arabic_msg and lock_arabic == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local arabic_msg = msg.text:match("[\216-\219][\128-\191]")
if arabic_msg and lock_arabic_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `فارسی اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Arabic Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
end
local arabic_msg = msg.text:match("[\216-\219][\128-\191]")
if arabic_msg and lock_arabic_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فارسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Arabic Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فارسی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Arabic Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
if mute_all == "yes" then 
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
------------------------------------
if msg.text:match("(.*)") and mute_text == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
     end
   end
if msg.text:match("(.*)") and mute_text_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `متن اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Text Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
     end
end
if msg.text:match("(.*)") and mute_text_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `متن اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Text Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `متن اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Text Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
------------------------------------
end
if msg.content_.entities_ and msg.content_.entities_[0] then
if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
   if lock_mention == 'yes' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
  end
 end
 if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
   if lock_mention_kick == 'kick' then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `فراخوانی اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Mention Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
  end
 end
 if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
   if lock_mention_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فراخوانی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Mention Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `فراخوانی اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Mention Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
end
------------------------------------
 if msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then
   if lock_webpage_kick == 'kick' then
if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `وب اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Webpage Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
  end
 end
 if msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then
   if lock_webpage_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `وب اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Webpage Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `وب اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Webpage Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
end
------------------------------------
if msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic" then
   if lock_markdown == 'yes' then
if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
  end
 end
 if msg.content_.entities_[0].ID == "MessageUnsupported" then
   if lock_self == 'yes' then
if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
  end
 end
 if msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic" then
   if lock_markdown_kick == 'kick' then
if is_channel then
 del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
 if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *وضعیت :* `اخراج`\n\n*کاربر به دلیل ارسال رسانه های غیر مجاز از این گروه اخراج شد 🚫⚠️*\n\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 ایدی  :* `'..msg.from.id..'`\n*👤 نام :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 else
tdcli.sendMessage(msg.to.id, msg.id, 0, '♨️ *Ƭнє ѕιтєυαтιση :* `Kick`\n\n*Uѕєя Ɓєcαυѕє σf тнє Sєηɗ, мєɗια, ηση-αυтнσяιzєɗ fяσм тнє gяσυρ, ωαѕ єxρєƖƖєɗ 🚫⚠️*\n\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @'..check_markdown(msg.from.username or '404NoTUserName')..'\n*🔖 Uѕєя :* `'..msg.from.id..'`\n*👤 ηαмє :* `'..check_markdown(msg.from.first_name or '404NoTName')..'`', 0, "md")
 end
 sleep(1)
channel_unblock(msg.chat_id_, msg.sender_user_id_)
  elseif is_chat then
kick_user(user, chat)
   end
  end
 end
 if msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic" then
   if lock_markdown_warn == 'warn' then
 if is_channel then
if tonumber(warnhash) == tonumber(max_warn) then
if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n *به دلیل دریافت اخطار بیش از حد اخراج شد*\n_تعداد اخطار ها :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n `Hαѕ Beeɴ` *Kιcĸed* `Becαυѕe Mαх Wαrɴιɴɢ`\n_Nυмвer oғ wαrɴ :_ *[*`"..warnhash.."`*/*`"..max_warn.."`*]*", 0, "md")
end
del_msg(chat, tonumber(msg.id))
kick_user(user, chat)
redis:hdel(hashwarn, user, '0')
else
redis:hset(hashwarn, user, tonumber(warnhash) + 1)
del_msg(chat, tonumber(msg.id))
   if lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *وضعیت :* `اخطار`\n`اطلاعات کاربر :`\n*🆔 نام کاربری :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 آیدی :* `"..msg.from.id.."`\n*👤 نام :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_شما یک اخطار دریافت کردید_ *[*`"..warnhash.."`*]* *از* *[*`"..max_warn.."`*]* _تعداد اخطار های شما_", 0, "md")
else
tdcli.sendMessage(msg.to.id, msg.id, 0, "♨️ *Ƭнє ѕιтєυαтιση :* `Warn`\n`UѕєяIηfσ :`\n*🆔 Uѕєяηαмє :* @"..check_markdown(msg.from.username or '404NoTUserName').."\n*🔖 Uѕєя :* `"..msg.from.id.."`\n*👤 ηαмє :* `"..check_markdown(msg.from.first_name or '404NoTName').."`\n\n_Yoυ've_ *[*`"..warnhash.."`*]* *oғ* *[*`"..max_warn.."`*]* _Wαrɴѕ!_", 0, "md")
end
end
  end
end
end
------------------------------------
 end
if msg.to.type ~= 'pv' then
  if lock_flood == "yes" and not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and not msg.adduser and msg.from.id ~= our_id then
    local hash = 'user:'..user..':msgs'
    local msgs = tonumber(redis:get(hash) or 0)
        local NUM_MSG_MAX = 5
        if data[tostring(chat)] then
          if data[tostring(chat)]['settings']['num_msg_max'] then
            NUM_MSG_MAX = tonumber(data[tostring(chat)]['settings']['num_msg_max'])
          end
        end
    if msgs > NUM_MSG_MAX then
   if msg.from.username then
      user_name = "@"..msg.from.username
         else
      user_name = msg.from.first_name
     end
if redis:get('sender:'..user..':flood') then
return
else
   del_msg(chat, msg.id)
    kick_user(user, chat)
   if not lang then
  tdcli.sendMessage(chat, msg.id, 0, "*Uѕєя :*\n["..user_name.."] `[ "..user.." ]`\n`Hαѕ Ɓєєη` *Ƙιcкє∂* `Ɓєcαυѕє Oƒ` *Ƒℓσσ∂ιηg* ⚠️🚫", 0, "md")
   elseif lang then
  tdcli.sendMessage(chat, msg.id, 0, "*کاربر :*\n["..user_name.."] `[ "..user.." ]`\n`به دلیل ارسال پیام های مکرر اخراج شد` ⚠️🚫", 0, "md")
    end
redis:setex('sender:'..user..':flood', 30, true)
      end
    end
    redis:setex(hash, TIME_CHECK, msgs+1)
               end
           end
      end
   end
end


return {
	patterns = {
	},
	pre_process = pre_process
}
