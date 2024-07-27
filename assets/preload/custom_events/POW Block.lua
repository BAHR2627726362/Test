function onEvent(n,v1,v2)
    if n == "POW Block" and getModSetting('POWmechanic') then
        doTweenY('POW1', 'POW', 200, crochet/2000, 'cubeOut')
        playSound('POW1', 1)
        angle = angleAmount
    end
end

function onCreate()
    POWdamage = getModSetting('POWdamage')
    if getModSetting('jumpGravity') == 'Low' then
        gravity = 2
    elseif getModSetting('jumpGravity') == 'High' then
        gravity = 0.5
    else
        gravity = 1
    end

    dodgeWindow = 0.1
    if getModSetting('POWwindow') == 'Strict' then
        dodgeWindow = 0.2
    elseif getModSetting('POWwindow') == 'Lenient' then
        dodgeWindow = 0.001
    end

    makeLuaSprite('POW', 'EXE/SS_POWblock', 150, 800)
    if not middlescroll then
        screenCenter('POW', 'x')
    end
    setObjectCamera('POW', 'hud')
    addLuaSprite('POW', true)

    makeAnimatedLuaSprite('jumpybf', 'characters/MM_Boyfriend_Assets_jump', getProperty('boyfriend.x') - 40, getProperty('boyfriend.y') - 20)
    addAnimationByPrefix('jumpybf', 'jump', 'JUMP', 24, false)
    addAnimationByPrefix('jumpybf', 'land', 'LAND', 24, false)
    addOffset('jumpybf', 'jump', 0, 300)
    addOffset('jumpybf', 'land', 0, 30)
    setProperty('jumpybf.visible', false)
    addLuaSprite('jumpybf', true)

    ogBFY = getProperty('boyfriend.y')
end

angle = 0
angleAmount = 40

canJump = true
jumping = false
falling = false
gravity = 1

dodged = false
POWdrain = 0
POWdamage = 10

function onUpdatePost()
    if getModSetting('POWmechanic') then
        if keyboardJustPressed(getModSetting('POWkeybind')['keyboard']) or gamepadJustPressed(getModSetting('POWkeybind')['gamepad']) then
            if canJump and not getProperty('cpuControlled') then
                canJump = false
                jumping = true
                runTimer('dodging', dodgeWindow)
                setProperty('boyfriend.visible', false)
                setProperty('jumpybf.visible', true)
                runTimer('animDelay', 0.1)
                playAnim('jumpybf', 'jump')
            end
        end

        if getProperty('jumpybf.animation.curAnim.name') == 'land' and falling then
            if getProperty('jumpybf.animation.curAnim.curFrame') == 1 then
                canJump = true
            elseif getProperty('jumpybf.animation.curAnim.curFrame') == 4 then
                falling = false
                setProperty('boyfriend.visible', true)
                setProperty('jumpybf.visible', false)
            end
        end

        if POWdrain > 0 then
            POWdrain = POWdrain - 0.1
            setHealth(getHealth() - (POWdrain*0.002))
        end

        if angle > 0 then
            angle = angle - (1 * (240 / getPropertyFromClass('backend.ClientPrefs','data.framerate')))
        end

        setProperty('POW.angle', getRandomFloat(-angle, angle))
    end
end

function onTimerCompleted(tag)
    if tag == 'animDelay' then
        doTweenY('jump', 'jumpybf', ogBFY - gravity*500, gravity/2, 'cubeOut')
        playSound('bfjump')
    end
    if tag == 'dodging' then
        dodged = true
    end
end

function onTweenCompleted(tag)
    if tag == 'jump' then
        jumping = false
        falling = true
        doTweenY('fall', 'jumpybf', ogBFY, (gravity/2)*0.6, 'cubeIn')
    elseif tag == 'fall' then
        dodged = false
        playAnim('jumpybf', 'land')
    end

    if tag == 'POW1' then
        doTweenY('POW2', 'POW', 300, crochet/2000, 'cubeInOut')
    elseif tag == 'POW2' then
        doTweenY('POW3', 'POW', 100, crochet/2000, 'cubeInOut')
        playSound('POW1', 1)
        angle = angleAmount
        if getProperty('cpuControlled') then
            canJump = false
            jumping = true
            dodged = true
            setProperty('boyfriend.visible', false)
            setProperty('jumpybf.visible', true)
            runTimer('animDelay', 0.1)
            playAnim('jumpybf', 'jump')
        end
    elseif tag == 'POW3' then
        doTweenY('POW4', 'POW', 800, crochet/2000, 'cubeIn')
    elseif tag == 'POW4' then
        if not dodged then
            POWdrain = POWdamage
            playAnim('boyfriend', 'hurt')
        end
        playSound('POW3', 1)
    end
end