local msgBody
local function getTableSize(set)
	local n = 0
	for k,v in pairs(set) do
		n = n + 1
	end
	return n
end
local pts = {  
"^[!/#]*([Aa][Dd][Dd][Ss][Uu][Dd][Oo][Cc][Hh][Aa][Nn][Nn][Ee][Ll])%s(@.+)%s([Hh][Tt][Tt][Pp][Ss]://[Tt][EeLlGgRrAaMm]*%.[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/[^%s]+)%s?(.*)$",
"^(افزودن%sکانال%sسودو)%s(@.+)%s([Hh][Tt][Tt][Pp][Ss]://[Tt][EeLlGgRrAaMm]*%.[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/[^%s]+)%s?(.*)$",
"^[!/#]*([Rr][Ee][Mm][Ss][Uu][Dd][Oo][Cc][Hh][Aa][Nn][Nn][Ee][Ll])%s(@.+)$",
"^(حذف%sکانال%sسودو)%s(@.+)$",
"^[!/#]*([Aa][Dd][Dd][Cc][Hh][Aa][Nn][Nn][Ee][Ll])%s(@.+)%s([Hh][Tt][Tt][Pp][Ss]://[Tt][EeLlGgRrAaMm]*%.[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/.+)$",
"^(افزودن%sکانال)%s(@.+)%s([Hh][Tt][Tt][Pp][Ss]://[Tt][EeLlGgRrAaMm]*%.[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/.+)$",
"^[!/#]*([Rr][Ee][Mm][Cc][Hh][Aa][Nn][Nn][Ee][Ll])%s(@.+)$",
"^(حذف%sکانال)%s(@.+)$",
"^[!/#]*([Ss][Ee][Tt][Cc][Hh][Ee][Cc][Kk][Tt][Ii][Mm][Ee])%s(%d+)$",
"^(تنظیم%sزمان%sچک)%s(%d+)$",
"^[!/#]*([Gg][Ee][Tt][Cc][Hh][Ee][Cc][Kk][Tt][Ii][Mm][Ee])$",
"^(زمان%sچک)$",
"^[!/#]*([Mm][Aa][Nn][Jj][Oo][Ii][Nn][Gg][Ll][Oo][Bb][Aa][Ll])%s?(.*)$",
"^(جوین%sاجباری%sگلوبال)%s?(.*)$",
"^[!/#]*([Mm][Aa][Nn][Jj][Oo][Ii][Nn][Ss][Uu][Dd][Oo])%s?(.*)$",
"^(جوین%sاجباری%sسودو)%s?(.*)$",
"^[!/#]*([Mm][Aa][Nn][Jj][Oo][Ii][Nn][Gg][Rr][Oo][Uu][Pp])%s?(.*)$",
"^(جوین%sاجباری%sگروه)%s?(.*)$",
"^[!/#]*([Ss][Ee][Tt][Cc][Ll][Ee][Aa][Nn][Uu][Pp][Tt][Ii][Mm][Ee])%s(%d+)$",
"^(تنظیم%sزمان%sپاکسازی)%s(%d+)$",
"^[!/#]*([Gg][Ee][Tt][Cc][Ll][Ee][Aa][Nn][Uu][Pp][Tt][Ii][Mm][Ee])$",
"^[!/#]*([Ss][Uu][Dd][Oo][Cc][Hh][Aa][Nn][Nn][Ee][Ll][Ss])$",
"^[!/#]*([Gg][Rr][Oo][Uu][Pp][Cc][Hh][Aa][Nn][Nn][Ee][Ll][Ss])$",
"^[!/#]*([Hh][Ee][Ll][Pp]%s[Mm][Aa][Nn][Jj][Oo][Ii][Nn])$",
"^[!/#]*([Hh][Ee][Ll][Pp]%s[Mm][Aa][Nn][Jj][Oo][Ii][Nn]%s[Ss][Uu][Dd][Oo])$",
"^[!/#]*([Mm][Aa][Nn][Jj][Oo][Ii][Nn][Ii][Gg][Nn][Oo][Rr][Ee])%s?(.*)$",
"^(نادیده%sگرفتن%sجوین%sاجباری)%s?(.*)$",
"^(لیست%sکانال%sگروه)$",
"^(لیست%sکانال%sسودو)$",
"^(زمان%sپاکسازی)$",
"^(راهنمای%sجوین%sاجباری)$",
"^(راهنمای%sجوین%sاجباری%sسودو)$",
 }
