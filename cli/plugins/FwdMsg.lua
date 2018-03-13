local function run(msg, matches)
local chat_id = tostring(msg.chat_id_)
local reply_id = msg.reply_to_message_id_
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
if (matches[1]:lower() == "fwd" or matches[1] == "فوروارد") and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
-------------- sgps ---------------
if (matches[2] == "sgps" or matches[2] == "سوپر گروه") then
local gp = redis:smembers('su')
local gps = redis:scard('su')
for i=1, #gp do
sleep(0.5)
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'با موفقیت به '..gps..' [سوپرگروه] فوروارد شد', 1, 'md')
end
-------------- end sgps ---------------

-------------- gps ---------------
if (matches[2] == "gps" or matches[2] == "گروه") then
local gp = redis:smembers('gp')
local gps = redis:scard('gp')
for i=1, #gp do
sleep(0.5)
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'با موفقیت به '..gps..' [گروه] فوروارد شد', 1, 'md')
end
-------------- end gps ---------------

-------------- user ---------------
if (matches[2] == "user" or matches[2] == "کاربر") then
local gp = redis:smembers('user')
local gps = redis:scard('user')
for i=1, #gp do
sleep(0.5)
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'با موفقیت به '..gps..' [کاربر] فوروارد شد', 1, 'md')
end
-------------- end user ---------------

-------------- all ---------------
if (matches[2] == "all" or matches[2] == "همه") then
local gp = redis:smembers('user')
local gps = redis:scard('user')
for i=1, #gp do
sleep(0.5)
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
local gp = redis:smembers('su')
local gps = redis:scard('su')
for i=1, #gp do
sleep(0.5)
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
local gp = redis:smembers('gp')
local gps = redis:scard('gp')
for i=1, #gp do
sleep(0.5)
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'با موفقیت به '..gps..' [سوپرگروه/گروه/پیوی] فوروارد شد', 1, 'md')
end
-------------- end all ---------------
end
end

return {
patterns ={
"^[!#/]([Ff]wd) (.*)$",
"^([Ff]wd) (.*)$",
"^(فوروارد) (.*)$"
},
run=run
}