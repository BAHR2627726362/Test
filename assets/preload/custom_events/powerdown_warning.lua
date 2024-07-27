function onEvent(name,value1,value2)
	if name == 'powerdown_warning' and value1 == 'nose' then

	makeLuaSprite('cuidao0', 'cuidao0', 640, 300);
	setObjectCamera('cuidao0', 'other');
	scaleLuaSprite('cuidao0', 6, 6); 
  doTweenAngle('cuidao0', 'cuidao0', -20, 0.5, 'expoOut')
  addLuaSprite('cuidao0', true);     
  setProperty('cuidao0.antialiasing', false);
  playSound('warningmx', 1);
	end
	if value1 == 'DOS' then
   doTweenAngle('cuidaonose', 'cuidao0', 0, 0.5, 'expoOut')
   doTweenAlpha('cuidao0', 'cuidao0', 0, 0.4)
   end
end