function onEvent(n,v1,v2)
    if n == "Warning Block" and getModSetting('warningMechanic') then
        count = 0
        scaleObject('warning', 0.5, 0.5)
        setProperty('warning.visible', true)
        warningTweens()
    end
end

function onCreate()
    warningDamage = getModSetting('warningDamage')
    if getModSetting('warningMechanic') then
        makeLuaSprite('warning', 'Turmoil_HARHARHARHAR', 100, 200)
        setObjectCamera('warning', 'hud')
        scaleObject('warning', 0.5, 0.5)
        if not middlescroll then
            screenCenter('warning', 'x')
        end
        screenCenter('warning', 'y')
        setProperty('warning.visible', false)
        addLuaSprite('warning', true)
        dodgeWindow = 0.3
        if getModSetting('warningWindow') == 'Strict' then
            dodgeWindow = 0.1
        elseif getModSetting('warningWindow') == 'Lenient' then
            dodgeWindow = 0.6
        end
    end
end

count = 0
dodging = false
canDodge = true

warningDrain = 0
warningDamage = 10

function onTweenCompleted(tag)
    if tag == 'warningx' then
        if count < 4 then
            warningTweens()
        else
            count = 0
            setProperty('warning.visible', false)
        end
    end
end

function warningTweens()
    count = count + 1
    alpha = 0.5
    setProperty('warning.alpha', 0.2)
    if count >= 3 then
        alpha = 0
    end
    if count == 3 then
        playAnim('dad', 'singUP', true)
    end
    if count < 4 then
        playSound('warning')
    elseif count == 4 then
        playSound('tongue')
        playAnim('dad', 'singDOWN', true)
        setProperty('warning.alpha', 0)
        runTimer('dodgeWindow', crochet/4000)
        if getProperty('cpuControlled') and canDodge then
            dodging = true
            canDodge = false
            runTimer('dodging', 0.3)
            runTimer('dodgeCD', crochet/400)
            playAnim('boyfriend', 'dodge', true)
        end
    end
        doTweenX('warningx', 'warning.scale', getProperty('warning.scale.x') + 0.1, crochet/1000, 'backOut')
        doTweenY('warningy', 'warning.scale', getProperty('warning.scale.y') + 0.1, crochet/1000, 'backOut')
        doTweenAlpha('warninga', 'warning', alpha, crochet/1000, 'backOut')
end

function onTimerCompleted(tag)
    if tag == 'dodgeWindow' then
        if not dodging then
            warningDrain = warningDamage
            playAnim('boyfriend', 'hurt')
        end
    end
    if tag == 'dodging' then
        dodging = false
    elseif tag == 'dodgeCD' then
        canDodge = true
    end
end

function onUpdatePost()
    if getModSetting('warningMechanic') then
        if keyboardJustPressed(getModSetting('warningKeybind')['keyboard']) or gamepadJustPressed(getModSetting('warningKeybind')['gamepad']) then
            if canDodge and getProperty('boyfriend.visible') and not getProperty('cpuControlled') then
                dodging = true
                canDodge = false
                runTimer('dodging', dodgeWindow)
                runTimer('dodgeCD', crochet/400)
                playAnim('boyfriend', 'dodge', true)
            end
        end

        if warningDrain > 0 then
            warningDrain = warningDrain - 0.1
            setHealth(getHealth() - (warningDrain*0.002))
        end
    end
end