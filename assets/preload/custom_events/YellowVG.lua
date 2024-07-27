local YellowValue = 0
local YellowEnable = false
function onCreate()
    makeLuaSprite('YellowImage','YellowVG',0,0)
    setObjectCamera('YellowImage','other')
    setProperty('YellowImage.alpha',0)
    addLuaSprite('YellowImage',true)
end

function onEvent(name,v1)
    if name == 'YellowVG' then
        if v1 ~= false and v1 ~= 'False' and v1 ~= 'false' then
            YellowValue = -1
            YellowEnable = true
        else
            YellowEnable = false
            YellowValue = -1
        end
    end
end

function onUpdate()
    if YellowValue == 1 then
        doTweenAlpha('YellowWOW','YellowImage',1,0.8,'linear')
        YellowValue = 2
    elseif YellowValue == -1 then
        doTweenAlpha('YellowWOW','YellowImage',0,1,'linear')
        YellowValue = -2
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        if YellowValue < 0 and YellowEnable == true then
            YellowValue = 1
        elseif YellowValue > 0 and YellowEnable == true then
            YellowValue = -1
        end
    end
end