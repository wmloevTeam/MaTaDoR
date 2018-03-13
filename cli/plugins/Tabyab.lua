--################### Begin Tabyab by @SaberTiger
local function tab_list(msg)
local i = 1
local tabgood = load_data(_config.moderation.tabgood)
	if not tabgood["users"] then
        return '> *no tabchi good user found*'
    end
	local mesg = "Tabchi Good Users:\n"
	for k,v in pairsByKeys(tabgood["users"]) do
		local id = v
		local username = redis:get("goodtab:"..id)
		local sold = "✖️"
		if redis:get("soldtabchi:"..id) then
			sold = "✅"
		end
		mesg = mesg .. "---------------------------------------- \n" .. i .. ". "..sold.."\n"
		mesg = mesg.."ID : "..id.."\n".."Username : "..username.."\n"
		if(i % 30 == 0) then
			mesg = check_markdown(mesg)
			tdcli.sendMessage(msg.to.id, msg.id_, 1, mesg , 1, 'md')
			mesg = ""
		end
		i = i+1
	end
	mesg = check_markdown(mesg)
	return mesg
end

--[[local function tab_file(msg) در صورت نیاز فعال کنید تا ب صورت فایل لیست 8 رقمیا بده :)
local i = 1
local tabgood = load_data(_config.moderation.tabgood)
	if not tabgood["users"] then
        return '> *no tabchi good user found*'
    end
	local mesg = "Tabchi Good Users:\n"
	for k,v in pairsByKeys(tabgood["users"]) do
		local id = v
		local username = redis:get("goodtab:"..id)
		local sold = "✖️"
		if redis:get("soldtabchi:"..id) then
			sold = "✔️"
		end
		mesg = mesg .. "---------------------------------------- \n" .. i .. ". "..sold.."\n"
		i = i+1
		mesg = mesg.."ID : "..id.."\n".."Username : "..username.."\n"
	end
	local file = io.open("./data/tabgoodlist.txt", "w")
      file:write(mesg)
      file:close()
      MaT = "tabchi good users : " .. i-1
    tdcli.sendDocument(msg.to.id, msg.id_,0, 1, nil, "./data/tabgoodlist.txt", MaT, dl_cb, nil)
end]]

local function run(msg, matches)
	if is_sudo(msg) then
		if matches[1]:lower() == "setout" or matches[1] == "تنظیم خروجی" then 
			redis:set("tabgoodgpid",matches[2])
			tdcli.sendMessage(msg.to.id, msg.id_, 1, "Messages was forward to : `"..matches[2].."`" , 1, 'md')
		end
		if matches[1]:lower() == "idlist" or matches[1] == "لیست ایدی" then 
			return tab_list(msg)
		end
		--[[if matches[1]:lower() == "tabfile" then 
			return tab_file(msg)
		end]]
		if matches[1]:lower() == "solve" or matches[1] == "حل" then 
			redis:set("soldtabchi:"..matches[2],true)
			tdcli.sendMessage(msg.to.id, msg.id_, 1, "User [ `"..matches[2].." | "..check_markdown(redis:get("goodtab:"..matches[2])).."` ] Has Been Solved!" , 1, 'md')
		end
		if matches[1]:lower() == "desolve" or matches[1] == "منحل" then 
			redis:del("soldtabchi:"..matches[2])
			tdcli.sendMessage(msg.to.id, msg.id_, 1, "User [ `"..matches[2].." | "..check_markdown(redis:get("goodtab:"..matches[2])).."` ] Has Been Desolved!" , 1, 'md')
		end
	end
end

local function pre_processx(msg)
	if (tonumber(msg.from.id) < 100000000) then
		local tabgood = load_data(_config.moderation.tabgood)  
		if not tabgood["users"] then
			tabgood["users"] = {}
			save_data(_config.moderation.tabgood, tabgood)
		end
		if  tabgood["users"][tostring(msg.from.id)] then
			if msg.from.username then
				username = "@"..msg.from.username
			else
				username = "NotFound"
			end
			redis:set("goodtab:"..msg.from.id,username)
		else
			tabgood["users"][tostring(msg.from.id)] = msg.from.id
			save_data(_config.moderation.tabgood, tabgood)
			idgp = redis:get("tabgoodgpid")
			tdcli.forwardMessages(idgp, msg.to.id , {[0] = msg.id}, 0,dl_cb,nil)
			if msg.from.username then
				username = "@"..msg.from.username
			else
				username = "NotFound"
			end
			tdcli.sendMessage(idgp, 0, 1, "ID : "..msg.from.id.."\nUsername : "..check_markdown(username).."\n\n\\_\\_\\_\\_\\_\\_\\_\\_\\_\\_\\_\\_\\_\\_" , 1, 'md')
			redis:set("goodtab:"..msg.from.id,username)
		end
	end
end

return
{
	patterns = {"^([Ii]dlist)$","^([Ss]etout) (.*)$","^([Ss]olve) (%d+)$","^([Dd]esolve) (%d+)$","^(لیست ایدی)$","^(تنظیم خروجی) (.*)$","^(حل) (%d+)$","^(منحل) (%d+)$"},
	pre_process = pre_processx,
	run = run
}
--################### End Tabyab by @Xamarin_Developer