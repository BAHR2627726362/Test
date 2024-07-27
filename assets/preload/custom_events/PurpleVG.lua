local PurpleValue = 0
local PurpleEnable = false
function onCreate()
    makeLuaSprite('PurpleImage','PurpleVG',0,0)
    setObjectCamera('PurpleImage','other')
    setProperty('PurpleImage.alpha',0)
    addLuaSprite('PurpleImage',true)
end

function onEvent(name,v1)
    if name == 'PurpleVG' then
        if v1 ~= false and v1 ~= 'False' and v1 ~= 'false' then
            PurpleValue = -1
            PurpleEnable = true
        else
            PurpleEnable = false
            PurpleValue = -1
        end
    end
end

function onUpdate()
    if PurpleValue == 1 then
        doTweenAlpha('PurpleWOW','PurpleImage',1,0.8,'linear')
        PurpleValue = 2
    elseif PurpleValue == -1 then
        doTweenAlpha('PurpleWOW','PurpleImage',0,1,'linear')
        PurpleValue = -2
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        if PurpleValue < 0 and PurpleEnable == true then
            PurpleValue = 1
        elseif PurpleValue > 0 and PurpleEnable == true then
            PurpleValue = -1
        end
    end
end