Chance = iRandomNumber( 100 )

function newclass( player, classid )
	
	if( classid >= 0 and classid <= 3 ) then
		
		local mobid = player.mobid;
		if( mobid >= 1 and mobid <= 9 ) then
			mobid = classid+6;
		elseif( mobid >= 11 and mobid <= 19 ) then
			mobid = classid+16;
		elseif( mobid >= 21 and mobid <= 29 ) then
			mobid = classid+26;
		elseif( mobid >= 31 and mobid <= 39 ) then
			mobid = classid+36;
		else
			Log("2 newclass( "..player.mob.name..", "..classid.." ) : not found ");
			return FALSE;
		end
		player.mobid = mobid;
		player.mob.Phace.itemid = mobid;
		player.mob.classid = classid;
	else
		Log("1 newclass( "..player.mob.name..", "..classid.." ) : not found ");
		return FALSE;
	end
	
	return TRUE;
end


itensCheck = {}; -- Não modificar..reiniciar a lista
index = 0; -- Não modificar..reiniciar a index da lista