local function postChecks(chatID, msgID, msgDate, cleanUpTime)
	local ttl = tonumber(redis:ttl('ManJoin:' .. chatID .. ':users')) -- Get TTL of users hmap of that gp
	if ttl == -1 then -- Set expire
		ttl = tonumber(redis:ttl('ExpireDate:' .. chatID))
		if (ttl ~= -1) then
			redis:expire('ManJoin:' .. chatID .. ':users', ttl) -- chat ttl
		end
		local channels = {}
		local temp = redis:hgetall('ManJoin:' .. chatID .. ':channels') -- Get list of group channels
		if temp and #temp > 0 then -- Should not be empty 
			local i = 0
			local channelName
			for k, v in pairs(temp) do
				if i == 0 then
					channelName = k
					i = 1
				else
					local channelID = tonumber(k)
					channels[channelID] = channelName
					i = 0
				end
			end
		end
		for k, v in pairs(channels) do -- Set ttl for each one
			if ttl > 0 then
				local cttl = tonumber(redis:ttl('ManJoin:ttl:', k))
				redis:expire('ExpireDate:' .. k, math.max(ttl, cttl))
				redis:expire('CheckExpire::' .. k, math.max(ttl, cttl))
			else
				redis:persist('ExpireDate:' .. k)
				redis:persist('CheckExpire::' .. k)
			end
		end
	end
	-- clanUpTime == 0 ? Means no cleaning up is needed
	if cleanUpTime == 0 then return nil end
	local function cb (args, data)
		for k,v in pairs(data.messages_) do
			if (v.id_) then
				local oldMsgDate = v.date_
				if v.sender_user_id_ == our_id and msgDate - oldMsgDate >= cleanUpTime and v.content_.text_ and (v.content_.text_:find('لطفا پیش از ارسال هرگونه پیام در') or v.content_.text_:find('شما اکنون می‌توانید در گروه پیام ارسال کنید.')) then
					tdcli.deleteMessages(chatID, {[0] = v.id_}, dl_cb, nil)
				end
			end
		end
	end
	tdcli.getChatHistory(chatID, msgID ,0 , 100 ,cb, nil)	
end
local function is_chat_mod(msg)
	local data = load_data(_config.moderation.data)
	local userID = msg.sender_user_id_
	local chatID = msg.chat_id_
	if data[tostring(chatID)] and data[tostring(chatID)]['mods'] and data[chatID]['mods'][tostring(userID)] then return true end
	if data[tostring(chatID)] and data[tostring(chatID)]['owners'] and data[chatID]['owners'][tostring(userID)] then return true end
	return false
end

local function joinAndAddChannel(chatID, matches, isSudoChannel)
	local function getChat(args, data)
		local channelID
		if data.ID == "Chat" and data.type_ and data.type_.channel_ then -- Is a channel?
			channelID = data.id_
		else
			msgBody = '❌ آدرس کانال channelName معتبر نمی‌باشد!'
			msgBody = msgBody:gsub('channeName', matches[2]) -- Oh no!
			return nil
		end
		local function importChat(args1, data1)
			if data1.ID == 'Ok' or data1.message_ == 'USER_ALREADY_PARTICIPANT' then
				if isSudoChannel then
					if data.ID == "Chat" and data.type_ and data.type_.channel_ then
						local level
						local levelStr
						if matches[4]:lower() == 'mods' or matches[4] == 'مدیران' then
							level = 2
							levelStr = 'مدیران'
						elseif matches[4]:lower() == 'users' or matches[4] == 'کاربران' then
							level = 1
							levelStr = 'کاربران'
						elseif matches[4]:lower() == 'all' or matches[4] == 'همه' then
							level = 3
							levelStr = 'همه'
						else -- Waste of code? No, it's easy to understand kid!
							level = 3
							levelStr = 'همه'
						end
						local config = load_data(_config.moderation.data)
						config[channelID] = {}
						save_data(_config.moderation.data, config)
						redis:hset('ManJoin:sudo:channels', matches[2], level .. data.id_)
						redis:set('ExpireDate:'..data.id_,true)
						redis:set('CheckExpire::'..data.id_,true)
						msgBody = '✅ کانال channelName با موفقیت به لیست کانال‌های سودو اد شد.'
						msgBody = msgBody:gsub('channelName', matches[2])
						msgBody = msgBody .. '\nعضویت اجباری تنظیم شد برای: `' .. levelStr .. '`\n' ..'\nفراموش نکنید برای کارکرد پلاگین باید ربات را در کانال خود ادمین کنید.'
						msgBody = msgBody:gsub('_','\\_')
					end
				else
					local expireDate = tonumber(redis:ttl('ExpireDate:' .. chatID))
					local ttl = tonumber(redis:ttl('ManJoin:ttl:' .. data.id_))
					local cttl = math.max(ttl, expireDate)
					redis:hset('ManJoin:' .. chatID .. ':channels', matches[2], data.id_)
					if expireDate > 0 then
						redis:setex('ExpireDate:'..data.id_,expireDate,true)
						redis:setex('CheckExpire::'..data.id_, expireDate,true)
						if cttl > 0 then redis:expire('ManJoin:ttl:' .. data.id_, cttl) end
					else
						redis:set('ExpireDate:'..data.id_,true)
						redis:set('CheckExpire::'..data.id_,true)
					end
					msgBody = '✅ کانال channelName با موفقیت به لیست کانال‌های گروه اد شد.'
					msgBody = msgBody:gsub('channelName', matches[2]) ..'\nفراموش نکنید برای کارکرد پلاگین باید ربات را در کانال خود ادمین کنید.'
					msgBody = msgBody:gsub('_','\\_')
				end
			elseif data.message_ == 'Wrong invite link' then 
				msgBody = '❌ لینک جوین کانال channelName نامعتبر است.'
				msgBody = msgBody:gsub('channelName', matches[2])
				msgBody = msgBody:gsub('_','\\_')
			elseif data.code_ == 429 then
				msgBody = '❌ بیش از حد تلاش کردید. لطفا بعدا دوباره امتحان کنید.'
			end
			tdcli.sendMessage(chatID, 0, 1, msgBody, 1, 'md')
		end
		tdcli.importChatInviteLink(matches[3]:gsub('//[Tt]%.','//telegram.'), importChat, nil)
	end
	tdcli.searchPublicChat(matches[2], getChat, nil)
