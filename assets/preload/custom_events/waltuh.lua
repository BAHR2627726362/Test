function onCreate()
	makeLuaSprite('wilterBlackScreen', nil, -700, -500);
	makeGraphic('wilterBlackScreen', screenWidth * 2, screenHeight * 2, '000000');
	setScrollFactor('wilterBlackScreen', 0, 0);
	setProperty('wilterBlackScreen.alpha', 0.00001);
	addLuaSprite('wilterBlackScreen', false);
	setObjectOrder('wilterBlackScreen', getObjectOrder('gfGroup'));
end

timesCount = 0;
function onEvent(name, value1, value2)
	if name == "waltuh" then
		newTargetZoom = tonumber(value1);
		setProperty('camGame.zoom', newTargetZoom * 1.05);
		doTweenZoom('wilterCamTween', 'camGame', newTargetZoom, 0.7, 'elasticOut');
		if timesCount < 3 then
			doTweenAlpha('wilterBlackAlphaTween', 'wilterBlackScreen', (timesCount + 1) * 0.22, 0.5, 'sineOut');
		end
		timesCount = timesCount + 1;
		spawnTrail('BF');
		spawnTrail('Dad');
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	cancelTween('wilterBlackAlphaTween');
	cancelTween('wilterCamTween');
	doTweenAlpha('wilterBlackAlphaTweenEnd', 'wilterBlackScreen', 0, 0.5, sineOut);
end

function onTweenCompleted(tag)
	if tag == 'wilterBlackAlphaTweenEnd' then
		removeLuaSprite('wilterBlackScreen');
	end
end