local function run(msg, matches)
if matches[1]:lower() == 'lock auto' or matches[1] == 'قفل خودکار' and is_mod(msg) then
io.popen("cp /usr/share/zoneinfo/Asia/Tehran /etc/localtime")
redis:setex("atolc"..msg.chat_id_..msg.sender_user_id_,45,true)
if redis:get("atolct1"..msg.chat_id_) and redis:get("atolct2"..msg.chat_id_) then
redis:del("atolct1"..msg.chat_id_)
redis:del("atolct2"..msg.chat_id_)
redis:del("lc_ato:"..msg.chat_id_)
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'زمان قبلی از سیستم حذف شد\n\nلطفا زمان شروع قفل خودکار را وارد کنید :\nمثال :\n 00:00', 1, 'md')
else
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'لطفا زمان شروع قفل خودکار را وارد کنید :\nمثال :\n 15:24', 1, 'md')
end
elseif matches[1]:lower() == 'unlock auto' or matches[1] == 'بازکردن خودکار' and is_mod(msg) then
if redis:get("atolct1"..msg.chat_id_) and redis:get("atolct2"..msg.chat_id_) then
redis:del("atolct1"..msg.chat_id_)
redis:del("atolct2"..msg.chat_id_)
redis:del("lc_ato:"..msg.chat_id_)
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'زمانبدی ربات برای قفل کردن خودکار گروه حذف شد', 1, 'md')
else
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'قفل خودکار از قبل غیرفعال بود', 1, 'md')
end
elseif (matches[1] == "00" or matches[1] == "01" or matches[1] == "02" or matches[1] == "03" or matches[1] == "04" or matches[1] == "05" or matches[1] == "06" or matches[1] == "07" or matches[1] == "08" or matches[1] == "09" or matches[1] == "10" or matches[1] == "11" or matches[1] == "12" or matches[1] == "13" or matches[1] == "14" or matches[1] == "15" or matches[1] == "16" or matches[1] == "17" or matches[1] == "18" or matches[1] == "19" or matches[1] == "20" or matches[1] == "21" or matches[1] == "22" or matches[1] == "23") and (matches[2] == "00" or matches[2] == "01" or matches[2] == "02" or matches[2] == "03" or matches[2] == "04" or matches[2] == "05" or matches[2] == "06" or matches[2] == "07" or matches[2] == "08" or matches[2] == "09" or matches[2] == "10" or matches[2] == "11" or matches[2] == "12" or matches[2] == "13" or matches[2] == "14" or matches[2] == "15" or matches[2] == "16" or matches[2] == "17" or matches[2] == "18" or matches[2] == "19" or matches[2] == "20" or matches[2] == "21" or matches[2] == "22" or matches[2] == "23" or matches[2] == "24" or matches[2] == "25" or matches[2] == "26" or matches[2] == "27" or matches[2] == "28" or matches[2] == "29" or matches[2] == "30" or matches[2] == "31" or matches[2] == "32" or matches[2] == "33" or matches[2] == "34" or matches[2] == "35" or matches[2] == "36" or matches[2] == "37" or matches[2] == "38" or matches[2] == "39" or matches[2] == "40" or matches[2] == "41" or matches[2] == "42" or matches[2] == "43" or matches[2] == "44" or matches[2] == "45" or matches[2] == "46" or matches[2] == "47" or matches[2] == "48" or matches[2] == "49" or matches[2] == "50" or matches[2] == "51" or matches[2] == "52" or matches[2] == "53" or matches[2] == "54" or matches[2] == "55" or matches[2] == "56" or matches[2] == "57" or matches[2] == "58" or matches[2] == "59") and redis:get("atolc"..msg.chat_id_..msg.sender_user_id_) and is_mod(msg) then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'زمان شروع قفل خودکار در سیستم ثبت شد.\n\nلطفا زمان پایان قفل خودکار را وارد کنید :\nمثال :\n 07:00', 1, 'md')
redis:del("atolc"..msg.chat_id_..msg.sender_user_id_)
redis:setex("atolct1"..msg.chat_id_,45,matches[1]..':'..matches[2])
redis:setex("atolc2"..msg.chat_id_..msg.sender_user_id_,45,true)
elseif (matches[1] == "00" or matches[1] == "01" or matches[1] == "02" or matches[1] == "03" or matches[1] == "04" or matches[1] == "05" or matches[1] == "06" or matches[1] == "07" or matches[1] == "08" or matches[1] == "09" or matches[1] == "10" or matches[1] == "11" or matches[1] == "12" or matches[1] == "13" or matches[1] == "14" or matches[1] == "15" or matches[1] == "16" or matches[1] == "17" or matches[1] == "18" or matches[1] == "19" or matches[1] == "20" or matches[1] == "21" or matches[1] == "22" or matches[1] == "23") and (matches[2] == "00" or matches[2] == "01" or matches[2] == "02" or matches[2] == "03" or matches[2] == "04" or matches[2] == "05" or matches[2] == "06" or matches[2] == "07" or matches[2] == "08" or matches[2] == "09" or matches[2] == "10" or matches[2] == "11" or matches[2] == "12" or matches[2] == "13" or matches[2] == "14" or matches[2] == "15" or matches[2] == "16" or matches[2] == "17" or matches[2] == "18" or matches[2] == "19" or matches[2] == "20" or matches[2] == "21" or matches[2] == "22" or matches[2] == "23" or matches[2] == "24" or matches[2] == "25" or matches[2] == "26" or matches[2] == "27" or matches[2] == "28" or matches[2] == "29" or matches[2] == "30" or matches[2] == "31" or matches[2] == "32" or matches[2] == "33" or matches[2] == "34" or matches[2] == "35" or matches[2] == "36" or matches[2] == "37" or matches[2] == "38" or matches[2] == "39" or matches[2] == "40" or matches[2] == "41" or matches[2] == "42" or matches[2] == "43" or matches[2] == "44" or matches[2] == "45" or matches[2] == "46" or matches[2] == "47" or matches[2] == "48" or matches[2] == "49" or matches[2] == "50" or matches[2] == "51" or matches[2] == "52" or matches[2] == "53" or matches[2] == "54" or matches[2] == "55" or matches[2] == "56" or matches[2] == "57" or matches[2] == "58" or matches[2] == "59") and redis:get("atolc2"..msg.chat_id_..msg.sender_user_id_) and is_mod(msg) then
local time_1 = redis:get("atolct1"..msg.chat_id_)
if time_1 == matches[1]..':'..matches[2] then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'آغاز قفل خودکار نمیتوانید با پایان آن یکی باشد', 1, 'md')
else
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'عملیات با موقیت انجام شد.\n\nگروه شما در ساعت *'..time_1..'* الی *'..matches[1]..':'..matches[2]..'* بصورت خودکار تعطیل خواهد شد.', 1, 'md')
redis:set("atolct1"..msg.chat_id_,redis:get("atolct1"..msg.chat_id_))
redis:set("atolct2"..msg.chat_id_,matches[1]..':'..matches[2])
redis:del("atolc2"..msg.chat_id_..msg.sender_user_id_)
end
elseif matches[1]:lower() == 'server time' or matches[1]== 'زمان سرور' and is_sudo(msg) then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '['..os.date("%H:%M:%S")..']', 1, 'md')
end
end


