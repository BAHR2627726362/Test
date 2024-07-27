function onEvent(n,v1,v2)


	if n == 'Black screen' then

	   makeLuaSprite('black', '', 0, 0);
        makeGraphic('black',1280,720,'000000')
	      addLuaSprite('black', true);
	      setLuaSpriteScrollFactor('black',0,0)
	      setProperty('black.scale.x',2)
	      setProperty('black.scale.y',2)
		setProperty('black.alpha',1)
	end



end