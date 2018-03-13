local function run(msg, matches) 
if (matches[1]:lower() == "setmonshi" or matches[1] == "تنظیم منشی") and is_sudo(msg) then 
local pm = matches[2] 
redis:set('bot:pm',pm) 
return '`> متن منشی با موفقیت ثبت شد.`\n\n>>>  '..check_markdown(pm)..'' 
end 
if (matches[1]:lower() == "monshi" or matches[1] == "منشی") and not matches[2] and is_sudo(msg) then
local hash = ('bot:pm') 
    local pm = redis:get(hash) 
    if not pm then 
    return '`> متن منشی ثبت نشده است.`' 
    else 
	   return tdcli.sendMessage(msg.chat_id_ , 0, 1, '*> پیغام کنونی منشی :*\n\n'..check_markdown(pm), 0, 'md')
    end
end
if (matches[1]:lower() == "monshi" or matches[1] == "منشی") and is_sudo(msg) then 
if matches[2]=="on" or matches[2]=="فعال" then 
redis:set("bot:pm", "سلام من یک اکانت هوشمند هستم.")
return "`> منشی فعال شد لطفا دوباره پیغام را تنظیم کنید`" 
end 
if matches[2]=="off" or matches[2]=="غیرفعال" then 
redis:del("bot:pm")
return "`> منشی غیرفعال شد`" 
end
end
end

local function pre_process(msg)
if gp_type(msg.chat_id_) == "pv" and   msg.content_.text_ and not is_admin(msg) then
local chkmonshi = redis:get(msg.from.id..'chkusermonshi')
local hash = ('bot:pm') 
local pm = redis:get(hash)
if not chkmonshi then
redis:set(msg.from.id..'chkusermonshi', true)
tdcli.sendMessage(msg.chat_id_ , msg.id, 1, check_markdown(pm), 0, 'md')
tdcli.sendMessage(MaTaDoR_sudo , 0, 1,"*پیام :*\n"..check_markdown(msg.content_.text_).."\n*آیدی فرستنده :*\n`"..msg.sender_user_id_.."`", 0, 'md')
end
end 
end

return { 
patterns ={ 
"^[!#/](setmonshi) (.*)$", 
"^[!#/](monshi) (on)$", 
"^[!#/](monshi) (off)$", 
"^[!#/](monshi)$",
"^([Ss]etmonshi) (.*)$", 
"^([Mm]onshi) (on)$", 
"^([Mm]onshi) (off)$", 
"^([Mm]onshi)$",
"^(تنظیم منشی) (.*)$", 
"^(منشی) (فعال)$", 
"^(منشی) (غیرفعال)$", 
"^(منشی)$", 
}, 
run = run,
pre_process = pre_process
}