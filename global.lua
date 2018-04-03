TRUE = 1
FALSE = 0
LUA_ERROR = -1
LUA_NO_ERROR = 0

-- skill Condition type
__sConditionEffect = 0;
__sConditionType = 1;

ms = {
	sec = function ( value ) 
		return value*1000;
	end,

	min = function ( value ) 
		return value * (60*1000);
	end,

	hour = function ( value ) 
		return value * (60*(60*1000));
	end
}



params = { find = {flag = {}}, slot = {flag = {}}, party = {}};
params.find.flag = {
    iT_ID = 0,
    iT_ADD = 1,
    iT_VAL = 4,
    iT_ORD = 7,
    iT_OR = 10,
    iT_MORE = 13,
    iT_LESS = 16,

    T_ID = iLSHIFT(1,0),
    T_ADD1 = iLSHIFT(1,1), T_ADD2 = iLSHIFT(1,2), T_ADD3 = iLSHIFT(1,3),
    T_VAL1 = iLSHIFT(1,4), T_VAL2 = iLSHIFT(1,5), T_VAL3 = iLSHIFT(1,6),
    T_ORD1 = iLSHIFT(1,7), T_ORD2 = iLSHIFT(1,8), T_ORD3 = iLSHIFT(1,9),
    T_OR1  = iLSHIFT(1,10), T_OR2  = iLSHIFT(1,11), T_OR3  = iLSHIFT(1,12),
    T_MORE1= iLSHIFT(1,13), T_MORE2= iLSHIFT(1,14), T_MORE3= iLSHIFT(1,15),
    T_LESS1= iLSHIFT(1,16), T_LESS2= iLSHIFT(1,17), T_LESS3= iLSHIFT(1,18),

    --T_ADD = T_ADD1+T_ADD2+T_ADD3,
    --T_VAL = T_VAL1+T_VAL2+T_VAL3,
    --T_ORD = T_ORD1+T_ORD2+T_ORD3,
    --T_OR  = T_OR1+T_OR2+T_OR3,
    --T_MORE = T_MORE1+T_MORE2+T_MORE3,
    --T_LESS = T_LESS1+T_LESS2+T_LESS3,
    --T_ADD2VAL = T_ADD1+T_ADD2+T_ADD3+T_VAL1+T_VAL2+T_VAL3,
    --T_FULL = T_ID+T_ADD1+T_ADD2+T_ADD3+T_VAL1+T_VAL2+T_VAL3
};

params.slot.flag = {
	iSLOT_EQUIP = 1,
    iSLOT_INVENTORY = 2,
    iSLOT_STORAGE = 3,
	
	SLOT_EQUIP = iLSHIFT(1,0),
    SLOT_INVENTORY = iLSHIFT(1,1),
    SLOT_STORAGE = iLSHIFT(1,2),

    --SLOT_ALL = SLOT_EQUIP+SLOT_INVENTORY+SLOT_STORAGE
};

params.eventTask = {
	EXECUTE = 1,
	LOAD	= 2,
    START 	= 3,
    STOP 	= 4,
	FINALLY	= 5
};

params.eventMap = {
	castleWar = {
		{from = {x = 1039, y = 1679}, to = {x = 1151, y = 1703}}, -- primeiro bloco de posições.
		{from = {x = 1076, y = 1703}, to = {x = 1151, y = 1776}}  -- Segundo bloco de posições.
																  -- blocos em diante
	}
};

params.party = {
	members = {all = 0, player = 1, npc = 2};
};
