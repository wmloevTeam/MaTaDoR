--Begin Core.lua By #MaTaDoRTeaM
local SUDO = sudo_id
local function getindex(t,id) 
	for i,v in pairs(t) do 
		if v == id then 
			return i 
		end 
	end 
	return nil 
end 

local function reload_plugins( ) 
	plugins = {} 
	load_plugins() 
end

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

local function list_all_plugins(only_enabled)
  local tmp = '\n\n[MaTaDoRTeaM](Telegram.Me/MaTaDoRTeaM)'
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    local status = '*|✖️|>*'
    nsum = nsum+1
    nact = 0
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '*|✔|>*'
      end
      nact = nact+1
    end
    if not only_enabled or status == '*|✔|>*'then
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'.'..status..' '..check_markdown(v)..' \n'
    end
  end
  local text = text..'\n\n'..nsum..' *📂plugins installed*\n\n'..nact..' _✔️plugins enabled_\n\n'..nsum-nact..' _❌plugins disabled_'..tmp
  return text
end

local function list_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    local status = '*|✖️|>*'
    nsum = nsum+1
    nact = 0
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '*|✔|>*'
      end
      nact = nact+1
    end
    if not only_enabled or status == '*|✔|>*'then
      v = string.match (v, "(.*)%.lua")
    end
  end
  local text = text.."\n_🔃All Plugins Reloaded_\n\n"..nact.." *✔️Plugins Enabled*\n"..nsum.." *📂Plugins Installed*\n\n[MaTaDoRTeaM](Telegram.Me/MaTaDoRTeaM)"
return text
end

local function reload_plugins( )
   bot_run()
  plugins = {}
  load_plugins()
  return list_plugins(true)
end


local function enable_plugin( plugin_name )
  print('checking if '..plugin_name..' exists')
  if plugin_enabled(plugin_name) then
    return ''..plugin_name..' _is enabled_'
  end
  if plugin_exists(plugin_name) then
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    return reload_plugins( )
  else
    return ''..plugin_name..' _does not exists_'
  end
end

local function disable_plugin( name, chat )
  if not plugin_exists(name) then
    return ' '..name..' _does not exists_'
  end
  local k = plugin_enabled(name)
  if not k then
    return ' '..name..' _not enabled_'
  end
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true)    
end

local function disable_plugin_on_chat(receiver, plugin)
  if not plugin_exists(plugin) then
    return "_Plugin doesn't exists_"
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
  return ' '..plugin..' _disabled on this chat_'
end

local function reenable_plugin_on_chat(receiver, plugin)
  if not _config.disabled_plugin_on_chat then
    return 'There aren\'t any disabled plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There aren\'t any disabled plugins for this chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
    return '_This plugin is not disabled_'
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  return ' '..plugin..' is enabled again'
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


local function sudolist(msg)
	local sudo_users = _config.sudo_users
	local text = "Sudo Users :\n"
	for i=1,#sudo_users do
		text = text..i.." - "..sudo_users[i].."\n"
	end
	return text
end

