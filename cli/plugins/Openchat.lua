local function pre_process(msg)
if msg.chat_id_ then
      local id = tostring(msg.chat_id_)
      if id:match('-100(%d+)') then
        if not redis:sismember("ChatSuper:Bot",msg.chat_id_) then
          redis:sadd("ChatSuper:Bot",msg.chat_id_)
        end
----------------------------------
elseif id:match('^-(%d+)') then
if not  redis:sismember("Chat:Normal",msg.chat_id_) then
redis:sadd("Chat:Normal",msg.chat_id_)
end
-----------------------------------------
elseif id:match('') then
if not redis:sismember("ChatPrivite",msg.chat_id_) then

redis:sadd("ChatPrivite",msg.chat_id_)
end
   else
if not redis:sismember("ChatSuper:Bot",msg.chat_id_) then
redis:sadd("ChatSuper:Bot",msg.chat_id_)
end
end
---------
if not redis:get("OpenChat") or redis:ttl("OpenChat") == -2 then
 local open= redis:smembers("ChatSuper:Bot")
          for k,v in pairs(open) do
  tdcli.openChat(v)
    redis:setex("OpenChat", 110, true)
  end
end
end
if msg.to.type ~= "pv" then
	tdcli.openChat(msg.chat_id_, dl_cb, nil)
	tdcli.sendChatAction(bot.id, 'Typing', 100, dl_cb, nil)
end
end

return {
	patterns = {},
	pre_process = pre_process
}
