local function run(msg, matches)
if matches[1]:lower() == "setnamezarin" or matches[1]:lower() == "تنظیم نام زرین" then
redis:set("setnamezarinpal",matches[2])
return "*نام درگاه زرین پال ثبت شد :*\n"..matches[2]
end
if matches[1]:lower() == "setzarin" or matches[1]:lower() == "تنظیم زرین" then
redis:set("setzarinpallink",matches[2])
return "*لینک درگاه زرین پال ثبت شد :*\n"..matches[2]
end

if matches[1]:lower() == "zarin" or matches[1]:lower() == "زرین"  then
local zarinpalname = redis:get("setnamezarinpal")
local zarinpallink = redis:get("setzarinpallink")
if tonumber(matches[2]) < 1000 then
return "`مبلغ وارد شده باید بیشتر از هزار تومن باشد.`"
end
if not zarinpalname then
return "*لطفا ابتدا نام اکانت زرین پال خود را تنظیم کنید.*\n`مثال :`\n/setnamezarin mahdi mohseni"
end
if not zarinpallink then
return "*لطفا ابتدا لینک اکانت زرین پال خود را تنظیم کنید.*\n`مثال :`\n/setzarin mahdiroo"
end
texth = "پرداخت مبلغ "..matches[2].." تومان به "..zarinpalname..""
local function zarinpal(TM, MR)
      if MR.results_ and MR.results_[0] then
tdcli.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, MR.inline_query_id_, MR.results_[0].id_, dl_cb, nil)
    else
       text = "لطفا ابتدا با اکانت ربات @bold را استارت کنید"
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "html")
   end
end
tdcli.getInlineQueryResults(107705060, msg.to.id, 0, 0, "[ "..texth.."](https://www.zarinp.al/"..zarinpallink.."/"..matches[2]..")", 0, zarinpal, nil)
end 
end

return {
patterns ={
"^[#!/]([Zz]arin) (%d+)$",
"^([Zz]arin) (%d+)$",
"^[#!/]([Ss]etnamezarin) (.*)$",
"^([Ss]etnamezarin) (.*)$",
"^[#!/]([Ss]etzarin) (.*)$",
"^([Ss]etzarin) (.*)$",
"^(زرین) (%d+)$",
"^(تنظیم زرین) (.*)$",
"^(تنظیم نام زرین) (.*)$",
},
run=run,
}
