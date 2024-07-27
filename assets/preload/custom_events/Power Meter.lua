function onEvent(n,v1,v2)
    if n == "Power Meter" and getModSetting('powerMechanic') then
        active = toboolean(v1)
        beat = tonumber(v2)
        if active then
            doTweenY('healthY', 'health', defaultPlayerStrumY1, 0.5, 'sineOut')
            doTweenAlpha('healthA', 'health', 1, 0.5, 'sineOut')
        else
            doTweenY('healthY', 'health', y, 0.5, 'sineOut')
            doTweenAlpha('healthA', 'health', 0, 0.5, 'sineOut')
        end
    end
end

function toboolean(s)
    return s:lower() == 'true'
end

function onCreate()
    if getModSetting('powerMechanic') then
        x = 565
        y = 0
        if downscroll then
            y = 740
        end
        if middlescroll then
            x = 850
        end
        makeAnimatedLuaSprite('health', 'health', x, y)
        addAnimationByPrefix('health', 'health', 'health', 24, false)
        setObjectCamera('health', 'hud')
        scaleObject('health', 0.5, 0.5)
        setProperty('health.alpha', 0.001)
        addLuaSprite('health', true)
    end
end

function goodNoteHit(i, dir, noteType, sus)
	if noteType == 'coin' and health < 8 and active and getModSetting('powerMechanic') then
		health = health + 1
		setProperty('health.animation.curAnim.curFrame', health)
        playSound('refill', 0.4)
	end
end

health = 8

function onBeatHit()
    if curBeat % beat == 0 and active and getModSetting('powerMechanic') then
        health = health - 1
        setProperty('health.animation.curAnim.curFrame', health)
        if health <= 0 then
            setHealth(0)
        end
    end
end