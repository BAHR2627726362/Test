function onEvent(name, v1, v2)
	if name == 'UI Fade' then
            local easing = 'linear'
            local duration = 1
            local target = ''
            local leaveNotes = 'false'
            --local hudArray = {'healthBar','healthBarBG','iconP1','iconP2','scoreTxt','timeBar','timeBarTxt','timeBarBG'}--normal hud
            local hudArray = {
                  'timePercentMickey',
                  'songTimeMickey',
                  'songNameTextMickey',
                  'scoreTextMickey',
                  'missesTextMickey',
                  'acurracyTextMickey',
                  'sickTextMickey',
                  'goodTextMickey',
                  'badTextMickey',
                  'shitTextMickey',
                  'healthBar',
                  'healthBarBG',
                  'iconP1',
                  'iconP2',
                  'scoreTxt',
                  'timeBar',
                  'timeBarTxt',
                  'timeBarBG'}--mickey hud
            if string.find(v1,',',0,true) ~= nil then
                  local commaStart = 0
                  local commaEnd = 0
                  commaStart,commaEnd = string.find(v1,',',0,true)
                  target = tonumber(string.sub(v1,0,commaStart - 1))
                  leaveNotes = string.sub(v1,commaEnd + 1)
            else
                  target = tonumber(v1)
            end
            if v2 ~= '' then
                  if string.find(v2,',',0,true) ~= nil then
                        local comma1,comma2 = string.find(v1,',',0,true)
                        duration = string.sub(v1,commaEnd + 1,comma1Start - 1)
                        easing = string.sub(v1,comma1End + 1)
                  else
                        duration = tonumber(v2)
                  end
            end
            if easing == '.' then
                  easing = 'linear'
            end
            if target == nil or target == '' then
                  target = 1
            end
            if leaveNotes ~= 'false' then
                  leaveNotes = 'true'
            end

            if target ~= nil then
                  for hudLength = 1,#hudArray do
                        cancelTween('UiFade'..hudArray[hudLength])
                        if duration ~= 0 then
                              doTweenAlpha('UiFade'..hudArray[hudLength],hudArray[hudLength], target, duration, easing)
                        else
                              setProperty(hudArray[hudLength]..'.alpha', target)
                        end
                  end
                  if leaveNotes == 'false' then
                        for strumLineLength = 0,7 do
                              cancelTween('UiFadeNote'..strumLineLength)
                              if duration ~= 0 then
                                    if middlescroll == true and target > 0.3 then
                                          if strumLineLength < 4 then
                                                noteTweenAlpha('UiFadeNote'..strumLineLength, strumLineLength, 0.3, duration, easing)
                                          else
                                                noteTweenAlpha('UiFadeNote'..strumLineLength, strumLineLength, target, duration, easing)
                                          end
                                    else
                                          noteTweenAlpha('UiFadeNote'..strumLineLength, strumLineLength, target, duration, easing)
                                    end
                              else
                                    if middlescroll == true and target > 0.3 then
                                          if strumLineLength < 4 then
                                                setPropertyFromGroup('strumLineNotes', strumLineLength,'alpha',0.3);
                                          else
                                                setPropertyFromGroup('strumLineNotes', strumLineLength,'alpha',target);
                                          end
                                    else
                                          setPropertyFromGroup('strumLineNotes', strumLineLength,'alpha',target);
                                    end
                                    
                              end
                        end
                  end
            end

	end
end