end
local function deleteChannel(chatID, matches, isSudoChannel)
	local channelID
	local channelName = matches[2]
	if isSudoChannel then
		channelID = redis:hget('ManJoin:sudo:channels', channelName)
		if channelID then
			channelID = tonumber(channelID:sub(2))
		end
	else
		channelID = redis:hget('ManJoin:' .. chatID .. ':channels',channelName)
		if channelID then channelID = tonumber(channelID) end
	end
	if channelID then
		local ttl = tonumber(redis:ttl('ManJoin:ttl:' .. channelID))
		if isSudoChannel then
			redis:expire('ExpireDate:' .. channelID, ttl)
			redis:expire('CheckExpire::' .. channelID, ttl)
			redis:hdel('ManJoin:sudo:channels', channelName) -- Delete from sudo channels
			msgBody = '✅ کانال channelName با موفقیت از لیست کانال‌های سودو حذف شد.'
			msgBody = msgBody:gsub('channelName', channelName)
			msgBody = msgBody:gsub('_','\\_')
		else
			redis:hdel('ManJoin:' .. chatID .. ':channels', channelName) -- Delete from group channels
			msgBody = '✅ کانال channelName با موفقیت از لیست کانال‌های گروه حذف شد.'
			msgBody = msgBody:gsub('channelName', channelName)
			msgBody = msgBody:gsub('_','\\_')
			if ttl < 1 then
				local config = load_data(_config.moderation.data)
				config[channelID] = nil
				save_data(_config.moderation.data, config)
				tdcli.changeChatMemberStatus(channelID, our_id, 'Left', dl_cb, nil)
			end
		end
		
	else
		msgBody = '❌ کانال channelName از ابتدا در لیست کانال‌ها نبود!'
		msgBody = msgBody:gsub('channelName', channelName)
		msgBody = msgBody:gsub('_','\\_')
	end
	tdcli.sendMessage(chatID, 0, 1, msgBody, 1, 'md')
	msgBody = nil
end
-----------------------------------------
local function run (msg, matches)
	msgBody = nil
	local chatID = msg.chat_id_
	local msgID = msg.id_
	local userID = msg.sender_user_id_
	local msgDate = tonumber(msg.date_)
	-- Get main config
	local config = redis:hmget('ManJoin:sudo:config', 'isActive', 'isActiveSudo', 'checkTime')
	local isActive = config[1] == 'true'
	local isActiveSudo = config[2] == 'true'
	local checkTime = config[3]
	if checkTime then checkTime = tonumber(checkTime) end
	local isActiveGroup
	local isSudoDisabled
	local cleanUpTime
	if isActive then
		-- Get group main config
		config = redis:hmget('ManJoin:' .. chatID .. ':config', 'isActiveGroup', 'cleanUpTime', 'isSudoDisabled')
		isActiveGroup = config[1] == 'true'
		isSudoDisabled = config[3] == 'true'
		if config[2] then cleanUpTime = tonumber(config[2]) end
	end
