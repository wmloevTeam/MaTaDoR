local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
--------------------------------
local api_key = nil
local base_api = "https://maps.googleapis.com/maps/api"
--------------------------------
local function get_latlong(area)
	local api      = base_api .. "/geocode/json?"
	local parameters = "address=".. (URL.escape(area) or "")
	if api_key ~= nil then
		parameters = parameters .. "&key="..api_key
	end
	local res, code = https.request(api..parameters)
	if code ~=200 then return nil  end
	local data = json:decode(res)
	if (data.status == "ZERO_RESULTS") then
		return nil
	end
	if (data.status == "OK") then
		lat  = data.results[1].geometry.location.lat
		lng  = data.results[1].geometry.location.lng
		acc  = data.results[1].geometry.location_type
		types= data.results[1].types
		return lat,lng,acc,types
	end
end
--------------------------------
local function get_staticmap(area)
	local api        = base_api .. "/staticmap?"
	local lat,lng,acc,types = get_latlong(area)
	local scale = types[1]
	if scale == "locality" then
		zoom=8
	elseif scale == "country" then 
		zoom=4
	else 
		zoom = 13 
	end
	local parameters =
		"size=600x300" ..
		"&zoom="  .. zoom ..
		"&center=" .. URL.escape(area) ..
		"&markers=color:red"..URL.escape("|"..area)
	if api_key ~= nil and api_key ~= "" then
		parameters = parameters .. "&key="..api_key
	end
	return lat, lng, api..parameters
end
--------------------------------
local function get_weather(location)
	print("Finding weather in ", location)
	local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
	local url = BASE_URL
	url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
	url = url..'&units=metric'
	local b, c, h = http.request(url)
	if c ~= 200 then return nil end
	local weather = json:decode(b)
	local city = weather.name
	local country = weather.sys.country
	local temp = 'دمای شهر '..city..' هم اکنون '..weather.main.temp..' درجه سانتی گراد می باشد\n____________________'
	local conditions = 'شرایط فعلی آب و هوا : '
	if weather.weather[1].main == 'Clear' then
		conditions = conditions .. 'آفتابی☀'
	elseif weather.weather[1].main == 'Clouds' then
		conditions = conditions .. 'ابری ☁☁'
	elseif weather.weather[1].main == 'Rain' then
		conditions = conditions .. 'بارانی ☔'
	elseif weather.weather[1].main == 'Thunderstorm' then
		conditions = conditions .. 'طوفانی ☔☔☔☔'
	elseif weather.weather[1].main == 'Mist' then
		conditions = conditions .. 'مه 💨'
	end
	return temp .. '\n' .. conditions
end
--------------------------------
local function calc(exp)
	url = 'http://api.mathjs.org/v1/'
	url = url..'?expr='..URL.escape(exp)
	b,c = http.request(url)
	text = nil
	if c == 200 then
    text = 'Result = '..b..'\n____________________'
	elseif c == 400 then
		text = b
	else
		text = 'Unexpected error\n'
		..'Is api.mathjs.org up?'
	end
	return text
end
--------------------------------
function run(msg, matches)
if ((matches[1]:lower() == 'calc' ) or (matches[1]:lower() == 'ماشین حساب' )) and is_mod(msg) and matches[2] then 
		if msg.to.type == "pv" then 
			return 
       end
		return calc(matches[2])
end
--------------------------------
if ((matches[1]:lower() == 'praytime' ) or (matches[1]:lower() == 'ساعات شرعی' )) and is_mod(msg) then
		if matches[2] then
			city = matches[2]
		end
		local lat,lng,url	= get_staticmap(city)
		local dumptime = run_bash('date +%s')
		local code = http.request('http://api.aladhan.com/timings/'..dumptime..'?latitude='..lat..'&longitude='..lng..'&timezonestring=Asia/Tehran&method=7')
		local jdat = json:decode(code)
		local data = jdat.data.timings
		local text = 'شهر: '..city
		text = text..'\nاذان صبح: '..data.Fajr
		text = text..'\nطلوع آفتاب: '..data.Sunrise
		text = text..'\nاذان ظهر: '..data.Dhuhr
		text = text..'\nغروب آفتاب: '..data.Sunset
		text = text..'\nاذان مغرب: '..data.Maghrib
		text = text..'\nعشاء : '..data.Isha
		text = text
		return tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
end
--------------------------------
	if ((matches[1]:lower() == 'weather' ) or (matches[1]:lower() == 'اب و هوا')) and is_mod(msg) then
		city = matches[2]
		local wtext = get_weather(city)
		if not wtext then
			wtext = 'مکان وارد شده صحیح نیست'
		end
		return wtext
	end
--------------------------------
if ((matches[1]:lower() == 'time') or (matches[1] == "ساعت")) and is_mod(msg) then
	local url , res = http.request('http://probot.000webhostapp.com/api/time.php/')
if res ~= 200 then return "No connection" end

local jdat = json:decode(url)
local text = '*ساعت ایران:* _'..jdat.FAtime..'_\n*تاریخ ایران:* _'..jdat.FAdate..'_\n------------\n*En Time:* _'..jdat.ENtime..'_\n *En Data:* _'..jdat.ENdate.. '_\n'
  tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
--------------------------------
	if ((matches[1]:lower() == 'tr' ) or (matches[1]:lower() == 'ترجمه' )) and is_mod(msg) then 
		url = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[2])..'&text='..URL.escape(matches[3]))
		data = json:decode(url)
		return 'زبان : '..data.lang..'\nترجمه : '..data.text[1]..'\n____________________'
	end
