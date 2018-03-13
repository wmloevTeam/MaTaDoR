local function khas(msg, matches)
    if matches[1]:lower () == 'addkick' or matches[1] == 'ادکردن مسدودیا' and is_admin(msg) then
        if gp_type(msg.chat_id_) == "channel" then
            tdcli.getChannelMembers(msg.chat_id_, 0, "Kicked", 200, function (i, ASN)
                for k,v in pairs(ASN.members_) do
                    tdcli.addChatMember(i.chat_id, v.user_id_, 50, dl_cb, nil)
                end
            end, {chat_id=msg.chat_id_})
            return "`اعضای محروم از گروه دوباره به گروه دعوت شدند`"
        end
        return "_😐 فقط در _`سوپر گروه`_ ممکن است_"
    end
end

return { 
patterns = { 
"^[!/#]([Aa]ddkick)$", 
"^([Aa]ddkick)$", 
"^(ادکردن مسدودیا)$",
},
run = khas 
}
---End By @SaberTiger