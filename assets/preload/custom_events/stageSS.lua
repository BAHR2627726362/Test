function onEvent(name,value1,value2)


	if name == 'stageSS' then

	makeLuaSprite('obj8', 'mario/EXE1/starman/SS_hide', -1177, -711)
	setObjectOrder('obj8', 0)
	addLuaSprite('obj8', true)
	end
end