--------------------------------
if ((matches[1]:lower() == "sticker") or (matches[1] == "استیکر")) and is_mod(msg) then 
local logo = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'} 
local text = URL.escape(matches[2])
local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..logo[math.random(#logo)]..'&text='..text..'&symbol_tagname=popular&fontsize=100&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=100&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=400&scaleHeight=200&&_=1469943010141' 
local title , res = http.request(url) 
local jdat = json:decode(title) 
local sticker = jdat.src 
local file = download_to_file(sticker,'byroo.webp') 
     tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, file, '', dl_cb, nil) 
end
--------------------------------
if ((matches[1]:lower() == "gif") or (matches[1] == "گیف")) and is_mod(msg) then
        local modes = {'memories-anim-logo','alien-glow-anim-logo','flash-anim-logo','flaming-logo','whirl-anim-logo','highlight-anim-logo','burn-in-anim-logo','shake-anim-logo','inner-fire-anim-logo','jump-anim-logo'}
        local text = URL.escape(matches[2]) 
        local url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..modes[math.random(#modes)]..'&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
        local title , res = http.request(url2)
        local jdat = json:decode(title)
        local gif = jdat.src
        local file = download_to_file(gif,'byroo.gif')
        tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, file, '', dl_cb, nil)
 end
--------------------------------
if ((matches[1]:lower() == "photo") or (matches[1] == "عکس" )) and is_mod(msg) then 
local logo = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'} 
local text = URL.escape(matches[2])
local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..logo[math.random(#logo)]..'&text='..text..'&symbol_tagname=popular&fontsize=100&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=100&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=400&scaleHeight=200&&_=1469943010141' 
local title , res = http.request(url) 
local jdat = json:decode(title) 
local sticker = jdat.src 
local file = download_to_file(sticker,'byroo.jpg') 
    tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, file, "", dl_cb, nil)
end
--------------------------------
if ((matches[1]:lower() == "write") or (matches[1] == "نوشتن")) and is_mod(msg) then

	if #matches < 2 then
		return "بعد از این دستور، با قید یک فاصله کلمه یا جمله ی مورد نظر را جهت زیبا نویسی وارد کنید"
	end
	if string.len(matches[2]) > 20 then
		 tdcli.sendMessage(msg.chat_id_, 0, 1, "حداکثر حروف مجاز 20 کاراکتر انگلیسی و عدد است", 1, 'html')
	end
	local font_base = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_"
	local font_hash = "z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,0,1,2,3,4,5,6,7,8,9,.,_"
	local fonts = {
		"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
		"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
		"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",		"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
		"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
		"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
		"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
		"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
		"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
		"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,Ⴆ,ƈ,ԃ,ҽ,ϝ,ɠ,ԋ,ι,ʝ,ƙ,ʅ,ɱ,ɳ,σ,ρ,ϙ,ɾ,ʂ,ƚ,υ,ʋ,ɯ,x,ყ,ȥ,α,Ⴆ,ƈ,ԃ,ҽ,ϝ,ɠ,ԋ,ι,ʝ,ƙ,ʅ,ɱ,ɳ,σ,ρ,ϙ,ɾ,ʂ,ƚ,υ,ʋ,ɯ,x,ყ,ȥ,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
		"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",
		"მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,0,Գ,Ց,Դ,6,5,Վ,Յ,Զ,1,.,_",
		"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"Δ,Ɓ,C,D,Σ,F,G,H,I,J,Ƙ,L,Μ,∏,Θ,Ƥ,Ⴓ,Γ,Ѕ,Ƭ,Ʊ,Ʋ,Ш,Ж,Ψ,Z,λ,ϐ,ς,d,ε,ғ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"Λ,ß,Ƈ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,Λ,ß,Ƈ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
		"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,0,9,8,7,6,5,4,3,2,1,.,_",
		"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
		"Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
		"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
		"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,0,9,8,7,6,5,4,3,2,1,.,_",
		"Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,0,9,8,7,6,5,4,3,2,1,.,_",
		"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,0,9,8,7,6,5,4,3,2,1,.,_",
		"Λ,M,X,ʎ,Z,ɐ,q,ɔ,p,ǝ,ɟ,ƃ,ɥ,ı,ɾ,ʞ,l,ա,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,Λ,M,X,ʎ,Z,ɐ,q,ɔ,p,ǝ,ɟ,ƃ,ɥ,ı,ɾ,ʞ,l,ա,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,‾",
		"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
		"A̱,̱Ḇ,̱C̱,̱Ḏ,̱E̱,̱F̱,̱G̱,̱H̱,̱I̱,̱J̱,̱Ḵ,̱Ḻ,̱M̱,̱Ṉ,̱O̱,̱P̱,̱Q̱,̱Ṟ,̱S̱,̱Ṯ,̱U̱,̱V̱,̱W̱,̱X̱,̱Y̱,̱Ẕ,̱a̱,̱ḇ,̱c̱,̱ḏ,̱e̱,̱f̱,̱g̱,̱ẖ,̱i̱,̱j̱,̱ḵ,̱ḻ,̱m̱,̱ṉ,̱o̱,̱p̱,̱q̱,̱ṟ,̱s̱,̱ṯ,̱u̱,̱v̱,̱w̱,̱x̱,̱y̱,̱ẕ,̱0̱,̱9̱,̱8̱,̱7̱,̱6̱,̱5̱,̱4̱,̱3̱,̱2̱,̱1̱,̱.̱,̱_̱",
		"A̲,̲B̲,̲C̲,̲D̲,̲E̲,̲F̲,̲G̲,̲H̲,̲I̲,̲J̲,̲K̲,̲L̲,̲M̲,̲N̲,̲O̲,̲P̲,̲Q̲,̲R̲,̲S̲,̲T̲,̲U̲,̲V̲,̲W̲,̲X̲,̲Y̲,̲Z̲,̲a̲,̲b̲,̲c̲,̲d̲,̲e̲,̲f̲,̲g̲,̲h̲,̲i̲,̲j̲,̲k̲,̲l̲,̲m̲,̲n̲,̲o̲,̲p̲,̲q̲,̲r̲,̲s̲,̲t̲,̲u̲,̲v̲,̲w̲,̲x̲,̲y̲,̲z̲,̲0̲,̲9̲,̲8̲,̲7̲,̲6̲,̲5̲,̲4̲,̲3̲,̲2̲,̲1̲,̲.̲,̲_̲",
		"Ā,̄B̄,̄C̄,̄D̄,̄Ē,̄F̄,̄Ḡ,̄H̄,̄Ī,̄J̄,̄K̄,̄L̄,̄M̄,̄N̄,̄Ō,̄P̄,̄Q̄,̄R̄,̄S̄,̄T̄,̄Ū,̄V̄,̄W̄,̄X̄,̄Ȳ,̄Z̄,̄ā,̄b̄,̄c̄,̄d̄,̄ē,̄f̄,̄ḡ,̄h̄,̄ī,̄j̄,̄k̄,̄l̄,̄m̄,̄n̄,̄ō,̄p̄,̄q̄,̄r̄,̄s̄,̄t̄,̄ū,̄v̄,̄w̄,̄x̄,̄ȳ,̄z̄,̄0̄,̄9̄,̄8̄,̄7̄,̄6̄,̄5̄,̄4̄,̄3̄,̄2̄,̄1̄,̄.̄,̄_̄",
		"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
		"a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"@,♭,ḉ,ⓓ,℮,ƒ,ℊ,ⓗ,ⓘ,נ,ⓚ,ℓ,ⓜ,η,ø,℘,ⓠ,ⓡ,﹩,т,ⓤ,√,ω,ж,૪,ℨ,@,♭,ḉ,ⓓ,℮,ƒ,ℊ,ⓗ,ⓘ,נ,ⓚ,ℓ,ⓜ,η,ø,℘,ⓠ,ⓡ,﹩,т,ⓤ,√,ω,ж,૪,ℨ,0,➈,➑,➐,➅,➄,➃,➌,➁,➊,.,_",
		"@,♭,¢,ⅾ,ε,ƒ,ℊ,ℌ,ї,נ,к,ℓ,м,п,ø,ρ,ⓠ,ґ,﹩,⊥,ü,√,ω,ϰ,૪,ℨ,@,♭,¢,ⅾ,ε,ƒ,ℊ,ℌ,ї,נ,к,ℓ,м,п,ø,ρ,ⓠ,ґ,﹩,⊥,ü,√,ω,ϰ,૪,ℨ,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,♭,ḉ,∂,ℯ,ƒ,ℊ,ℌ,ї,ʝ,ḱ,ℓ,м,η,ø,℘,ⓠ,я,﹩,⊥,ц,ṽ,ω,ჯ,૪,ẕ,α,♭,ḉ,∂,ℯ,ƒ,ℊ,ℌ,ї,ʝ,ḱ,ℓ,м,η,ø,℘,ⓠ,я,﹩,⊥,ц,ṽ,ω,ჯ,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
		"@,ß,¢,ḓ,℮,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,м,п,◎,℘,ⓠ,я,﹩,т,ʊ,♥️,ẘ,✄,૪,ℨ,@,ß,¢,ḓ,℮,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,м,п,◎,℘,ⓠ,я,﹩,т,ʊ,♥️,ẘ,✄,૪,ℨ,0,9,8,7,6,5,4,3,2,1,.,_",
        "@,ß,¢,ḓ,℮,ƒ,ℊ,н,ḯ,נ,к,ℓμ,п,☺️,℘,ⓠ,я,﹩,⊥,υ,ṽ,ω,✄,૪,ℨ,@,ß,¢,ḓ,℮,ƒ,ℊ,н,ḯ,נ,к,ℓμ,п,☺️,℘,ⓠ,я,﹩,⊥,υ,ṽ,ω,✄,૪,ℨ,0,9,8,7,6,5,4,3,2,1,.,_",
        "@,ß,ḉ,ḓ,є,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,ღ,η,◎,℘,ⓠ,я,﹩,⊥,ʊ,♥️,ω,ϰ,૪,ẕ,@,ß,ḉ,ḓ,є,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,ღ,η,◎,℘,ⓠ,я,﹩,⊥,ʊ,♥️,ω,ϰ,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
        "@,ß,ḉ,∂,ε,ƒ,ℊ,ℌ,ї,נ,ḱ,ł,ღ,и,ø,℘,ⓠ,я,﹩,т,υ,√,ω,ჯ,૪,ẕ,@,ß,ḉ,∂,ε,ƒ,ℊ,ℌ,ї,נ,ḱ,ł,ღ,и,ø,℘,ⓠ,я,﹩,т,υ,√,ω,ჯ,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
        "α,♭,¢,∂,ε,ƒ,❡,н,ḯ,ʝ,ḱ,ʟ,μ,п,ø,ρ,ⓠ,ґ,﹩,т,υ,ṽ,ω,ж,૪,ẕ,α,♭,¢,∂,ε,ƒ,❡,н,ḯ,ʝ,ḱ,ʟ,μ,п,ø,ρ,ⓠ,ґ,﹩,т,υ,ṽ,ω,ж,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
        "α,♭,ḉ,∂,℮,ⓕ,ⓖ,н,ḯ,ʝ,ḱ,ℓ,м,п,ø,ⓟ,ⓠ,я,ⓢ,ⓣ,ⓤ,♥️,ⓦ,✄,ⓨ,ⓩ,α,♭,ḉ,∂,℮,ⓕ,ⓖ,н,ḯ,ʝ,ḱ,ℓ,м,п,ø,ⓟ,ⓠ,я,ⓢ,ⓣ,ⓤ,♥️,ⓦ,✄,ⓨ,ⓩ,0,➒,➑,➐,➏,➄,➍,➂,➁,➀,.,_",
        "@,♭,ḉ,ḓ,є,ƒ,ⓖ,ℌ,ⓘ,נ,к,ⓛ,м,ⓝ,ø,℘,ⓠ,я,﹩,ⓣ,ʊ,√,ω,ჯ,૪,ⓩ,@,♭,ḉ,ḓ,є,ƒ,ⓖ,ℌ,ⓘ,נ,к,ⓛ,м,ⓝ,ø,℘,ⓠ,я,﹩,ⓣ,ʊ,√,ω,ჯ,૪,ⓩ,0,➒,➇,➆,➅,➄,➍,➌,➋,➀,.,_",
        "α,♭,ⓒ,∂,є,ⓕ,ⓖ,ℌ,ḯ,ⓙ,ḱ,ł,ⓜ,и,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,⊥,ʊ,ⓥ,ⓦ,ж,ⓨ,ⓩ,α,♭,ⓒ,∂,є,ⓕ,ⓖ,ℌ,ḯ,ⓙ,ḱ,ł,ⓜ,и,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,⊥,ʊ,ⓥ,ⓦ,ж,ⓨ,ⓩ,0,➒,➑,➆,➅,➎,➍,➌,➁,➀,.,_",
		"ⓐ,ß,ḉ,∂,℮,ⓕ,❡,ⓗ,ї,נ,ḱ,ł,μ,η,ø,ρ,ⓠ,я,﹩,ⓣ,ц,√,ⓦ,✖️,૪,ℨ,ⓐ,ß,ḉ,∂,℮,ⓕ,❡,ⓗ,ї,נ,ḱ,ł,μ,η,ø,ρ,ⓠ,я,﹩,ⓣ,ц,√,ⓦ,✖️,૪,ℨ,0,➒,➑,➐,➅,➄,➍,➂,➁,➊,.,_",
        "α,ß,ⓒ,ⅾ,ℯ,ƒ,ℊ,ⓗ,ї,ʝ,к,ʟ,ⓜ,η,ⓞ,℘,ⓠ,ґ,﹩,т,υ,ⓥ,ⓦ,ж,ⓨ,ẕ,α,ß,ⓒ,ⅾ,ℯ,ƒ,ℊ,ⓗ,ї,ʝ,к,ʟ,ⓜ,η,ⓞ,℘,ⓠ,ґ,﹩,т,υ,ⓥ,ⓦ,ж,ⓨ,ẕ,0,➈,➇,➐,➅,➎,➍,➌,➁,➊,.,_",
        "@,♭,ḉ,ⅾ,є,ⓕ,❡,н,ḯ,נ,ⓚ,ⓛ,м,ⓝ,☺️,ⓟ,ⓠ,я,ⓢ,⊥,υ,♥️,ẘ,ϰ,૪,ⓩ,@,♭,ḉ,ⅾ,є,ⓕ,❡,н,ḯ,נ,ⓚ,ⓛ,м,ⓝ,☺️,ⓟ,ⓠ,я,ⓢ,⊥,υ,♥️,ẘ,ϰ,૪,ⓩ,0,➒,➑,➆,➅,➄,➃,➂,➁,➀,.,_",
        "ⓐ,♭,ḉ,ⅾ,є,ƒ,ℊ,ℌ,ḯ,ʝ,ḱ,ł,μ,η,ø,ⓟ,ⓠ,ґ,ⓢ,т,ⓤ,√,ⓦ,✖️,ⓨ,ẕ,ⓐ,♭,ḉ,ⅾ,є,ƒ,ℊ,ℌ,ḯ,ʝ,ḱ,ł,μ,η,ø,ⓟ,ⓠ,ґ,ⓢ,т,ⓤ,√,ⓦ,✖️,ⓨ,ẕ,0,➈,➇,➐,➅,➄,➃,➂,➁,➀,.,_",
		"ձ,ъƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
"λ,ϐ,ς,d,ε,ғ,ϑ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,λ,ϐ,ς,d,ε,ғ,ϑ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
"მ,ჩ,ƈძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,მ,ჩ,ƈძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,0,Գ,Ց,Դ,6,5,Վ,Յ,Զ,1,.,_",
"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
"Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
"λ,ß,Ȼ,ɖ,ε,ʃ,Ģ,ħ,ί,ĵ,κ,ι,ɱ,ɴ,Θ,ρ,ƣ,ર,Ș,τ,Ʋ,ν,ώ,Χ,ϓ,Հ,λ,ß,Ȼ,ɖ,ε,ʃ,Ģ,ħ,ί,ĵ,κ,ι,ɱ,ɴ,Θ,ρ,ƣ,ર,Ș,τ,Ʋ,ν,ώ,Χ,ϓ,Հ,0,9,8,7,6,5,4,3,2,1,.,_",
"ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,0,9,8,7,6,5,4,3,2,1,.,_",
"Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,0,9,8,7,6,5,4,3,2,1,.,_",
"Λ,Ϧ,ㄈ,Ð,Ɛ,F,Ɠ,н,ɪ,ﾌ,Қ,Ł,௱,Л,Ø,þ,Ҩ,尺,ら,Ť,Ц,Ɣ,Ɯ,χ,Ϥ,Ẕ,Λ,Ϧ,ㄈ,Ð,Ɛ,F,Ɠ,н,ɪ,ﾌ,Қ,Ł,௱,Л,Ø,þ,Ҩ,尺,ら,Ť,Ц,Ɣ,Ɯ,χ,Ϥ,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
"Ǟ,в,ट,D,ę,բ,g,৸,i,j,κ,l,ɱ,П,Φ,Р,q,Я,s,Ʈ,Ц,v,Щ,ж,ყ,ւ,Ǟ,в,ट,D,ę,բ,g,৸,i,j,κ,l,ɱ,П,Φ,Р,q,Я,s,Ʈ,Ц,v,Щ,ж,ყ,ւ,0,9,8,7,6,5,4,3,2,1,.,_",
"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
"Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,0,9,8,7,6,5,4,3,2,1,.,_",
"ª,ß,¢,ð,€,f,g,h,¡,j,k,|,m,ñ,¤,Þ,q,®,$,t,µ,v,w,×,ÿ,z,ª,ß,¢,ð,€,f,g,h,¡,j,k,|,m,ñ,¤,Þ,q,®,$,t,µ,v,w,×,ÿ,z,0,9,8,7,6,5,4,3,2,1,.,_",
"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
"ɑ,ʙ,c,ᴅ,є,ɻ,მ,ʜ,ι,ɿ,ĸ,г,w,и,o,ƅϭ,ʁ,ƨ,⊥,n,ʌ,ʍ,x,⑃,z,ɑ,ʙ,c,ᴅ,є,ɻ,მ,ʜ,ι,ɿ,ĸ,г,w,и,o,ƅϭ,ʁ,ƨ,⊥,n,ʌ,ʍ,x,⑃,z,0,9,8,7,6,5,4,3,2,1,.,_",
"4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,0,9,8,7,6,5,4,3,2,1,.,_",
"Λ,ßƇ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,Λ,ßƇ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
"α,в,c,ɔ,ε,ғ,ɢ,н,ı,נ,κ,ʟ,м,п,σ,ρ,ǫ,я,ƨ,т,υ,ν,ш,х,ч,z,α,в,c,ɔ,ε,ғ,ɢ,н,ı,נ,κ,ʟ,м,п,σ,ρ,ǫ,я,ƨ,т,υ,ν,ш,х,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
"【a】,【b】,【c】,【d】,【e】,【f】,【g】,【h】,【i】,【j】,【k】,【l】,【m】,【n】,【o】,【p】,【q】,【r】,【s】,【t】,【u】,【v】,【w】,【x】,【y】,【z】,【a】,【b】,【c】,【d】,【e】,【f】,【g】,【h】,【i】,【j】,【k】,【l】,【m】,【n】,【o】,【p】,【q】,【r】,【s】,【t】,【u】,【v】,【w】,【x】,【y】,【z】,【0】,【9】,【8】,【7】,【6】,【5】,【4】,【3】,【2】,【1】,.,_",
"[̲̲̅̅a̲̅,̲̅b̲̲̅,̅c̲̅,̲̅d̲̲̅,̅e̲̲̅,̅f̲̲̅,̅g̲̅,̲̅h̲̲̅,̅i̲̲̅,̅j̲̲̅,̅k̲̅,̲̅l̲̲̅,̅m̲̅,̲̅n̲̅,̲̅o̲̲̅,̅p̲̅,̲̅q̲̅,̲̅r̲̲̅,̅s̲̅,̲̅t̲̲̅,̅u̲̅,̲̅v̲̅,̲̅w̲̅,̲̅x̲̅,̲̅y̲̅,̲̅z̲̅,[̲̲̅̅a̲̅,̲̅b̲̲̅,̅c̲̅,̲̅d̲̲̅,̅e̲̲̅,̅f̲̲̅,̅g̲̅,̲̅h̲̲̅,̅i̲̲̅,̅j̲̲̅,̅k̲̅,̲̅l̲̲̅,̅m̲̅,̲̅n̲̅,̲̅o̲̲̅,̅p̲̅,̲̅q̲̅,̲̅r̲̲̅,̅s̲̅,̲̅t̲̲̅,̅u̲̅,̲̅v̲̅,̲̅w̲̅,̲̅x̲̅,̲̅y̲̅,̲̅z̲̅,̲̅0̲̅,̲̅9̲̲̅,̅8̲̅,̲̅7̲̅,̲̅6̲̅,̲̅5̲̅,̲̅4̲̅,̲̅3̲̲̅,̅2̲̲̅,̅1̲̲̅̅],.,_",
"[̺͆a̺͆͆,̺b̺͆͆,̺c̺͆,̺͆d̺͆,̺͆e̺͆,̺͆f̺͆͆,̺g̺͆,̺͆h̺͆,̺͆i̺͆,̺͆j̺͆,̺͆k̺͆,̺l̺͆͆,̺m̺͆͆,̺n̺͆͆,̺o̺͆,̺͆p̺͆͆,̺q̺͆͆,̺r̺͆͆,̺s̺͆͆,̺t̺͆͆,̺u̺͆͆,̺v̺͆͆,̺w̺͆,̺͆x̺͆,̺͆y̺͆,̺͆z̺,[̺͆a̺͆͆,̺b̺͆͆,̺c̺͆,̺͆d̺͆,̺͆e̺͆,̺͆f̺͆͆,̺g̺͆,̺͆h̺͆,̺͆i̺͆,̺͆j̺͆,̺͆k̺͆,̺l̺͆͆,̺m̺͆͆,̺n̺͆͆,̺o̺͆,̺͆p̺͆͆,̺q̺͆͆,̺r̺͆͆,̺s̺͆͆,̺t̺͆͆,̺u̺͆͆,̺v̺͆͆,̺w̺͆,̺͆x̺͆,̺͆y̺͆,̺͆z̺,̺͆͆0̺͆,̺͆9̺͆,̺͆8̺̺͆͆7̺͆,̺͆6̺͆,̺͆5̺͆,̺͆4̺͆,̺͆3̺͆,̺͆2̺͆,̺͆1̺͆],.,_",
"̛̭̰̃ã̛̰̭,̛̭̰̃b̛̰̭̃̃,̛̭̰c̛̛̰̭̃̃,̭̰d̛̰̭̃,̛̭̰̃ḛ̛̭̃̃,̛̭̰f̛̰̭̃̃,̛̭̰g̛̰̭̃̃,̛̭̰h̛̰̭̃,̛̭̰̃ḭ̛̛̭̃̃,̭̰j̛̰̭̃̃,̛̭̰k̛̰̭̃̃,̛̭̰l̛̰̭,̛̭̰̃m̛̰̭̃̃,̛̭̰ñ̛̛̰̭̃,̭̰ỡ̰̭̃,̛̭̰p̛̰̭̃,̛̭̰̃q̛̰̭̃̃,̛̭̰r̛̛̰̭̃̃,̭̰s̛̰̭,̛̭̰̃̃t̛̰̭̃,̛̭̰̃ữ̰̭̃,̛̭̰ṽ̛̰̭̃,̛̭̰w̛̛̰̭̃̃,̭̰x̛̰̭̃,̛̭̰̃ỹ̛̰̭̃,̛̭̰z̛̰̭̃̃,̛̛̭̰ã̛̰̭,̛̭̰̃b̛̰̭̃̃,̛̭̰c̛̛̰̭̃̃,̭̰d̛̰̭̃,̛̭̰̃ḛ̛̭̃̃,̛̭̰f̛̰̭̃̃,̛̭̰g̛̰̭̃̃,̛̭̰h̛̰̭̃,̛̭̰̃ḭ̛̛̭̃̃,̭̰j̛̰̭̃̃,̛̭̰k̛̰̭̃̃,̛̭̰l̛̰̭,̛̭̰̃m̛̰̭̃̃,̛̭̰ñ̛̛̰̭̃,̭̰ỡ̰̭̃,̛̭̰p̛̰̭̃,̛̭̰̃q̛̰̭̃̃,̛̭̰r̛̛̰̭̃̃,̭̰s̛̰̭,̛̭̰̃̃t̛̰̭̃,̛̭̰̃ữ̰̭̃,̛̭̰ṽ̛̰̭̃,̛̭̰w̛̛̰̭̃̃,̭̰x̛̰̭̃,̛̭̰̃ỹ̛̰̭̃,̛̭̰z̛̰̭̃̃,̛̭̰0̛̛̰̭̃̃,̭̰9̛̰̭̃̃,̛̭̰8̛̛̰̭̃̃,̭̰7̛̰̭̃̃,̛̭̰6̛̰̭̃̃,̛̭̰5̛̰̭̃,̛̭̰̃4̛̰̭̃,̛̭̰̃3̛̰̭̃̃,̛̭̰2̛̰̭̃̃,̛̭̰1̛̰̭̃,.,_",
"a,ะb,ะc,ะd,ะe,ะf,ะg,ะh,ะi,ะj,ะk,ะl,ะm,ะn,ะo,ะp,ะq,ะr,ะs,ะt,ะu,ะv,ะw,ะx,ะy,ะz,a,ะb,ะc,ะd,ะe,ะf,ะg,ะh,ะi,ะj,ะk,ะl,ะm,ะn,ะo,ะp,ะq,ะr,ะs,ะt,ะu,ะv,ะw,ะx,ะy,ะz,ะ0,ะ9,ะ8,ะ7,ะ6,ะ5,ะ4,ะ3,ะ2,ะ1ะ,.,_",
"̑ȃ,̑b̑,̑c̑,̑d̑,̑ȇ,̑f̑,̑g̑,̑h̑,̑ȋ,̑j̑,̑k̑,̑l̑,̑m̑,̑n̑,̑ȏ,̑p̑,̑q̑,̑ȓ,̑s̑,̑t̑,̑ȗ,̑v̑,̑w̑,̑x̑,̑y̑,̑z̑,̑ȃ,̑b̑,̑c̑,̑d̑,̑ȇ,̑f̑,̑g̑,̑h̑,̑ȋ,̑j̑,̑k̑,̑l̑,̑m̑,̑n̑,̑ȏ,̑p̑,̑q̑,̑ȓ,̑s̑,̑t̑,̑ȗ,̑v̑,̑w̑,̑x̑,̑y̑,̑z̑,̑0̑,̑9̑,̑8̑,̑7̑,̑6̑,̑5̑,̑4̑,̑3̑,̑2̑,̑1̑,.,_",
"~a,͜͝b,͜͝c,͜͝d,͜͝e,͜͝f,͜͝g,͜͝h,͜͝i,͜͝j,͜͝k,͜͝l,͜͝m,͜͝n,͜͝o,͜͝p,͜͝q,͜͝r,͜͝s,͜͝t,͜͝u,͜͝v,͜͝w,͜͝x,͜͝y,͜͝z,~a,͜͝b,͜͝c,͜͝d,͜͝e,͜͝f,͜͝g,͜͝h,͜͝i,͜͝j,͜͝k,͜͝l,͜͝m,͜͝n,͜͝o,͜͝p,͜͝q,͜͝r,͜͝s,͜͝t,͜͝u,͜͝v,͜͝w,͜͝x,͜͝y,͜͝z,͜͝0,͜͝9,͜͝8,͜͝7,͜͝6,͜͝5,͜͝4,͜͝3,͜͝2͜,͝1͜͝~,.,_",
"̤̈ä̤,̤̈b̤̈,̤̈c̤̈̈,̤d̤̈,̤̈ë̤,̤̈f̤̈,̤̈g̤̈̈,̤ḧ̤̈,̤ï̤̈,̤j̤̈,̤̈k̤̈̈,̤l̤̈,̤̈m̤̈,̤̈n̤̈,̤̈ö̤,̤̈p̤̈,̤̈q̤̈,̤̈r̤̈,̤̈s̤̈̈,̤ẗ̤̈,̤ṳ̈,̤̈v̤̈,̤̈ẅ̤,̤̈ẍ̤,̤̈ÿ̤,̤̈z̤̈,̤̈ä̤,̤̈b̤̈,̤̈c̤̈̈,̤d̤̈,̤̈ë̤,̤̈f̤̈,̤̈g̤̈̈,̤ḧ̤̈,̤ï̤̈,̤j̤̈,̤̈k̤̈̈,̤l̤̈,̤̈m̤̈,̤̈n̤̈,̤̈ö̤,̤̈p̤̈,̤̈q̤̈,̤̈r̤̈,̤̈s̤̈̈,̤ẗ̤̈,̤ṳ̈,̤̈v̤̈,̤̈ẅ̤,̤̈ẍ̤,̤̈ÿ̤,̤̈z̤̈,̤̈0̤̈,̤̈9̤̈,̤̈8̤̈,̤̈7̤̈,̤̈6̤̈,̤̈5̤̈,̤̈4̤̈,̤̈3̤̈,̤̈2̤̈̈,̤1̤̈,.,_",
"≋̮̑ȃ̮,̮̑b̮̑,̮̑c̮̑,̮̑d̮̑,̮̑ȇ̮,̮̑f̮̑,̮̑g̮̑,̮̑ḫ̑,̮̑ȋ̮,̮̑j̮̑,̮̑k̮̑,̮̑l̮̑,̮̑m̮̑,̮̑n̮̑,̮̑ȏ̮,̮̑p̮̑,̮̑q̮̑,̮̑r̮,̮̑̑s̮,̮̑̑t̮,̮̑̑u̮,̮̑̑v̮̑,̮̑w̮̑,̮̑x̮̑,̮̑y̮̑,̮̑z̮̑,≋̮̑ȃ̮,̮̑b̮̑,̮̑c̮̑,̮̑d̮̑,̮̑ȇ̮,̮̑f̮̑,̮̑g̮̑,̮̑ḫ̑,̮̑ȋ̮,̮̑j̮̑,̮̑k̮̑,̮̑l̮̑,̮̑m̮̑,̮̑n̮̑,̮̑ȏ̮,̮̑p̮̑,̮̑q̮̑,̮̑r̮,̮̑̑s̮,̮̑̑t̮,̮̑̑u̮,̮̑̑v̮̑,̮̑w̮̑,̮̑x̮̑,̮̑y̮̑,̮̑z̮̑,̮̑0̮̑,̮̑9̮̑,̮̑8̮̑,̮̑7̮̑,̮̑6̮̑,̮̑5̮̑,̮̑4̮̑,̮̑3̮̑,̮̑2̮̑,̮̑1̮̑≋,.,_",
"a̮,̮b̮̮,c̮̮,d̮̮,e̮̮,f̮̮,g̮̮,ḫ̮,i̮,j̮̮,k̮̮,l̮,̮m̮,̮n̮̮,o̮,̮p̮̮,q̮̮,r̮̮,s̮,̮t̮̮,u̮̮,v̮̮,w̮̮,x̮̮,y̮̮,z̮̮,a̮,̮b̮̮,c̮̮,d̮̮,e̮̮,f̮̮,g̮̮,ḫ̮i,̮̮,j̮̮,k̮̮,l̮,̮m̮,̮n̮̮,o̮,̮p̮̮,q̮̮,r̮̮,s̮,̮t̮̮,u̮̮,v̮̮,w̮̮,x̮̮,y̮̮,z̮̮,0̮̮,9̮̮,8̮̮,7̮̮,6̮̮,5̮̮,4̮̮,3̮̮,2̮̮,1̮,.,_",
"A̲,̲B̲,̲C̲,̲D̲,̲E̲,̲F̲,̲G̲,̲H̲,̲I̲,̲J̲,̲K̲,̲L̲,̲M̲,̲N̲,̲O̲,̲P̲,̲Q̲,̲R̲,̲S̲,̲T̲,̲U̲,̲V̲,̲W̲,̲X̲,̲Y̲,̲Z̲,̲a̲,̲b̲,̲c̲,̲d̲,̲e̲,̲f̲,̲g̲,̲h̲,̲i̲,̲j̲,̲k̲,̲l̲,̲m̲,̲n̲,̲o̲,̲p̲,̲q̲,̲r̲,̲s̲,̲t̲,̲u̲,̲v̲,̲w̲,̲x̲,̲y̲,̲z̲,̲0̲,̲9̲,̲8̲,̲7̲,̲6̲,̲5̲,̲4̲,̲3̲,̲2̲,̲1̲,̲.̲,̲_̲",
"Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local result = {}
	i=0
	for k=1,#fonts do
		i=i+1
		local tar_font = fonts[i]:split(",")
		local text = matches[2]
		local text = text:gsub("A",tar_font[1])
		local text = text:gsub("B",tar_font[2])
		local text = text:gsub("C",tar_font[3])
		local text = text:gsub("D",tar_font[4])
		local text = text:gsub("E",tar_font[5])
		local text = text:gsub("F",tar_font[6])
		local text = text:gsub("G",tar_font[7])
		local text = text:gsub("H",tar_font[8])
		local text = text:gsub("I",tar_font[9])
		local text = text:gsub("J",tar_font[10])
		local text = text:gsub("K",tar_font[11])
		local text = text:gsub("L",tar_font[12])
		local text = text:gsub("M",tar_font[13])
		local text = text:gsub("N",tar_font[14])
		local text = text:gsub("O",tar_font[15])
		local text = text:gsub("P",tar_font[16])
		local text = text:gsub("Q",tar_font[17])
		local text = text:gsub("R",tar_font[18])
		local text = text:gsub("S",tar_font[19])
		local text = text:gsub("T",tar_font[20])
		local text = text:gsub("U",tar_font[21])
		local text = text:gsub("V",tar_font[22])
		local text = text:gsub("W",tar_font[23])
		local text = text:gsub("X",tar_font[24])
		local text = text:gsub("Y",tar_font[25])
		local text = text:gsub("Z",tar_font[26])
		local text = text:gsub("a",tar_font[27])
		local text = text:gsub("b",tar_font[28])
		local text = text:gsub("c",tar_font[29])
		local text = text:gsub("d",tar_font[30])
		local text = text:gsub("e",tar_font[31])
		local text = text:gsub("f",tar_font[32])
		local text = text:gsub("g",tar_font[33])
		local text = text:gsub("h",tar_font[34])
		local text = text:gsub("i",tar_font[35])
		local text = text:gsub("j",tar_font[36])
		local text = text:gsub("k",tar_font[37])
		local text = text:gsub("l",tar_font[38])
		local text = text:gsub("m",tar_font[39])
		local text = text:gsub("n",tar_font[40])
		local text = text:gsub("o",tar_font[41])
		local text = text:gsub("p",tar_font[42])
		local text = text:gsub("q",tar_font[43])
		local text = text:gsub("r",tar_font[44])
		local text = text:gsub("s",tar_font[45])
		local text = text:gsub("t",tar_font[46])
		local text = text:gsub("u",tar_font[47])
		local text = text:gsub("v",tar_font[48])
		local text = text:gsub("w",tar_font[49])
		local text = text:gsub("x",tar_font[50])
		local text = text:gsub("y",tar_font[51])
		local text = text:gsub("z",tar_font[52])
		local text = text:gsub("0",tar_font[53])
		local text = text:gsub("9",tar_font[54])
		local text = text:gsub("8",tar_font[55])
		local text = text:gsub("7",tar_font[56])
		local text = text:gsub("6",tar_font[57])
		local text = text:gsub("5",tar_font[58])
		local text = text:gsub("4",tar_font[59])
		local text = text:gsub("3",tar_font[60])
		local text = text:gsub("2",tar_font[61])
		local text = text:gsub("1",tar_font[62])

		table.insert(result, text)
	end
	local result_text = "کلمه ی اولیه: "..matches[2].."\nطراحی با "..tostring(#fonts).." فونت:\n ________________________\n\n "
	a=0
	for v=1,#result do
		a=a+1
		result_text = result_text..a.."- "..result[a].."\n\n"
	end
	tdcli.sendMessage(msg.chat_id_, 0, 1, result_text, 1, 'html')
end
--------------------------------
end
--------------------------------
return {               
	patterns = {
    	"^[!/#]([Ww]eather) (.*)$",
		"^[#!/]([Cc]alc) (.*)$",
		"^[#!/]([Tt]ime)$",
		"^[/!#]([Pp]raytime) (.*)$",
		"^[/!#]([Pp]raytime)$",
		"^[#!/]([Tt]r) ([^%s]+) (.*)$",
		"^[#!/](photo) (.*)$",
		"^[#!/](sticker) (.*)$",
	    "^(آب و هوا) (.*)$", 
		"^(محاسبه) (.*)$",
		"^(ساعت)$",
		"^(ساعات شرعی) (.*)$",          
		"^(ترجمه) ([^%s]+) (.*)$",
		"^(نوشتن) ([^%s]+) (.*)$",
		"^[#!/]([Ww]rite) (.*)$",
		"^([Ww]rite) (.*)$",
        "^(عکس) (.+)$",                       
		"^(استیکر) (.+)$"
		}, 
	run = run,
	}

--#by @MaTaDoRTeam & Edit For Better By #Tiger:)
