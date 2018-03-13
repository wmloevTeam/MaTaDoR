local function MrRoO(msg)
if matches[1] == "وضعیت"  and not msg.forward_info_ then 
return tdcli_function({
						ID = "ForwardMessages",
						chat_id_ = msg.chat_id_,
						from_chat_id_ = msg.chat_id_,
						message_ids_ = {[0] = msg.id_},
						disable_notification_ = 0,
						from_background_ = 1
					}, dl_cb, nil)
end
end

return {
patterns ={"^(وضعیت)$"},
run= MrRoO
}