local function pre_process(msg)
if redis:get("atolct2"..msg.chat_id_) or redis:get("atolct2"..msg.chat_id_) then
local time = os.date("%H%M")
local time2 = redis:get("atolct1"..msg.chat_id_)
time2 = time2.gsub(time2,":","")
local time3 = redis:get("atolct2"..msg.chat_id_)
time3 = time3.gsub(time3,":","")
if tonumber(time3) < tonumber(time2) then
if tonumber(time) <= 2359 and tonumber(time) >= tonumber(time2) then
if not redis:get("lc_ato:"..msg.chat_id_) then
redis:set("lc_ato:"..msg.chat_id_,true)
tdcli.sendMessage(msg.chat_id_, 0, 1, 'قفل خودکار ربات فعال شد\nگروه تا ساعت *'..redis:get("atolct2"..msg.chat_id_)..'* تعطیل میباشد.', 1, 'md')
end
elseif tonumber(time) >= 0000 and tonumber(time) < tonumber(time3) then
if not redis:get("lc_ato:"..msg.chat_id_) then
tdcli.sendMessage(msg.chat_id_, 0, 1, 'قفل خودکار ربات فعال شد\nگروه تا ساعت *'..redis:get("atolct2"..msg.chat_id_)..'* تعطیل میباشد.', 1, 'md')
redis:set("lc_ato:"..msg.chat_id_,true)
end
else
if redis:get("lc_ato:"..msg.chat_id_) then
redis:del("lc_ato:"..msg.chat_id_, true)
end
end
elseif tonumber(time3) > tonumber(time2) then
if tonumber(time) >= tonumber(time2) and tonumber(time) < tonumber(time3) then
if not redis:get("lc_ato:"..msg.chat_id_) then
tdcli.sendMessage(msg.chat_id_, 0, 1, 'قفل خودکار ربات فعال شد\nگروه تا ساعت *'..redis:get("atolct2"..msg.chat_id_)..'* تعطیل میباشد.', 1, 'md')
redis:set("lc_ato:"..msg.chat_id_,true)
end
else
if redis:get("lc_ato:"..msg.chat_id_) then
redis:del("lc_ato:"..msg.chat_id_, true)
end
end
end
end
local is_channel = msg.to.type == "channel"
local is_chat = msg.to.type == "chat"
if redis:get("lc_ato:"..msg.chat_id_) then
if not is_mod(msg) then
if is_channel then
del_msg(msg.chat_id_, tonumber(msg.id))
elseif is_chat then
kick_user(msg.sender_user_id_, msg.chat_id_)
end
end
end
end
return { 
patterns = {
"^[/!#]([sS][eE][rR][vV][eE][rR] [tT][iI][mM][eE])$",
"^[/!#]([lL][oO][cC][kK] [aA][uU][tT][oO])$",
"^[/!#]([uU][nN][lL][oO][cC][kK] [aA][uU][tT][oO])$",
"^([sS][eE][rR][vV][eE][rR] [tT][iI][mM][eE])$",
"^([lL][oO][cC][kK] [aA][uU][tT][oO])$",
"^([uU][nN][lL][oO][cC][kK] [aA][uU][tT][oO])$",
"^(قفل خودکار)$",
"^(زمان سرور)$",
"^(بازکردن خودکار)$",
"^(%d+):(%d+)$"
},
run = run,
pre_process = pre_process
}