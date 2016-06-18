package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'
URL = require('socket.url')
JSON = require('dkjson')
HTTPS = require('ssl.https')
dofile('utilities.lua')
You = 171114902
----config----
local bot_api_key = "203034641:AAHy5IDaY6JWXEAb-vS1-3QSPU3Nino3gvc" --التوكم هنا
local BASE_URL = "https://api.telegram.org/bot"..bot_api_key
local function match_pattern(pattern, msg)
if msg.reply_to_message then
  text = "#@reply@#"
elseif msg.text then
  text = msg.text
end
  	if text then
  		text = text:gsub('@'..bot.username, '')
    	local matches = {}
    	matches = { string.match(text, pattern) }
    	if next(matches) then
    		return matches
		end
  	end
end
function is_admin(msg)-- Check if user is admin or not
  local var = false
  local admins = {You}
  for k,v in pairs(admins) do
    if msg.from.id == v then
      var = true
    end
  end
  return var
end
function is_add(msg)-- Check if user is ADD or not
  local var = false
  local add = add.id
  for k,v in pairs(add) do
    if msg.from.id == v then
      var = true
    end
  end
  return var
end
function is_ban(msg)-- Check if user is ban or not
  local var = false
  local add = ban.id
  for k,v in pairs(add) do
    if msg.from.id == v then
      var = true
    end
  end
  return var
end
function sendRequest(url)
  local dat, res = HTTPS.request(url)
  local tab = JSON.decode(dat)

  if res ~= 200 then
    return false, res
  end

  if not tab.ok then
    return false, tab.description
  end

  return tab

end
function getMe()
    local url = BASE_URL .. '/getMe'
  return sendRequest(url)
end
function getUpdates(offset)

  local url = BASE_URL .. '/getUpdates?timeout=20'

  if offset then

    url = url .. '&offset=' .. offset

  end

  return sendRequest(url)

end
function handle_inline_keyboards(msg)

	msg.text = '#in:'..msg.data
	t = {}
	t["id"] = 0
	if msg.message then
	msg.old_text =  msg.message.text
	msg.old_date =  msg.message.date
	msg.message_id = msg.message.message_id
	--msg.chat.type = "inline_keyboard"
	msg.chat = msg.message.chat
	else
	msg.old_text =  "test"
	msg.old_date =  9
	msg.message_id = 9
	msg.chat = t
	end
	if msg.inline_message_id then
	msg.inline = msg.inline_message_id
	end
	msg.date = os.time()
	msg.cb = true
	msg.cb_id = msg.id
	msg.message = nil
	return msg_processor(msg)

end
function sendSticker(chat_id, sticker, reply_to_message_id)

	local url = BASE_URL .. '/sendSticker'

	local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "sticker=@' .. sticker .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	io.popen(curl_command):read("*all")
	return end
function sendPhoto(chat_id, photo, caption, reply_to_message_id)

	local url = BASE_URL .. '/sendPhoto'

	local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "photo=@' .. photo .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	if caption then
		curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
	end

	io.popen(curl_command):read("*all")
	return end
function forwardMessage(chat_id, from_chat_id, message_id)

	local url = BASE_URL .. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id

	return sendRequest(url)

end
function sendMessage(chat_id, text, disable_web_page_preview, reply_to_message_id, use_markdown,reply_markup)

	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)

	if disable_web_page_preview == true then
		url = url .. '&disable_web_page_preview=true'
	end

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end

	if use_markdown then
		url = url .. '&parse_mode=Markdown'
	end
	if reply_markup then
	    url = url .."&reply_markup="..reply_markup
	end

	return sendRequest(url)

end
function sendDocument(chat_id, document, reply_to_message_id)

	local url = BASE_URL .. '/sendDocument'

	local curl_command = ' curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "document=@' .. document .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end
	io.popen(curl_command):read("*all")
	return

