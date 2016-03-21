# chatter-bot

A simple telegram-bot wtitten in LUA 

# commands
`/bb`

 حظر عضو من ارسال رساله بالرد على رسالته

`/uu`

فتح الحظر عن عضو عن طريق الرد على رسالته

`/us` 

معرفه عدد الاعضاء المشتركين

`/bro`

ارسل هذا الامر وكل رساله كانت بعده سترسل لجميع المشتركين

`/unbro`

لكي تتوقف ارسال الرسائل وتفعيل الاوامر البقيه

`/start`

لأظهار رساله ترحيب للاعضاٱء

`/id` 

بالرد على رساله موجهه يضهر لك المعلومات

# التنصيب


انسخ الامر التالي

```
git clone https://github.com/alosh99/chatter.git && cd chatter && chmod +x ./lua.sh && ./lua.sh run && ./lua.sh

```
ثم اعمل run على 
```
./launch.sh
```
خلي التوكين للبوت بين "" في bot_api_bot
وايدي حسابك الخاصه ب you

```lua

local bot_api_key = "" -- token
local BASE_URL = "https://api.telegram.org/bot"..bot_api_key
you = --ايدي هنا فقط رقم
local BASE_FOLDER = "" -- do not set this

```
اذا تحب تساعدني او عدك استفسار احب اسمع منك

[حسابي](telegram.me/alosh_abomer)

او 

[البوت الخاص بي](telegram.me/alosh_abomer_bot)


