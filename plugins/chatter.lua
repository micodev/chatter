do
local function chatter(msg,mico)
help = [[
➖➖➖➖➖➖➖➖➖➖➖
*commands:*`for admin`
`/ban` ✴️
*حظر عضو من ارسال رساله بالرد على رسالته*
`/unban` ✴️
*فتح الحظر عن عضو عن طريق الرد على رسالته*
`/users` ✴️
*معرفه عدد الاعضاء المشتركين*
`/broadcast` ✴️
*ارسل هذا الامر وكل رساله كانت بعده سترسل لجميع المشتركين*
`/unbroadcast` ✴️
*لكي تتوقف ارسال الرسائل وتفعيل الاوامر البقيه*
`/start` ✴️
*لأظهار رساله ترحيب للاعضاٱء*
`/id` ✴️
*بالرد على رساله موجهه يضهر لك المعلومات*
➖➖➖➖➖➖➖➖➖➖➖
]]
start = [[]]
You = 197523292
if mico[1] == "start" and not is_add(msg) then
local keyboard = {}

    keyboard.inline_keyboard = {

		{
		{text = 'How to use me ', callback_data = 'help'},
		},

	}
	key = JSON.encode(keyboard)
 	table.insert(add.id,msg.from.id)
 	 	local user = ""
if msg.from.username == nil then
user = bot.username
else
user = msg.from.username
end
local text = "مرحبا بك يا ["..msg.from.first_name.."](www.telegram.me/"..user..")"
sendMessage(msg.chat.id,text.."\n"..start,true,false,true,key)
elseif msg.text == "/start" and is_add(msg) then
local keyboard = {}

    keyboard.inline_keyboard = {

		{
		{text = 'How to use me ', callback_data = 'help'},
		},

	}
	key = JSON.encode(keyboard)
 	local user = ""
if msg.from.username == nil then
user = bot.username
else
user = msg.from.username
end
local text = "مرحبا بك يا ["..msg.from.first_name.."](www.telegram.me/"..user..")"
sendMessage(msg.chat.id,text.."\n"..start,true,false,true,key)
elseif is_admin(msg) and msg.text == "/users" then
 	local r = tostring(#add.id)

 	local t = string.gsub(r," ","")
sendMessage(You,t,true,false,true)
end


if mico[1] == 'in:help' and is_admin(msg) then
editMessageText(msg.chat.id,msg.message_id,help,nil,true)
end
if is_ban(msg) then return end
if msg.date < os.time() - 5 then -- Ignore old msgs
		return
end
if msg.text == "/unbroadcast" then
  add.broadcast = "broadcast"
  save_data('mico.db', add)
  sendMessage(msg.chat.id,"*I will not broadcast any more*",true,false,true)
end
if msg.text ~= "/broadcast" and  add.broadcast ~= "broadcast" then
if is_admin(msg) then
if msg.text and msg.text ~= "/unbroadcast" then
for k,v in pairs(add.id) do
sendMessage(v,msg.text,true,false,true)
end

elseif not msg.text then
for k,v in pairs(add.id) do
forwardMessage(v,You,msg.message_id)
end
end
end
elseif msg.text ~= "/" then
if is_admin(msg) and msg.reply_to_message and msg.reply_to_message.forward_from ~= nil and msg.text == "/ban" then
table.insert(ban.id,msg.reply_to_message.forward_from.id)
sendMessage(msg.reply_to_message.forward_from.id,"*YOU HAVE BEEN BANNED*",true,false,true)
elseif is_admin(msg) and msg.reply_to_message and msg.reply_to_message.forward_from ~= nil and msg.text == "/unban" then
for k, v in pairs(ban["id"]) do
if ( v == msg.reply_to_message.forward_from.id ) then
table.remove(ban["id"], k)
end
end
sendMessage(msg.reply_to_message.forward_from.id,"*YOU HAVE BEEN unBANNED*",true,false,true)
elseif is_admin(msg) and msg.reply_to_message and msg.text == "/id" then
 if msg.reply_to_message.forward_from.last_name ~= nil then
 	 last_name = msg.reply_to_message.forward_from.last_name
 else
 	 last_name = ""
 end
 if msg.reply_to_message.forward_from.username ~= nil then
 	 usernme = "\nUSERNAME : @"..msg.reply_to_message.forward_from.username
 else
 	 usernme = ""
 end
 local E = "NAME : "..msg.reply_to_message.forward_from.first_name.." "..last_name..usernme.."\nID :"..msg.reply_to_message.forward_from.id
 sendMessage(msg.chat.id,E)

elseif is_admin(msg) and msg.text == "/broadcast" then

  add.broadcast = "unbroadcast"
    sendMessage(msg.chat.id,"*I will send every thing u want*",true,false,true)
save_data('mico.db', add)


elseif not is_ban(msg) and msg.text ~= "/start" and msg.text ~= "/id" and msg.text ~= "/unban" and msg.text ~= "/ban" and mico[1] == "#@reply@#" then

if is_admin(msg) and msg.reply_to_message and mico[1] == "#@reply@#" then
forwardMessage(msg.reply_to_message.forward_from.id,msg.from.id,msg.message_id)

end
end
end

end
return {


patterns = {


"/ban",
"/unban",
"(in:help)",
"/users",
"/broadcast",
"/unbroadcast",
"/(start)",
"/(about)",
"/id",
"(#@reply@#)",
},

chatter = chatter
}

end
