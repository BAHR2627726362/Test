function onEvent(n,v1,v2)


	if n == 'Black bg' then

	   makeLuaSprite('blackbg', '', 0, 0);
        makeGraphic('blackbg',1280,720,'ffffff')
	      addLuaSprite('blackbg', false);
	      setLuaSpriteScrollFactor('blackbg',0,0)
	      setProperty('blackbg.scale.x',3)
	      setProperty('blackbg.scale.y',3)
		setProperty('blackbg.alpha',2)
	end



end