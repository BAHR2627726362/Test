local SonicdarkblueValue = 0
local SonicdarkblueEnable = false
function onCreate()
    makeLuaSprite('SonicdarkblueImage','SonicdarkblueVG',0,0)
    setObjectCamera('SonicdarkblueImage','other')
    setProperty('SonicdarkblueImage.alpha',0)
    addLuaSprite('SonicdarkblueImage',true)
end

function onEvent(name,v1)
    if name == 'SonicdarkblueVG' then
        if v1 ~= false and v1 ~= 'False' and v1 ~= 'false' then
            SonicdarkblueValue = -1
            SonicdarkblueEnable = true
        else
            SonicdarkblueEnable = false
            SonicdarkblueValue = -1
        end
    end
end

function onUpdate()
    if SonicdarkblueValue == 1 then
        doTweenAlpha('SonicdarkblueWOW','SonicdarkblueImage',1,0.8,'linear')
        SonicdarkblueValue = 2
    elseif SonicdarkblueValue == -1 then
        doTweenAlpha('SonicdarkblueWOW','SonicdarkblueImage',0,1,'linear')
        SonicdarkblueValue = -2
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        if SonicdarkblueValue < 0 and SonicdarkblueEnable == true then
            SonicdarkblueValue = 1
        elseif SonicdarkblueValue > 0 and SonicdarkblueEnable == true then
            SonicdarkblueValue = -1
        end
    end
end