function moresetting(msg, data, GP_id)
local settings = data[tostring(GP_id)]["settings"]
 text = '*به تنظیمات پیام های مکرر خوش آمدید* 🤖'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '✦ حداکثر پیام های مکرر ♻️', callback_data = 'MaTaDoRTeaM'}
		},
		{
			{text = "➕", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="MaTaDoRTeaM"},
			{text = "➖", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '✦ حداکثر حروف مجاز 📜', callback_data = 'MaTaDoRTeaM'}
		},
		{
			{text = "➕", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="MaTaDoRTeaM"},
			{text = "➖", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '✦ زمان بررسی پیام های مکرر 🎴', callback_data = 'MaTaDoRTeaM'}
		},
		{
			{text = "➕", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="MaTaDoRTeaM"},
			{text = "➖", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '✦ بازگشت 🔙', callback_data = '/mutelist:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end
function options(msg, GP_id)
text = "به پنل شیشه‌ای مدیریتی گروه خوش آمدید 🌹\nبرای مدیریت گروه میتونید از دکمه های زیر استفاده کنید...\n\nبرای حمایت از ما لطفا به ما رای دهید ❤️"
    keyboard = {}
	keyboard.inline_keyboard = {
	    {
            {text = "❤️ "..tostring(redis:get("MaTaDoRLikes")), callback_data="/like:"..GP_id},
            {text = "💔 "..tostring(redis:get("MaTaDoRDisLikes")), callback_data="/dislike:"..GP_id}
        },
        {
			{text = "❃ تنظیمات ⚙️", callback_data="/settings:"..GP_id}
		},
		{
			{text = '❃ اطلاعات گروه و مدیریت لیست‌ها 🔬', callback_data = '/more:'..GP_id}
		},
		{
			{text = '❃ نرخ ربات 💰', callback_data = '/nerkh:'..GP_id}
		},
		{
			{text= '❃ بستن پنل شیشه‌ای 🔚' ,callback_data = '/exit:'..GP_id}
		}					
	}
    edit_inline(msg.message_id, text, keyboard)
end

function setting(msg, data, GP_id)
	if data[tostring(GP_id)] and data[tostring(GP_id)]['mutes'] then
		mutes = data[tostring(GP_id)]['mutes']
	else
		return
	end
	if data[tostring(GP_id)] and data[tostring(GP_id)]['settings'] then
		settings = data[tostring(GP_id)]['settings']
	else
		return
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = 'no'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = 'no'
	end
	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = 'no'
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
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = 'no'
	end
-- شرط ولکام
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
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = 'no'
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
 text = '*به تنظیمات قفلی گروه خوش آمدید* 🤖'
 if(lock_link=="yes")then lock_link_text = "فعال✅"elseif(lock_link=="kick")then lock_link_text = "حالت اخراج📛"elseif(lock_link=="no")then lock_link_text = "غیرفعال❌"elseif(lock_link=="warn")then lock_link_text = "حالت اخطار🚷"end
 if(lock_edit=="yes")then lock_edit_text = "فعال✅"elseif(lock_edit=="kick")then lock_edit_text = "حالت اخراج📛"elseif(lock_edit=="no")then lock_edit_text = "غیرفعال❌"elseif(lock_edit=="warn")then lock_edit_text = "حالت اخطار🚷"end
 if(lock_tag=="yes")then lock_tag_text = "فعال✅"elseif(lock_tag=="kick")then lock_tag_text = "حالت اخراج📛"elseif(lock_tag=="no")then lock_tag_text = "غیرفعال❌"elseif(lock_tag=="warn")then lock_tag_text = "حالت اخطار🚷"end
 if(lock_username=="yes")then lock_username_text = "فعال✅"elseif(lock_username=="kick")then lock_username_text = "حالت اخراج📛"elseif(lock_username=="no")then lock_username_text = "غیرفعال❌"elseif(lock_username=="warn")then lock_username_text = "حالت اخطار🚷"end
 if(lock_mention=="yes")then lock_mention_text = "فعال✅"elseif(lock_mention=="kick")then lock_mention_text = "حالت اخراج📛"elseif(lock_mention=="no")then lock_mention_text = "غیرفعال❌"elseif(lock_mention=="warn")then lock_mention_text = "حالت اخطار🚷"end
 if(lock_arabic=="yes")then lock_arabic_text = "فعال✅"elseif(lock_arabic=="kick")then lock_arabic_text = "حالت اخراج📛"elseif(lock_arabic=="no")then lock_arabic_text = "غیرفعال❌"elseif(lock_arabic=="warn")then lock_arabic_text = "حالت اخطار🚷"end
 if(lock_english=="yes")then lock_english_text = "فعال✅"elseif(lock_english=="kick")then lock_english_text = "حالت اخراج📛"elseif(lock_english=="no")then lock_english_text = "غیرفعال❌"elseif(lock_english=="warn")then lock_english_text = "حالت اخطار🚷"end
 if(lock_webpage=="yes")then lock_webpage_text = "فعال✅"elseif(lock_webpage=="kick")then lock_webpage_text = "حالت اخراج📛"elseif(lock_webpage=="no")then lock_webpage_text = "غیرفعال❌"elseif(lock_webpage=="warn")then lock_webpage_text = "حالت اخطار🚷"end
 if(lock_markdown=="yes")then lock_markdown_text = "فعال✅"elseif(lock_markdown=="kick")then lock_markdown_text = "حالت اخراج📛"elseif(lock_markdown=="no")then lock_markdown_text = "غیرفعال❌"elseif(lock_markdown=="warn")then lock_markdown_text = "حالت اخطار🚷"end
 if(mute_gif=="yes")then mute_gif_text = "فعال✅"elseif(mute_gif=="kick")then mute_gif_text = "حالت اخراج📛"elseif(mute_gif=="no")then mute_gif_text = "غیرفعال❌"elseif(mute_gif=="warn")then mute_gif_text = "حالت اخطار🚷"end
 if(mute_text=="yes")then mute_text_text = "فعال✅"elseif(mute_text=="kick")then mute_text_text = "حالت اخراج📛"elseif(mute_text=="no")then mute_text_text = "غیرفعال❌"elseif(mute_text=="warn")then mute_text_text = "حالت اخطار🚷"end  
 if(mute_inline=="yes")then mute_inline_text = "فعال✅"elseif(mute_inline=="kick")then mute_inline_text = "حالت اخراج📛"elseif(mute_inline=="no")then mute_inline_text = "غیرفعال❌"elseif(mute_inline=="warn")then mute_inline_text = "حالت اخطار🚷"end 
 if(mute_game=="yes")then mute_game_text = "فعال✅"elseif(mute_game=="kick")then mute_game_text = "حالت اخراج📛"elseif(mute_game=="no")then mute_game_text = "غیرفعال❌"elseif(mute_game=="warn")then mute_game_text = "حالت اخطار🚷"end 
 if(mute_photo=="yes")then mute_photo_text = "فعال✅"elseif(mute_photo=="kick")then mute_photo_text = "حالت اخراج📛"elseif(mute_photo=="no")then mute_photo_text = "غیرفعال❌"elseif(mute_photo=="warn")then mute_photo_text = "حالت اخطار🚷"end
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "✦ قفل ویرایش ✏️: "..lock_edit_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/lockeditd:"..GP_id},
		{text = "ϟ اخطار", callback_data="/lockeditw:"..GP_id},
		{text = "ϟ اخراج", callback_data="/lockeditk:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/lockedito:"..GP_id}
		},
		{
			{text = "✦ قفل لینک 📎: "..lock_link_text.."", callback_data='MaTaDoRTeaM'}
		},
		{
		{text = "ϟ فعال", callback_data="/locklinkd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/locklinkk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/locklinkw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/locklinko:"..GP_id}
		},
		{
			{text = "✦ قفل تگ #️⃣ : "..lock_tag_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/locktagsd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/locktagsk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/locktagsw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/locktagso:"..GP_id}
		},
		{
			{text = "✦ قفل نام کاربری 🆔:"..lock_username_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/lockusernamed:"..GP_id},
		{text = "ϟ اخراج", callback_data="/lockusernamek:"..GP_id},
		{text = "ϟ اخطار", callback_data="/lockusernamew:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/lockusernameo:"..GP_id}
		},
		{
			{text = "✦ قفل فراخوانی ⚠️: "..lock_mention_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/lockmentiond:"..GP_id},
		{text = "ϟ اخراج", callback_data="/lockmentionk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/lockmentionw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/lockmentiono:"..GP_id}
		},
		{
			{text = "✦ قفل عربی 🔠: "..lock_arabic_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/lockarabicd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/lockarabick:"..GP_id},
		{text = "ϟ اخطار", callback_data="/lockarabicw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/lockarabico:"..GP_id}
		},
		{
			{text = "✦ قفل انگلیسی 🔠: "..lock_english_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/lockenglishd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/lockenglishk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/lockenglishw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/lockenglisho:"..GP_id}
		},
		{
			{text = "✦ قفل صفحات وب 🌐: "..lock_webpage_text.."", callback_data='MaTaDoRTeaM'}, 
		},
		{
		{text = "ϟ فعال", callback_data="/lockwebpaged:"..GP_id},
		{text = "ϟ اخراج", callback_data="/lockwebpagek:"..GP_id},
		{text = "ϟ اخطار", callback_data="/lockwebpagew:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/lockwebpageo:"..GP_id}
		},
		{
			{text = "✦ قفل فونت 💱: "..lock_markdown_text.."", callback_data='MaTaDoRTeaM'}, 
		},
		{
		{text = "ϟ فعال", callback_data="/lockmarkdownd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/lockmarkdownk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/lockmarkdownw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/lockmarkdowno:"..GP_id}
		},
		{
			{text = "✦ قفل تصاویر متحرک 🎇: "..mute_gif_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/mutegifd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutegifk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutegifw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutegifo:"..GP_id}
		},
		{
			{text = "✦ قفل متن 🔤: "..mute_text_text.."", callback_data='MaTaDoRTeaM'}  
		},
		{
		{text = "ϟ فعال", callback_data="/mutetextd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutetextk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutetextw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutetexto:"..GP_id}
		},
		{
			{text = "✦ قفل اینلاین ✨: "..mute_inline_text.."", callback_data='MaTaDoRTeaM'}, 
		},
		{
		{text = "ϟ فعال", callback_data="/muteinlined:"..GP_id},
		{text = "ϟ اخراج", callback_data="/muteinlinek:"..GP_id},
		{text = "ϟ اخطار", callback_data="/muteinlinew:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/muteinlineo:"..GP_id}
		},
		{
			{text = "✦ قفل بازی 🎮: "..mute_game_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/mutegamed:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutegamek:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutegamew:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutegameo:"..GP_id}
		},
		{
			{text = "✦ قفل عکس 🌄: "..mute_photo_text.."", callback_data='MaTaDoRTeaM'}  
		},
		{
		{text = "ϟ فعال", callback_data="/mutephotod:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutephotok:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutephotow:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutephotoo:"..GP_id}
		},
-- جای قبلی گزینه خوش آمد گویی
		{
			{text = '✦ تنظیمات بیشتر ♨️', callback_data = '/mutelist:'..GP_id}
		},
		{
			{text = '✦ بازگشت 🔙', callback_data = '/option:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end

function mutelists(msg, data, GP_id) 
    if data[tostring(GP_id)] and data[tostring(GP_id)]['mutes'] then
		mutes = data[tostring(GP_id)]['mutes']
	else
		return
	end
	if data[tostring(GP_id)] and data[tostring(GP_id)]['settings'] then
		settings = data[tostring(GP_id)]['settings']
	else
		return
	end
	if settings.welcome then
		group_welcone = settings.welcome
	else
		group_welcone = 'no'
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = 'no'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = 'no'
	end
	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = 'no'
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
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = 'no'
	end
	if settings.welcome then
		group_welcone = settings.welcome
	else
		group_welcone = 'no'
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
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = 'no'
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
	 text = '*به تنظیمات قفلی(2) گروه خوش آمدید* 🤖'
    if(mute_video=="yes")then mute_video_text = "فعال✅"elseif(mute_video=="kick")then mute_video_text = "حالت اخراج📛"elseif(mute_video=="no")then mute_video_text = "غیرفعال❌"elseif(mute_video=="warn")then mute_video_text = "حالت اخطار🚷"end
    if(mute_video_self=="yes")then mute_video_self_text = "فعال✅"elseif(mute_video_self=="kick")then mute_video_self_text = "حالت اخراج📛"elseif(mute_video_self=="no")then mute_video_self_text = "غیرفعال❌"elseif(mute_video_self=="warn")then mute_video_self_text = "حالت اخطار🚷"end
	if(mute_audio=="yes")then mute_audio_text = "فعال✅"elseif(mute_audio=="kick")then mute_audio_text = "حالت اخراج📛"elseif(mute_audio=="no")then mute_audio_text = "غیرفعال❌"elseif(mute_audio=="warn")then mute_audio_text = "حالت اخطار🚷"end
	if(mute_voice=="yes")then mute_voice_text = "فعال✅"elseif(mute_voice=="kick")then mute_voice_text = "حالت اخراج📛"elseif(mute_voice=="no")then mute_voice_text = "غیرفعال❌"elseif(mute_voice=="warn")then mute_voice_text = "حالت اخطار🚷"end
	if(mute_sticker=="yes")then mute_sticker_text = "فعال✅"elseif(mute_sticker=="kick")then mute_sticker_text = "حالت اخراج📛"elseif(mute_sticker=="no")then mute_sticker_text = "غیرفعال❌"elseif(mute_sticker=="warn")then mute_sticker_text = "حالت اخطار🚷"end
	if(mute_contact=="yes")then mute_contact_text = "فعال✅"elseif(mute_contact=="kick")then mute_contact_text = "حالت اخراج📛"elseif(mute_contact=="no")then mute_contact_text = "غیرفعال❌"elseif(mute_contact=="warn")then mute_contact_text = "حالت اخطار🚷"end
	if(mute_forward=="yes")then mute_forward_text = "فعال✅"elseif(mute_forward=="kick")then mute_forward_text = "حالت اخراج📛"elseif(mute_forward=="no")then mute_forward_text = "غیرفعال❌"elseif(mute_forward=="warn")then mute_forward_text = "حالت اخطار🚷"end
	if(mute_location=="yes")then mute_location_text = "فعال✅"elseif(mute_location=="kick")then mute_location_text = "حالت اخراج📛"elseif(mute_location=="no")then mute_location_text = "غیرفعال❌"elseif(mute_location=="warn")then mute_location_text = "حالت اخطار🚷"end
	if(mute_document=="yes")then mute_document_text = "فعال✅"elseif(mute_document=="kick")then mute_document_text = "حالت اخراج📛"elseif(mute_document=="no")then mute_document_text = "غیرفعال❌"elseif(mute_document=="warn")then mute_document_text = "حالت اخطار🚷"end
	if(mute_keyboard=="yes")then mute_keyboard_text = "فعال✅"elseif(mute_keyboard=="kick")then mute_keyboard_text = "حالت اخراج📛"elseif(mute_keyboard=="no")then mute_keyboard_text = "غیرفعال❌"elseif(mute_keyboard=="warn")then mute_keyboard_text = "حالت اخطار🚷"end
	if(mute_tgservice=="yes")then mute_tgservice_text = "فعال✅"elseif(mute_tgservice=="no")then mute_tgservice_text = "غیرفعال❌"end
	if(lock_pin=="yes")then lock_pin_text = "فعال✅"elseif(lock_pin=="no")then lock_pin_text = "غیرفعال❌"end
	if(lock_bots=="yes")then lock_bots_text = "فعال✅"elseif(lock_bots=="no")then lock_bots_text = "غیرفعال❌"end
	if(lock_join=="yes")then lock_join_text = "فعال✅"elseif(lock_join=="no")then lock_join_text = "غیرفعال❌"end
	if(lock_flood=="yes")then lock_flood_text = "فعال✅"elseif(lock_flood=="no")then lock_flood_text = "غیرفعال❌"end
	if(lock_spam=="yes")then lock_spam_text = "فعال✅"elseif(lock_spam=="no")then lock_spam_text = "غیرفعال❌"end
	if(group_welcone=="yes")then group_welcone_text = "فعال✅"elseif(group_welcone=="no")then group_welcone_text = "غیرفعال❌"end -- مینستبمیتبمیسنتبمتیسب5یب5یس5ب5یس5بیسب5بس
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
		{text = "✦ قفل فیلم 🎥: "..mute_video_text.."", callback_data='MaTaDoRTeaM'}
		},
		{
		{text = "ϟ فعال", callback_data="/mutevideod:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutevideok:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutevideow:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutevideoo:"..GP_id}
		},
		{
		{text = "✦ قفل فیلم سلفی 🎥: "..mute_video_self_text.."", callback_data='MaTaDoRTeaM'}
		},
		{
		{text = "ϟ فعال", callback_data="/mutevideoselfd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutevideoselfk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutevideoselfw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutevideoselfo:"..GP_id}
		},
		{
			{text = "✦ قفل آهنگ 🎵: "..mute_audio_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/muteaudiod:"..GP_id},
		{text = "ϟ اخراج", callback_data="/muteaudiok:"..GP_id},
		{text = "ϟ اخطار", callback_data="/muteaudiow:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/muteaudioo:"..GP_id}
		},
		{
			{text = "✦ قفل ویس 🎙: "..mute_voice_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/mutevoiced:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutevoicek:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutevoicew:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutevoiceo:"..GP_id}
		},
		{
			{text = "✦ قفل استیکر 🔰: "..mute_sticker_text.."", callback_data='MaTaDoRTeaM'}
		},
		{
		{text = "ϟ فعال", callback_data="/mutestickerd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutestickerk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutestickerw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutestickero:"..GP_id}
		},
		{
			{text = "✦ قفل مخاطب ☎️: "..mute_contact_text.."", callback_data='MaTaDoRTeaM'}
		},
		{
		{text = "ϟ فعال", callback_data="/mutecontactd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutecontactk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutecontactw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutecontacto:"..GP_id}
		},
		{
			{text = "✦ قفل نقل قول 🔗: "..mute_forward_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/muteforwardd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/muteforwardk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/muteforwardw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/muteforwardo:"..GP_id}
		},
		{
			{text = "✦ قفل مکان 📡: "..mute_location_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/mutelocationd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutelocationk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutelocationw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutelocationo:"..GP_id}
		},
		{
			{text = "✦ قفل فایل 📂: "..mute_document_text.."", callback_data='MaTaDoRTeaM'}  
		},
		{
		{text = "ϟ فعال", callback_data="/mutedocumentd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutedocumentk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutedocumentw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutedocumento:"..GP_id}
		},
		{
			{text = "✦ قفل کیبورد 🎹: "..mute_keyboard_text.."", callback_data='MaTaDoRTeaM'} 
		},
		{
		{text = "ϟ فعال", callback_data="/mutekeyboardd:"..GP_id},
		{text = "ϟ اخراج", callback_data="/mutekeyboardk:"..GP_id},
		{text = "ϟ اخطار", callback_data="/mutekeyboardw:"..GP_id},
		{text = "ϟ غیرفعال", callback_data="/mutekeyboardo:"..GP_id}
		},
		{
			{text = "✦ قفل سرویس تلگرام 📡", callback_data='MaTaDoRTeaM'}, 
			{text = mute_tgservice_text, callback_data="/mutetgservice:"..GP_id}
		},
		{
			{text = "✦ قفل سنجاق 📌", callback_data='MaTaDoRTeaM'}, 
			{text = lock_pin_text, callback_data="/lockpin:"..GP_id}
		},
		{
			{text = "✦ قفل ربات‌های تبلیغگر🤖", callback_data='MaTaDoRTeaM'}, 
			{text = lock_bots_text, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "✦ قفل ورود ⚡️", callback_data='MaTaDoRTeaM'}, 
			{text = lock_join_text, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "✦ قفل پیام مکرر 💥", callback_data='MaTaDoRTeaM'}, 
			{text = lock_flood_text, callback_data="/lockflood:"..GP_id}
		},
		{
			{text = "✦ قفل هرزنامه ☢️", callback_data='MaTaDoRTeaM'}, 
			{text = lock_spam_text, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "✦ خوش‌آمد گویی 🤹‍♂️", callback_data='MaTaDoRTeaM'},
			{text = group_welcone_text, callback_data="/welcome:"..GP_id} -- خوش آمد گویی
		},
		{
			{text = '✦ تنظیمات بیشتر ♨️', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '✦ بازگشت 🔙', callback_data = '/settings:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
--------------Begin Msg Matches---------------
	if matches[1] == "sudolist" and is_sudo(msg) then
		return sudolist(msg)
	end
	if tonumber(msg.from.id) == SUDO then
		if matches[1]:lower() == "setsudo" then
			if matches[2] and not msg.reply_to_message then
				local user_id = matches[2]
				if already_sudo(tonumber(user_id)) then
					return 'User '..user_id..' is already sudo users'
				else
					table.insert(_config.sudo_users, tonumber(user_id)) 
					print(user_id..' added to sudo users') 
					save_config() 
					reload_plugins(true) 
					return "User "..user_id.." added to sudo users" 
				end
		elseif not matches[2] and msg.reply_to_message then
			local user_id = msg.reply_to_message.from.id
			if already_sudo(tonumber(user_id)) then
				return 'User '..user_id..' is already sudo users'
			else
				table.insert(_config.sudo_users, tonumber(user_id)) 
				print(user_id..' added to sudo users') 
				save_config() 
				reload_plugins(true) 
				return "User "..user_id.." added to sudo users" 
			end
		end
	end
	if matches[1]:lower() == "remsudo" then
	if matches[2] and not msg.reply_to_message then
		local user_id = tonumber(matches[2]) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	elseif not matches[2] and msg.reply_to_message then
		local user_id = tonumber(msg.reply_to_message.from.id) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	end
	end
	end
	if is_sudo(msg) then
  if matches[1]:lower() == '!plist' or matches[1]:lower() == '/plist' or matches[1]:lower() == '#plist' then --after changed to moderator mode, set only sudo
    return list_all_plugins()
  end
end
   if matches[1] == 'pl' then
  if matches[2] == '+' and matches[4] == 'chat' then
      if is_momod(msg) then
    local receiver = msg.chat_id_
    local plugin = matches[3]
    print("enable "..plugin..' on this chat')
    return reenable_plugin_on_chat(receiver, plugin)
  end
    end

  if matches[2] == '+' and is_sudo(msg) then 
      if is_mod(msg) then
    local plugin_name = matches[3]
    print("enable: "..matches[3])
    return enable_plugin(plugin_name)
  end
    end
  if matches[2] == '-' and matches[4] == 'chat' then
      if is_mod(msg) then
    local plugin = matches[3]
    local receiver = msg.chat_id_
    print("disable "..plugin..' on this chat')
    return disable_plugin_on_chat(receiver, plugin)
  end
    end
  if matches[2] == '-' and is_sudo(msg) then
    if matches[3] == 'plugins' then
    	return 'This plugin can\'t be disabled'
    end
    print("disable: "..matches[3])
    return disable_plugin(matches[3])
  end
end
  if matches[1] == '*' and is_sudo(msg) then
    return reload_plugins(true)
  end
  if matches[1]:lower() == 'reload' and is_sudo(msg) then
    return reload_plugins(true)
  end
--------------End Msg Matches---------------

--------------Begin Inline Query---------------
if msg.query and msg.query:match("-%d+") and is_sudo(msg) then
local chatid = "-"..msg.query:match("%d+")
	keyboard = {}
	keyboard.inline_keyboard = {
	    {
            {text = "❤️ "..tostring(redis:get("MaTaDoRLikes")), callback_data="/like:"..chatid},
            {text = "💔 "..tostring(redis:get("MaTaDoRDisLikes")), callback_data="/dislike:"..chatid}
        },
        {
			{text = "❃ تنظیمات ⚙️", callback_data="/settings:"..chatid}
		},
		{
			{text = '❃ اطلاعات گروه و مدیریت لیست‌ها 🔬', callback_data = '/more:'..chatid}
		},
		{
			{text = '❃ نرخ ربات 💰', callback_data = '/nerkh:'..chatid}
		},
		{
			{text= '❃ بستن پنل شیشه‌ای 🔚' ,callback_data = '/exit:'..chatid}
		}					
	}
	send_inline(msg.id,'settings','Group Option','Tap Here','به پنل شیشه‌ای مدیریتی گروه خوش آمدید 🌹\nبرای مدیریت گروه میتونید از دکمه های زیر استفاده کنید...\n\nبرای حمایت از ما لطفا به ما رای دهید ❤️',keyboard)
end
if msg.cb then
if matches[1] == '/option' then
if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
options(msg, matches[2])
end
end
  if matches[1] == '/like' then
      if redis:get("IsDisLiked:"..msg.from.id) then
        redis:del("IsDisLiked:"..msg.from.id)
        local dislikes = redis:get("MaTaDoRDisLikes")
        redis:set("MaTaDoRDisLikes",dislikes - 1)
        redis:set("IsLiked:"..msg.from.id,true)
        local likes = redis:get("MaTaDoRLikes")
        redis:set("MaTaDoRLikes",likes + 1)
        Canswer(msg.cb_id, "تشکر فراوان از رای مثبت شما😄❤️" ,true)
      else
        if redis:get("IsLiked:"..msg.from.id) then
          redis:del("IsLiked:"..msg.from.id)
          local likes = redis:get("MaTaDoRLikes")
          redis:set("MaTaDoRLikes",likes - 1)
          Canswer(msg.cb_id, "خیلی بدی مگه چکار کردم رای مثبت رو پس گرفتی😢💔" ,true)
        else
          redis:set("IsLiked:"..msg.from.id,true)
          local likes = redis:get("MaTaDoRLikes")
          redis:set("MaTaDoRLikes",likes + 1)
          Canswer(msg.cb_id, "تشکر فراوان از رای مثبت شما😄❤️" ,true)
        end
      end
	  options(msg,matches[2])
  end
  if matches[1] == '/dislike' then
      if redis:get("IsLiked:"..msg.from.id) then
        redis:del("IsLiked:"..msg.from.id)
        local likes = redis:get("MaTaDoRLikes")
        redis:set("MaTaDoRLikes",likes - 1)
        redis:set("IsDisLiked:"..msg.from.id,true)
        local dislikes = redis:get("MaTaDoRDisLikes")
        redis:set("MaTaDoRDisLikes",dislikes + 1)
        Canswer(msg.cb_id, "خیلی بدی مگه چیکار کردم رای منفی دادی 😢💔" ,true)
      else
        if redis:get("IsDisLiked:"..msg.from.id) then
          redis:del("IsDisLiked:"..msg.from.id)
          local dislikes = redis:get("MaTaDoRDisLikes")
          redis:set("MaTaDoRDisLikes",dislikes - 1)
          Canswer(msg.cb_id, "وای مرسی که رای منفیت رو پس گرفتی 😀🌹" ,true)
        else
          redis:set("IsDisLiked:"..msg.from.id,true)
          local dislikes = redis:get("MaTaDoRDisLikes")
          redis:set("MaTaDoRDisLikes",dislikes + 1)
          Canswer(msg.cb_id, "خیلی بدی مگه چیکار کردم رای منفی دادی 😢💔" ,true)
        end
      end
	  options(msg,matches[2])
  end
if matches[1] == '/nerkh' then
if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
	local text = [[
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
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text= '✦ بازگشت 🔙' ,callback_data = '/option:'..matches[2]}
		}				
	}
    edit_inline(msg.message_id, text..MaTaDoRch, keyboard)
end
end
if matches[1] == '/settings' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutelist' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/moresettings' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		moresetting(msg, data, matches[2])
	end
end

          -- ####################### Settings ####################### --
if matches[1] == '/locklinkd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
			text = 'حذف لینک فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_link"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)	
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locklinkw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
			text = 'اخطار لینک فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_link"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locklinkk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
			text = 'اخراج لینک فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_link"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locklinko' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
			text = 'لینک آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_link"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockeditd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
			text = 'حذف ویرایش فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_edit"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockeditw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
			text = 'اخطار ویرایش فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_edit"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockeditk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
			text = 'اخراج ویرایش فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_edit"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockedito' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
			text = 'ویرایش آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_edit"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktagsd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locktags = data[tostring(matches[2])]["settings"]["lock_tag"]
			text = 'حذف تگ فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_tag"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktagsw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locktags = data[tostring(matches[2])]["settings"]["lock_tag"]
			text = 'اخطار تگ فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_tag"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktagsk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locktags = data[tostring(matches[2])]["settings"]["lock_tag"]
			text = 'اخراج تگ فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_tag"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktagso' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local locktags = data[tostring(matches[2])]["settings"]["lock_tag"]
			text = 'تگ آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_tag"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockusernamed' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockusername = data[tostring(matches[2])]["settings"]["lock_username"]
			text = 'حذف نام کاربری فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_username"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockusernamew' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockusername = data[tostring(matches[2])]["settings"]["lock_username"]
			text = 'اخطار نام کاربری فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_username"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockusernamek' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockusername = data[tostring(matches[2])]["settings"]["lock_username"]
			text = 'اخراج نام کاربری فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_username"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockusernameo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockusername = data[tostring(matches[2])]["settings"]["lock_username"]
			text = 'نام کاربری آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_username"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockjoin' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local chklock = data[tostring(matches[2])]["settings"]["lock_join"]
		if chklock == "no" then
			text = 'قفل ورود فعال شد✅'
            data[tostring(matches[2])]["settings"]["lock_join"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
			text = 'قفل ورود غیر فعال شد☑️'
			data[tostring(matches[2])]["settings"]["lock_join"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/lockflood' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local chklock = data[tostring(matches[2])]["settings"]["lock_flood"]
		if chklock == "no" then
			text = 'قفل پیام های مکرر فعال شد✅'
            data[tostring(matches[2])]["settings"]["lock_flood"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
			text = 'قفل پیام های مکرر غیر فعال شد☑️'
			data[tostring(matches[2])]["settings"]["lock_flood"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/lockspam' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local chklock = data[tostring(matches[2])]["settings"]["lock_spam"]
		if chklock == "no" then
			text = 'قفل هرزنامه فعال شد✅'
            data[tostring(matches[2])]["settings"]["lock_spam"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
			text = 'قفل هرزنامه غیر فعال شد☑️'
			data[tostring(matches[2])]["settings"]["lock_spam"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2]) -- ==-=-==-=-=-=--=-=-=-=-=-=-=--=-=--=-=-=-=-=-=--=-=-=-=-=-=-=-==-=-=-==-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=--=-==-=
	end
end
if matches[1] == '/lockmentiond' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmention = data[tostring(matches[2])]["settings"]["lock_mention"]
			text = 'حذف فراخوانی فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_mention"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmentionw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmention = data[tostring(matches[2])]["settings"]["lock_mention"]
			text = 'اخطار فراخوانی فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_mention"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmentionk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmention = data[tostring(matches[2])]["settings"]["lock_mention"]
			text = 'اخراج فراخوانی فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_mention"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmentiono' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmention = data[tostring(matches[2])]["settings"]["lock_mention"]
			text = 'فراخوانی آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_mention"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabicd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockarabic = data[tostring(matches[2])]["settings"]["lock_arabic"]
			text = 'حذف فارسی فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabicw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockarabic = data[tostring(matches[2])]["settings"]["lock_arabic"]
			text = 'اخطار فارسی فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabick' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockarabic = data[tostring(matches[2])]["settings"]["lock_arabic"]
			text = 'اخراج فارسی فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabico' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockarabic = data[tostring(matches[2])]["settings"]["lock_arabic"]
			text = 'فارسی آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockenglishd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockenglish = data[tostring(matches[2])]["settings"]["lock_english"]
			text = 'حذف انگلیسی فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_english"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockenglishw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockenglish = data[tostring(matches[2])]["settings"]["lock_english"]
			text = 'اخطار انگلیسی فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_english"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockenglishk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockenglish = data[tostring(matches[2])]["settings"]["lock_english"]
			text = 'اخراج انگلیسی فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_english"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockenglisho' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockenglish = data[tostring(matches[2])]["settings"]["lock_english"]
			text = 'انگلیسی آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_english"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpaged' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockwebpage = data[tostring(matches[2])]["settings"]["lock_webpage"]
			text = 'حذف وب فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpagew' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockwebpage = data[tostring(matches[2])]["settings"]["lock_webpage"]
			text = 'اخطار وب فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpagek' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockwebpage = data[tostring(matches[2])]["settings"]["lock_webpage"]
			text = 'اخراج وب فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpageo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockwebpage = data[tostring(matches[2])]["settings"]["lock_webpage"]
			text = 'وب آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdownd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmarkdown = data[tostring(matches[2])]["settings"]["lock_markdown"]
			text = 'حذف فونت فعال شد✅'
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdownw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmarkdown = data[tostring(matches[2])]["settings"]["lock_markdown"]
			text = 'اخطار فونت فعال شد🚷'
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdownk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmarkdown = data[tostring(matches[2])]["settings"]["lock_markdown"]
			text = 'اخراج فونت فعال شد📛'
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdowno' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local lockmarkdown = data[tostring(matches[2])]["settings"]["lock_markdown"]
			text = 'فونت آزاد شد☑️'
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockpin' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local chklock = data[tostring(matches[2])]["settings"]["lock_pin"]
		if chklock == "no" then
			text = 'قفل سنجاق کردن فعال شد✅'
            data[tostring(matches[2])]["settings"]["lock_pin"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
			text = 'قفل سنجاق کردن غیر فعال شد☑️'
			data[tostring(matches[2])]["settings"]["lock_pin"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/lockbots' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local chklock = data[tostring(matches[2])]["settings"]["lock_bots"]
		if chklock == "no" then
			text = 'قفل ربات ها فعال شد✅'
            data[tostring(matches[2])]["settings"]["lock_bots"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
			text = 'قفل ربات ها غیر فعال شد☑️'
			data[tostring(matches[2])]["settings"]["lock_bots"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/welcome' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local chklock = data[tostring(matches[2])]["settings"]["welcome"]
		if chklock == "no" then
			text = 'خوش آمد گویی فعال شد✅'
            data[tostring(matches[2])]["settings"]["welcome"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
			text = 'خوش آمد گویی غیر فعال شد☑️'
			data[tostring(matches[2])]["settings"]["welcome"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2]) -- اینجاااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااااا_-_-_=-=--==-=-=-==-=-=--=-=-=-=-=-==-==-=-=-=-=-==-dfdfdf||||
	end
end
if matches[1] == '/floodup' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) < 50 then
			flood_max = tonumber(flood_max) + 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/flooddown' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) > 2 then
			flood_max = tonumber(flood_max) - 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/charup' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) < 1000 then
			char_max = tonumber(char_max) + 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
			text = "حداکثر حروف مجاز تنظیم شد به : "..char_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/chardown' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) > 2 then
			char_max = tonumber(char_max) - 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
			text = "حداکثر حروف مجاز تنظیم شد به : "..char_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimeup' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) < 10 then
			check_time = tonumber(check_time) + 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
			text = "محدوده زمانی بررسی پیام های مکرر تنظیم شد به : "..check_time
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimedown' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) > 2 then
			check_time = tonumber(check_time) - 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
			text = "محدوده زمانی بررسی پیام های مکرر تنظیم شد به : "..check_time
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end

			-- ###################### Mute ###################### --
			
if matches[1] == '/mutegifd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegif = data[tostring(matches[2])]["mutes"]["mute_gif"]
			text = 'حذف گیف فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutegifw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegif = data[tostring(matches[2])]["mutes"]["mute_gif"]
			text = 'اخطار گیف فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutegifk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegif = data[tostring(matches[2])]["mutes"]["mute_gif"]
			text = 'اخراج گیف فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutegifo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegif = data[tostring(matches[2])]["mutes"]["mute_gif"]
			text = 'گیف آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutetextd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutetext = data[tostring(matches[2])]["mutes"]["mute_text"]
			text = 'حذف متن فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_text"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutetextw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutetext = data[tostring(matches[2])]["mutes"]["mute_text"]
			text = 'اخطار متن فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_text"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutetextk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutetext = data[tostring(matches[2])]["mutes"]["mute_text"]
			text = 'اخراج متن فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_text"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutetexto' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutetext = data[tostring(matches[2])]["mutes"]["mute_text"]
			text = 'متن آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_text"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/muteinlined' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteinline = data[tostring(matches[2])]["mutes"]["mute_inline"]
			text = 'حذف دکمه شیشه‌ای فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/muteinlinew' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteinline = data[tostring(matches[2])]["mutes"]["mute_inline"]
			text = 'اخطار دکمه شیشه‌ای فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/muteinlinek' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteinline = data[tostring(matches[2])]["mutes"]["mute_inline"]
			text = 'اخراج دکمه شیشه‌ای فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/muteinlineo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteinline = data[tostring(matches[2])]["mutes"]["mute_inline"]
			text = 'دکمه شیشه‌ای آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutegamed' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegame = data[tostring(matches[2])]["mutes"]["mute_game"]
			text = 'حذف بازی فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_game"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutegamew' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegame = data[tostring(matches[2])]["mutes"]["mute_game"]
			text = 'اخطار بازی فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_game"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutegamek' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegame = data[tostring(matches[2])]["mutes"]["mute_game"]
			text = 'اخراج بازی فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_game"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutegameo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutegame = data[tostring(matches[2])]["mutes"]["mute_game"]
			text = 'بازی آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_game"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutephotod' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutephoto = data[tostring(matches[2])]["mutes"]["mute_photo"]
			text = 'حذف عکس فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutephotow' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutephoto = data[tostring(matches[2])]["mutes"]["mute_photo"]
			text = 'اخطار عکس فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutephotok' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutephoto = data[tostring(matches[2])]["mutes"]["mute_photo"]
			text = 'اخراج عکس فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutephotoo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutephoto = data[tostring(matches[2])]["mutes"]["mute_photo"]
			text = 'عکس آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideod' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video"]
			text = 'حذف فیلم فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_video"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideow' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video"]
			text = 'اخطار فیلم فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_video"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideok' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video"]
			text = 'اخراج فیلم فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_video"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideoo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video"]
			text = 'فیلم آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_video"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideoselfd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video_self"]
			text = 'حذف فیلم سلف فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_video_self"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideoselfw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video_self"]
			text = 'اخطار فیلم سلف فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_video_self"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideoselfk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video_self"]
			text = 'اخراج فیلم سلف فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_video_self"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideoselfo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevideo = data[tostring(matches[2])]["mutes"]["mute_video_self"]
			text = 'فیلم سلف آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_video_self"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudiod' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteaudio = data[tostring(matches[2])]["mutes"]["mute_audio"]
			text = 'حذف آهنگ فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudiow' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteaudio = data[tostring(matches[2])]["mutes"]["mute_audio"]
			text = 'اخطار آهنگ فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudiok' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteaudio = data[tostring(matches[2])]["mutes"]["mute_audio"]
			text = 'اخراج آهنگ فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudioo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteaudio = data[tostring(matches[2])]["mutes"]["mute_audio"]
			text = 'آهنگ آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoiced' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevoice = data[tostring(matches[2])]["mutes"]["mute_voice"]
			text = 'حذف ویس فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoicew' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevoice = data[tostring(matches[2])]["mutes"]["mute_voice"]
			text = 'اخطار ویس فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoicek' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevoice = data[tostring(matches[2])]["mutes"]["mute_voice"]
			text = 'اخراج ویس فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoiceo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutevoice = data[tostring(matches[2])]["mutes"]["mute_voice"]
			text = 'ویس آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutestickerd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutesticker = data[tostring(matches[2])]["mutes"]["mute_sticker"]
			text = 'حذف استیکر فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutestickerw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutesticker = data[tostring(matches[2])]["mutes"]["mute_sticker"]
			text = 'اخطار استیکر فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutestickerk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutesticker = data[tostring(matches[2])]["mutes"]["mute_sticker"]
			text = 'اخراج استیکر فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutestickero' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutesticker = data[tostring(matches[2])]["mutes"]["mute_sticker"]
			text = 'استیکر آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontactd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutecontact = data[tostring(matches[2])]["mutes"]["mute_contact"]
			text = 'حذف مخاطب فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontactw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutecontact = data[tostring(matches[2])]["mutes"]["mute_contact"]
			text = 'اخطار مخاطب فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontactk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutecontact = data[tostring(matches[2])]["mutes"]["mute_contact"]
			text = 'اخراج مخاطب فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontacto' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutecontact = data[tostring(matches[2])]["mutes"]["mute_contact"]
			text = 'مخاطب آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforwardd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteforward = data[tostring(matches[2])]["mutes"]["mute_forward"]
			text = 'حذف نقل قول فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforwardw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteforward = data[tostring(matches[2])]["mutes"]["mute_forward"]
			text = 'اخطار نقل قول فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforwardk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteforward = data[tostring(matches[2])]["mutes"]["mute_forward"]
			text = 'اخراج نقل قول فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforwardo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local muteforward = data[tostring(matches[2])]["mutes"]["mute_forward"]
			text = 'نقل قول آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocationd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutelocation = data[tostring(matches[2])]["mutes"]["mute_location"]
			text = 'حذف موقعیت فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_location"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocationw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutelocation = data[tostring(matches[2])]["mutes"]["mute_location"]
			text = 'اخطار موقعیت فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_location"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocationk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutelocation = data[tostring(matches[2])]["mutes"]["mute_location"]
			text = 'اخراج موقعیت فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_location"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocationo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutelocation = data[tostring(matches[2])]["mutes"]["mute_location"]
			text = 'موقعیت آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_location"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocumentd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutedocument = data[tostring(matches[2])]["mutes"]["mute_document"]
			text = 'حذف فایل فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_document"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocumentw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutedocument = data[tostring(matches[2])]["mutes"]["mute_document"]
			text = 'اخطار فایل فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_document"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocumentk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutedocument = data[tostring(matches[2])]["mutes"]["mute_document"]
			text = 'اخراج فایل فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_document"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocumento' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutedocument = data[tostring(matches[2])]["mutes"]["mute_document"]
			text = 'فایل آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_document"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboardd' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutekeyboard = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
			text = 'حذف کیبورد شیشه‌ای فعال شد✅'
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "yes"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboardw' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutekeyboard = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
			text = 'اخطار کیبورد شیشه‌ای فعال شد🚷'
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "warn"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboardk' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutekeyboard = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
			text = 'اخراج کیبورد شیشه‌ای فعال شد📛'
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "kick"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboardo' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local mutekeyboard = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
			text = 'کیبورد شیشه‌ای آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "no"
			save_data(_config.moderation.data, data)
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetgservice' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_tgservice"]
		if chkmute == "no" then
        text = 'حذف خدمات تلگرام فعال شد✅'
            data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
        text = 'خدمات تلگرام آزاد شد☑️'
			data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
            -- ####################### More #######################--
			
if matches[1] == '/more' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
        text = '*به ادامه تنظیمات کلی خوشآمدید* 🤖'
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ لیست مالکین 🤠", callback_data="/ownerlist:"..matches[2]},
				{text = "✦ لیست مدیران 👮🏻", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "✦ لیست سکوت 🤐", callback_data="/silentlist:"..matches[2]},
				{text = "✦ لیست فیلتر 📝", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "✦ لیست مسدود 🚫", callback_data="/bans:"..matches[2]},
				{text = "✦ لیست سفید 🛡", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "✦ لینک گروه 🏷", callback_data="/link:"..matches[2]},
				{text = "✦ قوانین گروه 🔮", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "✦ پیام خوشآمد 🔖", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/option:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/ownerlist' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local i = 1
		if next(data[tostring(matches[2])]['owners']) == nil then --fix way
			text = "_هیچ مالکی برای گروه تعیین نشده_"
		else
			text = "_لیست مالکین گروه :_\n"
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ برکناری تمام مالکین", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanowners' then
	if not is_admin1(msg.from.id) then
    get_alert(msg.cb_id, "شما ادمین ربات نیستید")
	else
		if next(data[tostring(matches[2])]['owners']) == nil then
			text = "_هیچ مالکی برای گروه تعیین نشده_"
		else
			text = "_تمام مالکین از مقام خود برکنار شدند_"
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				data[tostring(matches[2])]['owners'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ بازگشت 🔙", callback_data="/ownerlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/filterlist' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		if next(data[tostring(matches[2])]['filterlist']) == nil then --fix way
			text = "_لیست کلمات فیلتر شده خالی است_"
		else 
			local i = 1
			text = '_لیست کلمات فیلتر شده :_\n'
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				text = text..''..i..' - '..check_markdown(k)..'\n'
				i = i + 1
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ پاک کردن", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanfilterlist' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		if next(data[tostring(matches[2])]['filterlist']) == nil then
			text = "_لیست کلمات فیلتر شده خالی است_"
		else
			text = "_لیست کلمات فیلتر پاک شد_"
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				data[tostring(matches[2])]['filterlist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ بازگشت 🔙", callback_data="/filterlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/modlist' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local i = 1
		if next(data[tostring(matches[2])]['mods']) == nil then --fix way
			text = "_هیچ مدیری برای گروه تعیین نشده_"
		else
			text = "_لیست مدیران گروه :_\n"
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ برکناری تمام مدیران", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanmods' then
	if not is_owner1(matches[2], msg.from.id) then
		get_alert(msg.cb_id, "شما صاحب گروه نیستید")
	else
		if next(data[tostring(matches[2])]['mods']) == nil then
			text = "_هیچ مدیری برای گروه تعیین نشده_"
		else
			text = "_تمام مدیران از مقام خود برکنار شدند_"
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				data[tostring(matches[2])]['mods'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ بازگشت 🔙", callback_data="/modlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/bans' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local i = 1
		if next(data[tostring(matches[2])]['banned']) == nil then --fix way
			text = "_هیچ فردی از این گروه محروم نشده_"
		else
			text = "_لیست افراد محروم شده از گروه :_\n"
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ پاک کردن لیست مسدود ", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/silentlist' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local i = 1
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then --fix way
			text = "_هیچ فردی در این گروه سکوت نشده_"
		else
			text = "_لیست افراد سکوت شده :_\n"
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ پاک کردن لیست سکوت", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleansilentlist' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then
			text = "_هیچ فردی در این گروه سکوت نشده"
		else
			text = "_تمام افراد سکوت شده از لیست سکوت خارج شدند_"
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				data[tostring(matches[2])]['is_silent_users'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ بازگشت 🔙", callback_data="/silentlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanbans' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		if next(data[tostring(matches[2])]['banned']) == nil then
			text = "_هیچ فردی از این گروه محروم نشده"
		else
			text = "_تمام افراد محروم شده از محرومیت این گروه خارج شدند_"
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				data[tostring(matches[2])]['banned'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ بازگشت 🔙", callback_data="/bans:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/link' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local linkgp = data[tostring(matches[2])]['settings']['linkgp']
		if not linkgp then
			text = "_ابتدا با دستور_ setlink/ _لینک جدیدی برای گروه تعیین کنید_"
		else
			text = "[| کلیک کنید |]("..linkgp..")"
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/rules' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
       text = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@MaTaDoRsupporT"
		elseif rules then
			text = '_قوانین گروه :_\n'..rules
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ پاک کردن", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanrules' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
			text = "_قوانین گروه ثبت نشده_"
		else
			text = "_قوانین گروه پاک شد_"
			data[tostring(matches[2])]['rules'] = nil
			save_data(_config.moderation.data, data)
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "✦ بازگشت 🔙", callback_data="/rules:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
		if matches[1] == '/whitelists' then
			if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
				text = "_لیست سفید خالی می باشد._"
		else 
			local i = 1
				text = '_> لیست سفید:_ \n'
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				text = text..''..i..' - '..check_markdown(v)..' ' ..k.. ' \n'
				i = i + 1
			end
		end
		local keyboard = {}
		keyboard.inline_keyboard = {
			{
				{text = "✦ حذف لیست سفید", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwhitelists' then
			if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
				text = "_لیست سفید خالی می باشد._"
		else
				text = "_لیست سفید حذف شد._"
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				data[tostring(matches[2])]['whitelist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		local keyboard = {} 
				keyboard.inline_keyboard = {

			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
		end
end
if matches[1] == '/showwlc' then
local text = ''
if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
				text = "_پیام خوشامد تنظیم نشده است._"
		else
			text = '_پیام خوشامد:_\n'..wlc
		end
		local keyboard = {} 
		keyboard.inline_keyboard = {
			{ 
				{text = "✦ حذف پیام خوشامد", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwlcmsg' then
local text = ''
if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای به صورت خودکار بسته شد*✅' edit_inline(msg.message_id, text) Canswer(msg.cb_id, "به دلیل اتمام زمان استفاده، پنل به صورت خودکار بسته میشود 😊" ,true) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 "..MaTaDoRby.."\nیا به کانال زیر مراجعه کنید :\n💢 "..MaTaDoRch.."" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
				text = "_پیام خوشامد تنظیم نشده است._"
		else
			text = '_پیام خوشامد حذف شد._'
		data[tostring(matches[2])]['setwelcome'] = nil
		save_data(_config.moderation.data, data)
end
local keyboard = {} 
				keyboard.inline_keyboard = {

			{ 
				{text = "✦ بازگشت 🔙", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
end
end
         -- ####################### About Us ####################### --
if matches[1] == '/matador' then
	local text = 'پشتیبانی'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "✦ نرخ ربات 💰", callback_data="/nerkh:"..matches[2]}
		},
		{
			{text= '✦ بازگشت 🔙' ,callback_data = '/option:'..matches[2]}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/exit' then
	if not redis:get("ReqMenu:"..matches[2]) then text = '📌*پنل شیشه‌ای با موفقیت بسته شد*✅' edit_inline(msg.message_id, text) elseif not is_mod1(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما مدیر نیستید 🚫\nبرای خرید ربات به پیوی :\n💢 @SaberTigerPv\nیا به کانال زیر مراجعه کنید :\n💢 @MaTaDoRsupporT" ,true) elseif not is_req(matches[2], msg.from.id) then Canswer(msg.cb_id, "شما این فهرست را درخواست نکردید 🚷🤖" ,true) else
		 text = '📌*پنل شیشه‌ای با موفقیت بسته شد*✅'
		edit_inline(msg.message_id, text)
	end
end
end
--------------End Inline Query---------------
end

return {
	patterns ={
		"^-(%d+)$",
		"^(Help)$",
		"^###cb:(%d+)$",
		"^[/](sudolist)$",
		"^[/](setsudo)$",
		"^[/](remsudo)$",
		"^[/](setsudo) (%d+)$",
		"^[/](remsudo) (%d+)$",
		"^[!/#]plist$",
        "^[!/#](pl) (+) ([%w_%.%-]+)$",
        "^[!/#](pl) (-) ([%w_%.%-]+)$",
        "^[!/#](pl) (+) ([%w_%.%-]+) (chat)",
        "^[!/#](pl) (-) ([%w_%.%-]+) (chat)",
        "^!pl? (*)$",
        "^[!/](reload)$",
		"^###cb:(/nerkh):(.*)$",
		"^###cb:(/helpp):(.*)$",
		"^###cb:(/help1):(.*)$",
		"^###cb:(/help2):(.*)$",
		"^###cb:(/help3):(.*)$",
		"^###cb:(/help3a):(.*)$",
		"^###cb:(/help4):(.*)$",
		"^###cb:(/help4a):(.*)$",
		"^###cb:(/help4b):(.*)$",
		"^###cb:(/help5):(.*)$",
		"^###cb:(/help6):(.*)$",
		"^###cb:(/persianh):(.*)$",
		"^###cb:(/englishh):(.*)$",
		"^###cb:(/option):(.*)$",
		"^###cb:(/persian):(.*)$",
		"^###cb:(/english):(.*)$",
		"^###cb:(/settings):(.*)$",
		"^###cb:(/mutelist):(.*)$",
		"^###cb:(/lockusernamek):(.*)$",
		"^###cb:(/lockusernameb):(.*)$",
		"^###cb:(/lockusernamew):(.*)$",
		"^###cb:(/lockusernamed):(.*)$",
		"^###cb:(/lockusernameo):(.*)$",
		"^###cb:(/lockenglishk):(.*)$",
		"^###cb:(/lockenglishw):(.*)$",
		"^###cb:(/lockenglishd):(.*)$",
		"^###cb:(/lockenglishb):(.*)$",
		"^###cb:(/lockenglisho):(.*)$",
		"^###cb:(/locklink):(.*)$",
		"^###cb:(/lockeditd):(.*)$",
		"^###cb:(/lockeditb):(.*)$",
		"^###cb:(/lockeditw):(.*)$",
		"^###cb:(/lockeditk):(.*)$",
		"^###cb:(/lockedito):(.*)$",
		"^###cb:(/locktags):(.*)$",
		"^###cb:(/lockjoin):(.*)$",
		"^###cb:(/lockpin):(.*)$",
		"^###cb:(/lockmarkdown):(.*)$",
		"^###cb:(/lockmention):(.*)$",
		"^###cb:(/lockarabic):(.*)$",
		"^###cb:(/lockwebpage):(.*)$",
		"^###cb:(/lockbots):(.*)$",
		"^###cb:(/lockspam):(.*)$",
		"^###cb:(/lockflood):(.*)$",
		"^###cb:(/welcome):(.*)$",
		"^###cb:(/muteall):(.*)$",
		"^###cb:(/mutegif):(.*)$",
		"^###cb:(/mutegame):(.*)$",
		"^###cb:(/mutevideo):(.*)$",
		"^###cb:(/mutevoice):(.*)$",
		"^###cb:(/muteinline):(.*)$",
		"^###cb:(/mutesticker):(.*)$",
		"^###cb:(/mutelocation):(.*)$",
		"^###cb:(/mutedocument):(.*)$",
		"^###cb:(/muteaudio):(.*)$",
		"^###cb:(/mutephoto):(.*)$",
		"^###cb:(/mutetext):(.*)$",
		"^###cb:(/mutetgservice):(.*)$",
		"^###cb:(/mutekeyboard):(.*)$",
		"^###cb:(/mutecontact):(.*)$",
		"^###cb:(/muteforward):(.*)$",
		"^###cb:(/locklinkb):(.*)$",
		"^###cb:(/locktagsb):(.*)$",
		"^###cb:(/lockmarkdownb):(.*)$",
		"^###cb:(/lockmentionb):(.*)$",
		"^###cb:(/lockarabicb):(.*)$",
		"^###cb:(/lockwebpageb):(.*)$",
		"^###cb:(/mutegifb):(.*)$",
		"^###cb:(/mutegameb):(.*)$",
		"^###cb:(/mutevideob):(.*)$",
		"^###cb:(/mutevoiceb):(.*)$",
		"^###cb:(/muteinlineb):(.*)$",
		"^###cb:(/mutestickerb):(.*)$",
		"^###cb:(/mutelocationb):(.*)$",
		"^###cb:(/mutedocumentb):(.*)$",
		"^###cb:(/muteaudiob):(.*)$",
		"^###cb:(/mutephotob):(.*)$",
		"^###cb:(/mutetextb):(.*)$",
		"^###cb:(/mutekeyboardb):(.*)$",
		"^###cb:(/mutecontactb):(.*)$",
		"^###cb:(/muteforwardb):(.*)$",
		"^###cb:(/locklinkk):(.*)$",
		"^###cb:(/locktagsk):(.*)$",
		"^###cb:(/lockmarkdownk):(.*)$",
		"^###cb:(/lockmentionk):(.*)$",
		"^###cb:(/lockarabick):(.*)$",
		"^###cb:(/lockwebpagek):(.*)$",
		"^###cb:(/mutegifk):(.*)$",
		"^###cb:(/mutegamek):(.*)$",
		"^###cb:(/mutevideok):(.*)$",
		"^###cb:(/mutevideoselfk):(.*)$",
		"^###cb:(/mutevoicek):(.*)$",
		"^###cb:(/muteinlinek):(.*)$",
		"^###cb:(/mutestickerk):(.*)$",
		"^###cb:(/mutelocationk):(.*)$",
		"^###cb:(/mutedocumentk):(.*)$",
		"^###cb:(/muteaudiok):(.*)$",
		"^###cb:(/mutephotok):(.*)$",
		"^###cb:(/mutetextk):(.*)$",
		"^###cb:(/mutekeyboardk):(.*)$",
		"^###cb:(/mutecontactk):(.*)$",
		"^###cb:(/muteforwardk):(.*)$",
		"^###cb:(/locklinkw):(.*)$",
		"^###cb:(/locktagsw):(.*)$",
		"^###cb:(/lockmarkdownw):(.*)$",
		"^###cb:(/lockmentionw):(.*)$",
		"^###cb:(/lockarabicw):(.*)$",
		"^###cb:(/lockwebpagew):(.*)$",
		"^###cb:(/mutegifw):(.*)$",
		"^###cb:(/mutegamew):(.*)$",
		"^###cb:(/mutevideow):(.*)$",
		"^###cb:(/mutevideoselfw):(.*)$",
		"^###cb:(/mutevoicew):(.*)$",
		"^###cb:(/muteinlinew):(.*)$",
		"^###cb:(/mutestickerw):(.*)$",
		"^###cb:(/mutelocationw):(.*)$",
		"^###cb:(/mutedocumentw):(.*)$",
		"^###cb:(/muteaudiow):(.*)$",
		"^###cb:(/mutephotow):(.*)$",
		"^###cb:(/mutetextw):(.*)$",
		"^###cb:(/mutekeyboardw):(.*)$",
		"^###cb:(/mutecontactw):(.*)$",
		"^###cb:(/muteforwardw):(.*)$",
		"^###cb:(/locklinkd):(.*)$",
		"^###cb:(/locktagsd):(.*)$",
		"^###cb:(/lockmarkdownd):(.*)$",
		"^###cb:(/lockmentiond):(.*)$",
		"^###cb:(/lockarabicd):(.*)$",
		"^###cb:(/lockwebpaged):(.*)$",
		"^###cb:(/mutegifd):(.*)$",
		"^###cb:(/mutegamed):(.*)$",
		"^###cb:(/mutevideod):(.*)$",
		"^###cb:(/mutevideoselfd):(.*)$",
		"^###cb:(/mutevoiced):(.*)$",
		"^###cb:(/muteinlined):(.*)$",
		"^###cb:(/mutestickerd):(.*)$",
		"^###cb:(/mutelocationd):(.*)$",
		"^###cb:(/mutedocumentd):(.*)$",
		"^###cb:(/muteaudiod):(.*)$",
		"^###cb:(/mutephotod):(.*)$",
		"^###cb:(/mutetextd):(.*)$",
		"^###cb:(/mutekeyboardd):(.*)$",
		"^###cb:(/mutecontactd):(.*)$",
		"^###cb:(/muteforwardd):(.*)$",
		"^###cb:(/locklinko):(.*)$",
		"^###cb:(/locktagso):(.*)$",
		"^###cb:(/lockmarkdowno):(.*)$",
		"^###cb:(/lockmentiono):(.*)$",
		"^###cb:(/lockarabico):(.*)$",
		"^###cb:(/lockwebpageo):(.*)$",
		"^###cb:(/mutegifo):(.*)$",
		"^###cb:(/mutegameo):(.*)$",
		"^###cb:(/mutevideoo):(.*)$",
		"^###cb:(/mutevideoselfo):(.*)$",
		"^###cb:(/mutevoiceo):(.*)$",
		"^###cb:(/muteinlineo):(.*)$",
		"^###cb:(/mutestickero):(.*)$",
		"^###cb:(/mutelocationo):(.*)$",
		"^###cb:(/mutedocumento):(.*)$",
		"^###cb:(/muteaudioo):(.*)$",
		"^###cb:(/mutephotoo):(.*)$",
		"^###cb:(/mutetexto):(.*)$",
		"^###cb:(/mutekeyboardo):(.*)$",
		"^###cb:(/mutecontacto):(.*)$",
		"^###cb:(/muteforwardo):(.*)$",
		"^###cb:(/setflood):(.*)$",
		"^###cb:(/floodup):(.*)$",
		"^###cb:(/flooddown):(.*)$",
		"^###cb:(/charup):(.*)$",
		"^###cb:(/chardown):(.*)$",
		"^###cb:(/floodtimeup):(.*)$",
		"^###cb:(/floodtimedown):(.*)$",
		"^###cb:(/moresettings):(.*)$",
		"^###cb:(/more):(.*)$",
		"^###cb:(/ownerlist):(.*)$",
		"^###cb:(/cleanowners):(.*)$",
		"^###cb:(/modlist):(.*)$",
		"^###cb:(/cleanmods):(.*)$",
		"^###cb:(/bans):(.*)$",
		"^###cb:(/matador):(.*)$",
		"^###cb:(/cleanbans):(.*)$",
		"^###cb:(/filterlist):(.*)$",
		"^###cb:(/cleanfilterlist):(.*)$",
		"^###cb:(/whitelist):(.*)$",
		"^###cb:(/cleanwhitelist):(.*)$",
		"^###cb:(/silentlist):(.*)$",
		"^###cb:(/mahdiroo):(.*)$",
		"^###cb:(/tiger):(.*)$",
		"^###cb:(/xamarin):(.*)$",
		"^###cb:(/cleansilentlist):(.*)$",
		"^###cb:(/link):(.*)$",
		"^###cb:(/dislike):(.*)$",
		"^###cb:(/like):(.*)$",
		"^###cb:(/rules):(.*)$",
		"^###cb:(/cleanrules):(.*)$",
		"^###cb:(/exit):(.*)$",
		"^###cb:(/whitelists):(.*)$",
		"^###cb:(/cleanwhitelists):(.*)$",
		"^###cb:(/showwlc):(.*)$",
		"^###cb:(/cleanwlcmsg):(.*)$",

	},
	run=run
}
