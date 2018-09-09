function createItem(itemId, effct1, effct2, effct3)
	local item = CItem:new(itemId);
	
	if(effct1 ~= nil) then
		item:setAddValue(0, effct1[1], effct1[2]);
	end
	
	if(effct2 ~= nil) then
		item:setAddValue(1, effct2[1], effct2[2]);
	end
	
	if(effct3 ~= nil) then
		item:setAddValue(2, effct3[1], effct3[2]);
	end
	
	return item;
end

function getClassIdByCorpseId(player)

	local classId = player:getClass();
	if(classId >= 0 and classId <= 3) then
		
		local corpseId = player:getPhace():getId();
		if( corpseId >= 1 and corpseId <= 9 ) then
			return 1;
		elseif( corpseId >= 11 and corpseId <= 19 ) then
			return 2;
		elseif( corpseId >= 21 and corpseId <= 29 ) then
			return 3;
		elseif( corpseId >= 31 and corpseId <= 39 ) then
			return 4;
		else
			return -1;
		end
		
	else
		return -1;
	end
	
	return -1;
end

function getMountScriptId( mountId )
	if( mountId >= 2333 and mountId <= 2335 or mountId >= 2363 and mountId <= 2365 ) then
		return 1;
	elseif( mountId >= 2336 and mountId <= 2338 or mountId >= 2341 and mountId <= 2343 or mountId >= 2366 and mountId <= 2368 or mountId >= 2371 and mountId <= 2373 ) then
		return 2;
	elseif( mountId >= 2339 and mountId <= 2340 or mountId >= 2344 and mountId <= 2345 or mountId >= 2369 and mountId <= 2370 or mountId >= 2374 and mountId <= 2375 ) then
		return 3;
	elseif( mountId >= 2346 and mountId <= 2348 or mountId >= 2376 and mountId <= 2378 ) then
		return 4;
	elseif( mountId >= 2351 and mountId <= 2353 or mountId >= 2381 and mountId <= 2383 ) then
		return 5;
	elseif( mountId >= 2354 and mountId <= 2356 or mountId >= 2384 and mountId <= 2386 ) then
		return 6;
	elseif( mountId >= 2349 and mountId <= 2350 or mountId >= 2379 and mountId <= 2380 ) then
		return 7;
	else
		return 0;
	end
end
