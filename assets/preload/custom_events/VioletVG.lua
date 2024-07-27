local VioletValue = 0
local VioletEnable = false
function onCreate()
    makeLuaSprite('VioletImage','VioletVG',0,0)
    setObjectCamera('VioletImage','other')
    setProperty('VioletImage.alpha',0)
    addLuaSprite('VioletImage',true)
end

function onEvent(name,v1)
    if name == 'VioletVG' then
        if v1 ~= false and v1 ~= 'False' and v1 ~= 'false' then
            VioletValue = -1
            VioletEnable = true
        else
            VioletEnable = false
            VioletValue = -1
        end
    end
end

function onUpdate()
    if VioletValue == 1 then
        doTweenAlpha('VioletWOW','VioletImage',1,0.8,'linear')
        VioletValue = 2
    elseif VioletValue == -1 then
        doTweenAlpha('VioletWOW','VioletImage',0,1,'linear')
        VioletValue = -2
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        if VioletValue < 0 and VioletEnable == true then
            VioletValue = 1
        elseif VioletValue > 0 and VioletEnable == true then
            VioletValue = -1
        end
    end
end