--------------------------------------	
	local function checkAdminCommands() -- This function processes admin commands
		if not matches[1] then return end
		if (matches[1]:lower() == 'manjoinglobal' or matches[1] == 'جوین اجباری گلوبال') then -- Global switch
			local switch = matches[2]:lower()
			if switch == 'on' or switch == 'enable' or switch == 'فعال' or switch == 'روشن' then
				local newConfig = {}
				table.insert(newConfig, 'isActive') -- Turn it on!
				table.insert(newConfig, true)
				if not checkTime then
					table.insert(newConfig, 'checkTime') -- First time? config checkTime
					table.insert(newConfig, 600)
				end
				if #newConfig > 2 then
					redis:hmset('ManJoin:sudo:config', unpack(newConfig)) -- Main config key
				else
					redis:hset('ManJoin:sudo:config', unpack(newConfig))
				end
				msgBody = '⚪️ جوین اجباری گلوبال `فعال` شد.'
				if isActive then msgBody = msgBody:gsub('شد', 'بود') end
			elseif switch == 'off' or switch == 'disable' or switch == 'غیرفعال' or switch == 'خاموش' then
				-- Turn it off
				redis:hset('ManJoin:sudo:config', 'isActive', false)
				msgBody = '⚫️ جوین اجباری گلوبال `غیرفعال` شد.'
				if not isActive then msgBody = msgBody:gsub('شد', 'بود') end
			else
				local status
				if isActive then status = 'فعال'
				else status = 'غیرفعال'
				end
				msgBody = '♻️ جوین اجباری گلوبال `status` است.'
				msgBody = msgBody:gsub('status', status)
			end
		elseif (matches[1]:lower() == 'manjoinignore' or matches[1] == 'نادیده گرفتن جوین اجباری') then -- Global switch
			local switch = matches[2]:lower()
			if switch == 'on' or switch == 'enable' or switch == 'فعال' or switch == 'روشن' then
				redis:hset('ManJoin:' .. chatID .. ':config', 'isSudoDisabled', true)
				msgBody = '⚫️ این چت از جوین اجباری `نادیده` گرفته شد.'
				if isSudoDisabled then msgBody = msgBody:gsub('شد', 'شده بود') end
			elseif switch == 'off' or switch == 'disable' or switch == 'غیرفعال' or switch == 'خاموش' then
				-- Turn it off
				redis:hset('ManJoin:' .. chatID .. ':config', 'isSudoDisabled', false)
				msgBody = '⚪️ جوین اجباری برای این چت `فعال` شد.'
				if not isSudoDisabled then msgBody = msgBody:gsub('شد', 'بود') end
			else
				local status
				if isSudoDisabled then status = 'فعال'
				else status = 'غیرفعال'
				end
				msgBody = '♻️ نادیده گرفتن جوین اجباری برای این چت `status` است.'
				msgBody = msgBody:gsub('status', status)
			end
		elseif (matches[1]:lower() == 'manjoinsudo' or matches[1] == 'جوین اجباری سودو') then -- Should user join sudo channels?
			local switch = matches[2]:lower()
			if switch == 'on' or switch == 'enable' or switch == 'فعال' or switch == 'روشن' then
				redis:hset('ManJoin:sudo:config', 'isActiveSudo', true)
				msgBody = '⚪️ جوین اجباری سودو `فعال` شد.'
				if isActiveSudo then msgBody = msgBody:gsub('شد', 'بود') end
			elseif switch == 'off' or switch == 'disable' or switch == 'غیرفعال' or switch == 'خاموش' then
				redis:hset('ManJoin:sudo:config', 'isActiveSudo', false)
				msgBody = '⚫️ جوین اجباری سودو `غیرفعال` شد.'
				if not isActiveSudo then msgBody = msgBody:gsub('شد', 'بود') end
			else
				local status
				if isActiveSudo then status = 'فعال'
				else status = 'غیرفعال'
				end
				msgBody = '♻️ جوین اجباری سودو `status` است.'
				msgBody = msgBody:gsub('status', status)
			end			
		elseif (matches[1]:lower() == 'addsudochannel' or matches[1] == 'افزودن کانال سودو') then -- Add sudo channel
			joinAndAddChannel(chatID, matches, true)
		elseif (matches[1]:lower() == 'remsudochannel' or matches[1] == 'حذف کانال سودو') then -- Remove sudo channel
			deleteChannel(chatID, matches, true)
		elseif (matches[1]:lower() == 'setchecktime' or matches[1] == 'تنظیم زمان چک') then --- Check time set
			local checkTime = tonumber(matches[2])
			if not checkTime or checkTime < 60 then checkTime = 60 end -- Don't put pressure on bot
			redis:hset('ManJoin:sudo:config', 'checkTime', checkTime) -- Main config key
			msgBody = '🔰 زمان چک تنظیم شد به: `checkTime`'
			msgBody = msgBody:gsub('checkTime', checkTime)
		elseif (matches[1]:lower() == 'getchecktime' or matches[1] == 'زمان چک') then -- Get check time
			checkTime = checkTime or 60
			msgBody = '🔰 زمان چک برابر است با: `checkTime`'
			msgBody = msgBody:gsub('checkTime', checkTime)
		elseif (matches[1]:lower() == 'sudochannels' or matches[1] == 'لیست کانال سودو') then
			msgBody = ''
			local mod_channels = redis:hgetall('ManJoin:sudo:channels')
			if mod_channels then
				for k, v in pairs(mod_channels) do
					msgBody = msgBody .. k .. '، '
					local level = tonumber(v:sub(1,1))
					local access
					if level == 3 then access = 'همه'
					elseif level == 2 then access = 'مدیران'
					elseif level == 1 then access = 'کاربران'
					end
					msgBody = msgBody .. 'سطح دسترسی: `' .. access .. '`\n'
				end
			end
			if msgBody == '' then msgBody = '❕ کانالی برای نمایش وجود ندارد!' end
			msgBody = msgBody:gsub('_','\\_')
		elseif (matches[1]:lower() == 'help manjoin sudo' or matches[1] == 'راهنمای جوین اجباری سودو') then
			msgBody = [[‏🇮🇷 راهنمای جوین اجباری مخصوص سودو:

_جوین اجباری گلوبال_ [`روشن`|`فعال`|`خاموش`|`غیرفعال`]
 *manjoinglobal* [`on`|`enable`|`off`|`disable`]
پلاگین را به صورت گلوبال روشن یا خاموش می‌کند. زمانی که پلاگین به صورت گلوبال خاموش شد عضویت در هیچ کانالی اعم از کانال‌های تعیین شده توسط صاحب گروه یا صاحب ربات چک نمی‌شود.

_جوین اجباری گلوبال_ 
 *manjoinglobal*
وضعیت جوین اجباری گلوبال را نمایش می‌دهد.

_جوین اجباری سودو_ [`روشن`|`فعال`|`خاموش`|`غیرفعال`]
*manjoinsudo* [`on`|`enable`|`off`|`disable`]
جوین اجباری کانال‌های مشخص شده توسط صاحب ربات را فعال|غیرفعال می‌کند. جوین به کانال‌های مشخص شده توسط صاحب ربات در تمامی گروه‌ها الزامیست.

_جوین اجباری سودو_
 *manjoinsudo*
وضعیت جوین اجباری سودو را نمایش می‌دهد.

_نادیده گرفتن جوین اجباری_ [`روشن`|`فعال`|`خاموش`|`غیرفعال`]
*manjoinignore* [`on`|`enable`|`off`|`disable`]
پلاگین جوین اجباری را در یک گپ خاص به طور کامل خاموش می‌کند. تنها توسط ادمین ربات قابل اجراست.

_نادیده گرفتن جوین اجباری_
 *manjoinignore*
وضعیت نادیده گرفتن جوین اجباری را در یک گپ خاص نشان می‌دهد.

_افزودن کانال سودو_ [@یوزرنیم] [لینک جوین] [`مدیران`|`کاربران`|`همه`]
*addsudochannel* [@username] [joinlink] [`mods`|`users`|`all`]
یک کانال را به لیست کانال‌های سودو اضافه می‌کند. پس از @ تگ کانال رو قرار دهید. لینک جوین نیز به صورت ...\https:\\t.me\joinchat می‌باشد که در هر کانال موجود است.
سطح دسترسی نیز سه مقدار مدیران کاربران و همه را می‌پذیرد. اگر کانالی را فقط برای مدیران مشخص کنید، تنها عضویت مدیران گروه‌ها در آن اجباری می‌شود. اگر کاربران را ملزم کنید فقط کاربران باید به عضویت آن کانال دربیایند و اگر برای همه الزامی کنید هم مدیران هم کاربران گروه‌ها باید عضو آن شوند. ادمین‌های ربات از این الزامات مستثنا هستند.

_تنظیم زمان چک_ `مقدار`
*setchecktime* `amount`
فاصله زمانی بین دو چک متوالی. مثلا اگر بر روی ۶۰۰ ثانیه تنظیم کنید، اگر در گروهی عضویت کاربری در کانال خاص چک شد، تا ۶۰۰ ثانیه مجددا چک نمی‌کند. پس از ۶۰۰ ثانیه عضویت وی در کانال چک خواهد شد. دلیل این کار کاهش فشار بر روی ربات می‌باشد. همچنین این زمان فاصله بین دو اخطار متوالی برای اشخاصی که به کانال‌های مشخص شده جوین نداده اند را تنظیم خواهد کرد. برای جلوگیری از ریپ چت شدن ربات این زمان را تا حد ممکن زیاد کنید.
این مقدار به صورت گلوبال تنظیم شده و در اختیار مدیران ربات است. پیشفرض = `600`

شما می‌توانید در ابتدای دستورات انگلیسی از کاراکترهای *!/#* استفاده کنید (اختیاری)

⚠️  برای جلوگیری از ریپ چت شدن ربات زمان چک را از ۵ دقیقه کمتر نکنید.
ضمنا بهتر است پیش از فعالسازی پلاگین در یک گروه خاص گروه را بیصدا کرده و پیامی مبنی بر الزامی بودن جوین کاربران به کانال‌های مدنظرتان را سنجاق کنید.
]]
		end
		if msgBody then tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1, 'md') end -- Send message if there is any
		msgBody = nil
	end
