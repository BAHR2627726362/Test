-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'MX' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('obj1.alpha', targetAlpha);
			setProperty('obj2.alpha', targetAlpha);
			setProperty('obj4.alpha', targetAlpha);
			setProperty('c.alpha', targetAlpha);
			setProperty('b.alpha', targetAlpha);
			setProperty('lb.alpha', targetAlpha);
			setProperty('l.alpha', targetAlpha);
			setProperty('t.alpha', targetAlpha);
		else
			doTweenAlpha('obj1FadeEventTween', 'obj1', targetAlpha, duration, 'linear');
			doTweenAlpha('obj2FadeEventTween', 'obj2', targetAlpha, duration, 'linear');
			doTweenAlpha('obj4FadeEventTween', 'obj4', targetAlpha, duration, 'linear');
			doTweenAlpha('cFadeEventTween', 'c', targetAlpha, duration, 'linear');
			doTweenAlpha('bFadeEventTween', 'b', targetAlpha, duration, 'linear');
			doTweenAlpha('lbFadeEventTween', 'lb', targetAlpha, duration, 'linear');
			doTweenAlpha('lFadeEventTween', 'l', targetAlpha, duration, 'linear');
			doTweenAlpha('t3FadeEventTween', 't', targetAlpha, duration, 'linear');

		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end
function onCreate()
	setObjectOrder('gf', 14)
end
function onCreate()
	setObjectOrder('obj4', 16)
end