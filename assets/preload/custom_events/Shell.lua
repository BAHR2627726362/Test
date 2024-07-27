function onEvent(n,v1,v2)
    if n == "Shell" and getModSetting('shellMechanic') then
        playAnim('shell', 'idle')
        doTweenX('shell', 'shell', target, crochet/4000, 'linear')
    end
end

active = false
target = 0

function onCreate()
    shellDamage = getModSetting('shellDamage')
    if getModSetting('shellMechanic') then
        makeAnimatedLuaSprite('shell', 'shellmk', -200, getProperty('iconP2.y') - 50)
        addAnimationByPrefix('shell', 'hit', 'hit', 24, false)
        addAnimationByPrefix('shell', 'idle', 'idle', 24, true)
        setObjectCamera('shell', 'hud')
        addLuaSprite('shell', true)
    end
end

function onUpdatePost()
    if getModSetting('shellMechanic') then
        target = getProperty('iconP2.x')

        if shellDrain > 0 then
            shellDrain = shellDrain - 0.1
            if getHealth() - (shellDrain*0.002) > 0 then
                setHealth(getHealth() - (shellDrain*0.002))
            end
        end

        if getProperty('shell.animation.curAnim.name') == 'hit' and getProperty('shell.animation.curAnim.finished') then
            setProperty('shell.x', -200)
        end
    end
end

shellDrain = 0
shellDamage = 6

function onTweenCompleted(tag)
    if tag == 'shell' then
        playSound('shellhit')
        playAnim('shell', 'hit')
        shellDrain = shellDamage
    end
end