--------------------------------------	
	local function checkOwnerCommands() -- Processes owner commands
		if not matches[1] then return end
		if (matches[1]:lower() == 'manjoingroup' or matches[1] == 'جوین اجباری گروه') then -- Should user join owner specified channels?
			local switch = matches[2]:lower()
			if switch == 'on' or switch == 'enable' or switch == 'فعال' or switch == 'روشن' then -- Seems so
				local newConfig = {}
				table.insert(newConfig, 'isActiveGroup') -- Group config
				table.insert(newConfig, true)
				if not cleanUpTime then
					table.insert(newConfig, 'cleanUpTime') -- First time? OK, set cleanUpTime
					table.insert(newConfig, 0)
				end
				if #newConfig > 2 then
					redis:hmset('ManJoin:' .. chatID .. ':config', unpack(newConfig)) -- DO it
				else
					redis:hset('ManJoin:' .. chatID .. ':config', unpack(newConfig))
				end
				msgBody = '⚪️ جوین اجباری گروه ‍`فعال` شد.'
				if isActiveGroup then msgBody = msgBody:gsub('شد', 'بود') end
			elseif switch == 'off' or switch == 'disable' or switch == 'غیرفعال' or switch == 'خاموش' then -- Seems not
				redis:hset('ManJoin:' .. chatID .. ':config', 'isActiveGroup', false)
				msgBody = '⚫️ جوین اجباری گروه `غیرفعال` شد.'
				if not isActiveGroup then msgBody = msgBody:gsub('شد', 'بود') end
			else
				local status
				if isActiveGroup then status = 'فعال'
				else status = 'غیرفعال'
				end
				msgBody = '♻️ جوین اجباری گروه `status` است.'
				msgBody = msgBody:gsub('status', status)
			end			
		elseif (matches[1]:lower() == 'addchannel' or matches[1] == 'افزودن کانال') then
			joinAndAddChannel(chatID, matches, false) -- Add owner channel
		elseif (matches[1]:lower() == 'remchannel' or matches[1] == 'حذف کانال') then
			deleteChannel(chatID, matches, false) -- Remove owner channel
		elseif (matches[1]:lower() == 'setcleanuptime' or matches[1] == 'تنظیم زمان پاکسازی') then
			local newCleanUpTime = tonumber(matches[2])
			if not newCleanUpTime or newCleanUpTime < 0 then newCleanUpTime = 0 end -- Negative doesn't make sense
			redis:hset('ManJoin:' .. chatID .. ':config', 'cleanUpTime', newCleanUpTime)
			msgBody = '🔰 زمان پاکسازی تنظیم شد به: `cleanUpTime`'
			msgBody = msgBody:gsub('cleanUpTime', newCleanUpTime)
		elseif (matches[1]:lower() == 'getcleanuptime' or matches[1] == 'زمان پاکسازی') then
			cleanUpTime = cleanUpTime or 0
			msgBody = '🔰 زمان پاکسازی برابر است با: `checkTime`'
			msgBody = msgBody:gsub('checkTime', cleanUpTime)
		elseif (matches[1]:lower() == 'groupchannels' or matches[1] == 'لیست کانال گروه') then
			msgBody = ''
			local mod_channels = redis:hgetall('ManJoin:' .. chatID .. ':channels')
			if mod_channels then
				for k, v in pairs(mod_channels) do
					msgBody = msgBody .. k .. '\n'
				end
			end
			if msgBody == '' then msgBody = '❕ کانالی برای نمایش وجود ندارد!' end
			msgBody = msgBody:gsub('_','\\_')
		elseif (matches[1]:lower() == 'help manjoin' or matches[1] == 'راهنمای جوین اجباری') then
			msgBody = [[‏🇮🇷 راهنمای جوین جباری:

_جوین اجباری گروه_ [`روشن`|`فعال`|`خاموش`|`غیرفعال`]
*manjoingroup* [`on`|`enable`|`off`|`disable`]
جوین اجباری کانال‌های گروه را روشن یا خاموش می‌کند. کانال‌های گروه توسط صاحب گروه مشخص شده و عضویت در آن‌ها برای تمامی کاربران گروه الزامیست.

_جوین اجباری گروه_
*manjoingroup*
وضعیت جوین اجباری کانال‌های گروه را نشان می‌دهد.

_افزودن کانال_ [@یوزرنیم] 
*addchannel* [@username] [joinlink]
یک کانال را به لیست کانال‌های گروه اضافه می‌کند. پس از @ تگ کانال رو قرار دهید. لینک جوین نیز به صورت ...\https:\\t.me\joinchat می‌باشد که در هر کانال موجود است.
عضویت در این کانال‌ها تنها برای کاربران همان گروه الزامیست و در دیگر گروه‌ها تاثیری ندارد.

_تنظیم زمان پاکسازی_ `مقدار`
*setcleanuptime* `amount`
مشکل اشباع شدن گروه به واسطه ارسال پیام‌های هشدار توسط پلاگین وجود دارد. در این صورت می‌توانید مشخص کنید که پلاگین پس از مدت زمان مشخصی پیام‌های قبلی را پاک کند. مقدار صفر برابر با غیرفعال بودن این ویژگی می‌باشد. مقدار زمان پاکسازی در هر گروه توسط صاحب گروه تعیین می‌شود. پیشفرض = `0`

شما می‌توانید در ابتدای دستورات انگلیسی از کاراکترهای *!/#* استفاده کنید (اختیاری)

⚠️  برای جلوگیری از ریپ چت شدن ربات زمان چک را از ۵ دقیقه کمتر نکنید.
ضمنا بهتر است پیش از فعالسازی پلاگین در یک گروه خاص گروه را بیصدا کرده و پیامی مبنی بر الزامی بودن جوین کاربران به کانال‌های مدنظرتان را سنجاق کنید.
]]
		end
		if msgBody then tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1, 'md') end
	end
	if is_admin(msg) then
		-- Respect admin, process their message :|
		checkAdminCommands()
		-- Owner commands can only trigger when plugin is globally activated
		if isActive and not isSudoDisabled then checkOwnerCommands() end
	elseif isActive and not isSudoDisabled then
		local isMod = is_chat_mod(msg)
		-- Plugin should not work if it is not globally activated
		local channels = {}
		if isActiveSudo then -- Sudo channels should be checked only if sudo wants to do that
		-- Get sudo channels and add them to list
			 -- All channels which should be cheked
			local sudo_channels = redis:hgetall('ManJoin:sudo:channels')
			if sudo_channels then
				for k,v in pairs(sudo_channels) do
					local t = tonumber(v:sub(1,1))
					local channelID = tonumber(v:sub(2))
					if (t == 2 and isMod) or (t == 1 and not isMod) or t == 3 then
						channels[channelID] = k
					end
				end
			end
		end -- OK sudo channels added to list
		if isActiveGroup and not isMod then -- Oh poor user, you should also join mod channels
			local mod_channels = redis:hgetall('ManJoin:' .. chatID .. ':channels')
			if mod_channels then
				for k, v in pairs(mod_channels) do
					local channelID = tonumber(v)
					channels[v] = k
				end
			end 
		end -- OK list of group channels is added
		-- Checks if user|mod can send message?
		local shouldWarn
		local params = {}
		local joineChannels = {}
		-- Fetch user join data from group namespace inside redis
		for k, v in pairs(channels) do
			local hash = userID .. "_" .. k
			table.insert(params, hash)
		end
		local temp = {}
		if #params == 1 then
			local response = redis:hget('ManJoin:' .. chatID .. ':users', unpack(params))
			if response then table.insert(temp, response) end
		elseif #params >= 2 then
			temp = redis:hmget('ManJoin:' .. chatID .. ':users', unpack(params))
		end
		local i = #params
		local size = getTableSize(temp)
		for j = 1,size do
			if temp[j] then
				local joinTime = tonumber(temp[j])
				local shouldCheck = msgDate - math.abs(joinTime) >= checkTime
				if not shouldCheck and joinTime > 0 then i = i - 1 end
			end
		end
		local j = 1
		local limit = 0
		local dbUpdate = {}
		local deleted
		-- Joins checking loop
		for k, v in pairs(channels) do
			local channelID = k
			local channelName = v
			local hash = userID .. "_" .. channelID
			local joinTime
			if temp and temp[j] then joinTime = tonumber(temp[j]) end
			j = j + 1
			local joined
			local joinedBefore = false
			local shouldCheck = true
			if joinTime then -- Check if re check is needed
				joinedBefore = joinTime > 0 -- Negative values means user had't joined channel in the past
				if not joinedBefore then joinTime = -1 * joinTime end
				shouldCheck = msgDate - joinTime >= checkTime
			end
			-- This function checks a single user joining a single channel
			local function checkJoin(args, data)
				-- If bot is not channel admin this doesn't work
				joined = not (data.ID == "ChatMember" and data.status_ and data.status_.ID == "ChatMemberStatusLeft")
				-- Good to mention that ChatMemberStatusKicked is not being counted, as this is similiar to banning user. Not my business
				-- Joined and now is not joined or not joined and now joined means you shold warn 'em
				if (not joined and args.shouldCheck) or (joined and not args.joinedBefore) then
					shouldWarn = true
				end
				if joined then -- Delete this channel from list, we're done about it
					channels[args.channelID] = nil
					table.insert(dbUpdate, args.hash)
					table.insert(dbUpdate, msgDate) -- Last checked is now, update db
				else 
					if not deleted then
						tdcli.deleteMessages(chatID, {[0] = msgID}, dl_cb, nil) -- Delete message if it should be deleted
						msg.content_ = nil
						deleted = true
					end	
					if args.shouldCheck then
						table.insert(dbUpdate, args.hash)
						table.insert(dbUpdate, -1 * msgDate) -- Not joined users, negative values
					end
				end
				limit = limit + 1
				if limit == i then -- Dude, all groups should have been checked before I confirm this
					if (#dbUpdate > 2) then
						redis:hmset('ManJoin:' .. chatID .. ':users', unpack(dbUpdate)) -- Just pray for proper concurrency, POTENTIAL BUG
					elseif #dbUpdate ~= 0 then
						redis:hset('ManJoin:' .. chatID .. ':users', unpack(dbUpdate))
					end
					-- Now let's check if that user can send the message?
					if deleted then
						if shouldWarn then -- Should I tell them?
							msgBody = '❌ کاربر name لطفا پیش از ارسال هرگونه پیام در کانال‌های زیر عضو شوید:\n'
							for k, v in pairs(channels) do -- Append name of channels so they can join
								msgBody = msgBody .. v .. '\n'
							end
						end
					elseif shouldWarn then -- Oh tell the user that they are free now!
						msgBody = '✅ کاربر name شما اکنون می‌توانید در گروه پیام ارسال کنید.'
					end
					if shouldWarn then -- OK, what about cleaning up?
						local function cb(args, data)
							newMsgDate =  tonumber(data.date_) -- Warning message unix time
							postChecks(chatID, msgID, newMsgDate, cleanUpTime or 0) -- OK, post checks
						end
						local name = ''
						local firstName = msg.from.first_name
						local lastName = msg.from.last_name
						if firstName then name = name .. firstName end
						if lastName then name = name .. ' ' .. lastName end
						local length = name:len()
						msgBody = msgBody:gsub('name', name)
						--tdcli.sendMessage(chatID, msgID, 0, msgBody, 1, 'md')
						--Send message, Remember it by passing to call back
						tdcli_function ({
						ID = "SendMessage",
						chat_id_ = chatID,
						reply_to_message_id_ = msgID,
						disable_notification_ = 0, -- Let them know
						from_background_ = 1,
						reply_markup_ = nil,
						input_message_content_ = {
						ID = "InputMessageText",
						text_ = msgBody,
						disable_web_page_preview_ = 1,
						clear_draft_ = 0,
						entities_ = {[0] = {ID="MessageEntityMentionName", offset_=8, length_=length, user_id_ = msg.sender_user_id_}}, --add mention entity
						parse_mode_ = nil,
						},}, cb, nil)
						msgBody = nil
					end
					if not deleted then
						if is_owner(msg) then checkOwnerCommands() -- If it is not deleted, maybe it's for group owner, check for possible commands
						end
					end
				end
			end
			if shouldCheck or not joinedBefore then -- Fresh check or well if they are not currently joined to channel a check is needed
				tdcli.getChatMember(channelID, userID, checkJoin,
				{hash = hash, channelID = channelID, joinedBefore = joinedBefore, shouldCheck = shouldCheck})	
			end
		end
	end
end

local function pre_process(msg)
	if msg.adduser or msg.joinuser or msg.deluser then return end
	local text = msg.content_.text_ or msg.content_.caption_ 
	if text then
		for k, pattern in pairs(pts) do
			local matches = { string.match(text, pattern) }
			if matches and #matches > 0 then
					local result = run(msg, matches)
					if result then
						tdcli.sendMessage(msg.chat_id_, msg.id_, 0, result, 0, "html")
					end
				return
			end	
		end
	end
	run(msg, {})
end
return {
	pre_process = pre_process,
	patterns = {}
	}