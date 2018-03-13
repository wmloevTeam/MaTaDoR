local function pre_process(msg)
	if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) then
		local hash = "gp_lang:"..msg.to.id
		local lang = redis:get(hash)
		local username = ''
		local add_lock = redis:hget('addmeminv', msg.to.id)
		local chkpm = redis:get(msg.from.id..'chkuserpm'..msg.to.id)
		if add_lock == 'on' then
			local setadd = redis:hget('addmemset', msg.to.id) or 10
			if msg.adduser then
				-- if you want can add robots, commented or deleted this codes
				if msg.content_.members_[0].type_.ID == 'UserTypeBot' then
						if not lang then
							return '> *Ƴσυ A∂∂є∂ α Rσвσт!*\n`Ƥℓєαѕє A∂∂ α Hυмαη! :)`'
						else
							return '> `شما یک ربات به گروه اضافه کردید`\n`لطفا یک کاربر عادی اضافه کنید.`'
						end
					return
				end
				-- until here
				if msg.from.username then
					username = '@'..check_markdown(msg.from.username)
				else
					username = check_markdown(msg.from.print_name)
				end
				if #msg.content_.members_ > 0 then
						if not lang then
							tdcli.sendMessage(msg.to.id, 0, 1, '*> Uѕєя :* '..username..'\n`Ƴσυ α∂∂є∂` *'..(#msg.content_.members_ + 1)..'* `Uѕєяѕ!`\nƁυт Oηє υѕєя ѕανє∂ ƒσя уσυ!\nƤℓєαѕє α∂∂ σηє ву σηє υѕєя.', 1, 'md')
						else
							tdcli.sendMessage(msg.to.id, 0, 1, '*> کاربر :* '..username..'\n`شما تعداد` *'..(#msg.content_.members_ + 1)..'* `کاربر را اضافه کردید!`\nاما فقط یک کاربر برای شما ذخیره شد!\nلطفا کاربران رو تک به تک اضافه کنید تا محدودیت برای شما برداشته شود', 1, 'md')
						end
				end
				local chash = msg.content_.members_[0].id_..'chkinvusr'..msg.from.id..'chat'..msg.to.id
				local chk = redis:get(chash)
				if not chk then
					redis:set(chash, true)
					local achash = 'addusercount'..msg.from.id
					local count = redis:hget(achash, msg.to.id) or 0
					redis:hset(achash, msg.to.id, (tonumber(count) + 1))
					local permit = redis:hget(achash, msg.to.id)
					if tonumber(permit) < tonumber(setadd) then
						local less = tonumber(setadd) - tonumber(permit)
							if not lang then
								tdcli.sendMessage(msg.to.id, 0, 1, '*> Uѕєя :* '..username..'\n`Ƴσυ α∂∂є∂` *'..permit..'* υѕєяѕ ιη тнιѕ gяσυρ.\nƳσυ мυѕт ιηνιтє *'..less..'* Oтнєя мємвєяѕ.', 1, 'md')
							else
								tdcli.sendMessage(msg.to.id, 0, 1, '*> کاربر :* '..username..'\n`شما تعداد` *'..permit..'* کاربر را به این گروه اضافه کردید.\nباید *'..less..'* کاربر دیگر برای رفع محدودیت چت اضافه کنید.', 1, 'md')
						end
					elseif tonumber(permit) == tonumber(setadd) then
							if not lang then
								tdcli.sendMessage(msg.to.id, 0, 1, '*> Uѕєя :* '..username..'\nƳσυ cαη ѕєη∂ мєѕѕαgєѕ ησω!', 1, 'md')
							else
								tdcli.sendMessage(msg.to.id, 0, 1, '*> کاربر :* '..username..'\nشما اکنون میتوانید پیام ارسال کنید.', 1, 'md')
							end
					end
				else
						if not lang then
							tdcli.sendMessage(msg.to.id, 0, 1, '*> Uѕєя :* '..username..'\nƳσυ αℓяєα∂у α∂∂є∂ тнιѕ υѕєя!', 1, 'md')
						else
							tdcli.sendMessage(msg.to.id, 0, 1, '*> کاربر :* '..username..'\nشما قبلا این کاربر را به گروه اضافه کرده اید!', 1, 'md')
						end
				end
			end
			local permit = redis:hget('addusercount'..msg.from.id, msg.to.id) or 0
			if tonumber(permit) < tonumber(setadd) then
				tdcli.deleteMessages(msg.to.id, {[0] = msg.id_}, dl_cb, nil)
				if not chkpm then
					redis:set(msg.from.id..'chkuserpm'..msg.to.id, true)
						tdcli.sendMessage(msg.to.id, 0, 1, '> کاربر : @'..(check_markdown(msg.from.username) or msg.from.print_name)..'\n شما باید '..setadd..'  کاربر برای رفع محدودیت چت اضافه کنید', 1, 'md')
				end
			end
		end
	end
end

local function run(msg, matches)
	if is_mod(msg) then
		local hash = "gp_lang:"..msg.to.id
		local lang = redis:get(hash)
		if matches[1]:lower() == 'unlock' or matches[1] == 'بازکردن' then
			if matches[2]:lower() == 'add' or matches[2] == 'محدودیت کاربر' then
				local add = redis:hget('addmeminv' ,msg.to.id)
				if not add then
					redis:hset('addmeminv', msg.to.id, 'off')
				end
				if add == 'on' then 
					redis:hset('addmeminv', msg.to.id, 'off')
					if not lang then
						return '> *Limit Add Member Hash Been* `Unlocked`'
					else
						return '> *محدودیت اضافه کردن کاربر* `غیرفعال` *شد*'
					end
				elseif add == 'off' then
					if not lang then
						return '> *Limit Add Member Is Already* `Unlocked`'
					else
						return '> *محدودیت اضافه کردن کاربر از قبل* `غیرفعال` *بود*'
					end
				end
			end
		end
		if matches[1]:lower() == 'lock' or matches[1] == 'قفل' then
			if matches[2]:lower() == 'add' or matches[2] == 'محدودیت کاربر' then
				local add = redis:hget('addmeminv' ,msg.to.id)
				if not add then
					redis:hset('addmeminv', msg.to.id, 'on')
				end
				if add == 'off' then 
					redis:hset('addmeminv', msg.to.id, 'on')
					if not lang then
						return '> *Limit Add Member Hash Been* `Locked`'
					else
						return '> *محدودیت اضافه کردن کاربر* `فعال` *شد*'
					end
				elseif add == 'on' then
					if not lang then
						return '> *Limit Add Member Is Already* `Locked`'
					else
						return '> *محدودیت اضافه کردن کاربر از قبل* `فعال` *بود*'
					end
				end
			end
		end
		if (matches[1]:lower() == 'setadd' or matches[1] == 'تنظیم محدودیت کاربر') and matches[2] then
			if tonumber(matches[2]) >= 1 and tonumber(matches[2]) <= 100 then
				redis:hset('addmemset', msg.to.id, matches[2])
				if not lang then
					return '> *Add Member Limit Set To:* `'.. matches[2]..'`'
				else
					return '> *تنظیم محدودیت اضافه کردن کاربر به:* `'.. matches[2]..'`'
				end
			else
				if not lang then
					return '> _Range Number is between_ *1 - 100*'
				else
					return '> _تعداد باید مابین_ `1 - 100` _باشد_'
				end
			end
		end
		if matches[1]:lower() == 'getadd' or matches[1] == 'نمایش محدودیت کاربر' then
			local getadd = redis:hget('addmemset', msg.to.id)
			if not lang then
				return '> *Add Member Limit:* `'..getadd..'`'
			else
				return '> *محدودیت اضافه کردن کاربر:* `'..getadd..'`'
			end
		end
	end
end
 
return {
  patterns = {
	'^[!/#]([Ll]ock) (.*)$',
	'^[!/#]([Uu]nlock) (.*)$',
	'^[!/#]([Ss]etadd) (%d+)$',
	'^[!/#]([Gg]etadd)$',
	'^([Ll]ock) (.*)$',
	'^([Uu]nlock) (.*)$',
	'^([Ss]etadd) (%d+)$',
	'^([Gg]etadd)$',
	'^(قفل) (.*)$',
	'^(بازکردن) (.*)$',
	'^(تنظیم محدودیت کاربر) (%d+)$',
	'^(نمایش محدودیت کاربر)$',
  },
  run = run,
  pre_process = pre_process
}