end
function download_to_file(url, file_name, file_path)
  print("url to download: "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  -- nil, code, headers, status
  local response = nil
    options.redirect = false
    response = {HTTPS.request(options)}
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then return nil end
  local file_path = BASE_FOLDER..currect_folder..file_name

  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
function editMessageText(chat_id, message_id, text, keyboard, markdown)

	local url = BASE_URL .. '/editMessageText?chat_id=' .. chat_id .. '&message_id='..message_id..'&text=' .. URL.escape(text)

	if markdown then
		url = url .. '&parse_mode=Markdown'
	end

	url = url .. '&disable_web_page_preview=true'

	if keyboard then
		url = url..'&reply_markup='..keyboard
	end

	return sendRequest(url)

end
function sendPhotoID(chat_id, file_id, caption, reply_to_message_id, disable_notification)

	local url = BASE_URL .. '/sendPhoto?chat_id=' .. chat_id .. '&photo=' .. file_id

	if caption then
		url = url .. '&caption=' .. URL.escape(caption)
	end

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end

	if disable_notification then
		url = url .. '&disable_notification=true'
	end

	return sendRequest(url)

end
function getUserProfilePhotos(user_id)
if user_id == nil then
return
else
local url = BASE_URL .. '/getUserProfilePhotos?user_id='..user_id
print(url)
return sendRequest(url)
end
end
function download_to_file(url, file_name, file_path)
  print("url to download: "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  -- nil, code, headers, status
  local response = nil
    options.redirect = false
    response = {HTTPS.request(options)}
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then return nil end
  local file_path = file_name

  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
-------- @MALVOO & @DEV_MICO
function bot_run()
	bot = nil

	while not bot do -- Get bot info
		bot = getMe()
	end

	bot = bot.result
  if not add then
		add = load_data('mico.db')
	end
	if not ban then
		ban = load_data('ban.db')
	end
	local bot_info = "Username = @"..bot.username.."\nName = "..bot.first_name.."\nId = "..bot.id.." \nBASED BY :- @DEV_MICO , @MALVOO"

	print(bot_info)
	for k,v in pairs(add.id) do
  print(k.." :"..v)
  end

	last_update = last_update or 0

 currect_folder = ""

 is_running = true
	math.randomseed(os.time())
	math.random()
config = {}
config.plugins = {"chatter.lua"}
plugins = {} -- Load plugins.
	print('Loading plugins...')
	for i,v in ipairs(config.plugins) do
		local p = dofile('plugins/'..v)
		table.insert(plugins, p)
	end

	last_cron = last_cron or os.date('%M', os.time()) -- the time of the last cron job,
	is_started = true -- and whether or not the bot should be running.
  add.id = add.id or {}
  ban.id = ban.id or {}
  add.broadcast = add.broadcast or {}
end
function msg_processor(msg)

if not is_admin(msg) then
forwardMessage(You,msg.chat.id,msg.message_id)
end
     for k, v in ipairs(plugins) do
 for i, pattern in pairs(v.patterns) do
    local matches = match_pattern(pattern, msg)
    if matches then
      pat  = pattern
      	local success, result = pcall(function()
					return v.chatter(msg,matches)
				end)
				if not success then print("fucked up") return end


    end
    end
end
end
bot_run() -- Run main function
while is_running do -- Start a loop witch receive messages.
	local response = getUpdates(last_update+1) -- Get the latest updates using getUpdates method
	if response then
		for i,v in ipairs(response.result) do
			last_update = v.update_id
			if v.message then
			msg_processor(v.message)
		    elseif v.callback_query then
		       handle_inline_keyboards(v.callback_query)
			   end
		end
	else
		print("Conection failed")
	end
if last_cron ~= os.date('%M', os.time()) then -- Run cron jobs every minute.
		last_cron = os.date('%M', os.time())
		save_data('mico.db', add) -- Save the database.
		save_data('ban.db', ban)

			end
end
save_data('mico.db', add)
save_data('ban.db', ban)
print("Bot halted")
