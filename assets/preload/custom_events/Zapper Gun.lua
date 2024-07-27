function onEvent(n,v1,v2)
    if n == "Zapper Gun" and getModSetting('zapperMechanic') then
        active = toboolean(v1)
        beat = tonumber(v2)
    end
end

function toboolean(s)
    return s:lower() == 'true'
end

zapDamage = 0.1

function onCreate()
    if getModSetting('zapperMechanic') then
        zapDamage = 0.02*getModSetting('zapperDamage')
    end
end

function onBeatHit()
    if active and curBeat % beat == 0 and getModSetting('zapperMechanic') then
        if getHealth()-zapDamage > 0 then
            setHealth(getHealth()-zapDamage)
            playSound('zapper', 0.2)
            setProperty('iconP1.color', '000000')
            runTimer('unzap', 0.1)
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'unzap' then
        setProperty('iconP1.color', getColorFromHex('FFFFFF'))
    end
end