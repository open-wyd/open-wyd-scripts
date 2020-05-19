TRUE = 1
FALSE = 0
LUA_ERROR = -1
LUA_NO_ERROR = 0

-- skill Condition type
__sConditionAffect = 0;
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

function getTicketMin( value ) 
	return math.floor(value * 7.5);
end

function getTicketHours( value ) 
	return getTicketMin(60) * value;
end

function getTicketDays( value ) 
	return getTicketHours( 24 ) * value;
end

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

EF_LEVEL        = 1;
EF_HP 			= 4;
EF_MP 			= 5;
EF_POS          = 17;
EF_WTYPE		= 21;
EF_REQ_STR      = 22; 
EF_REQ_INT      = 23;
EF_REQ_DEX      = 24;
EF_REQ_CON      = 25;
EF_VOLATILE 	= 38;
EF_SANC 		= 43;
EF_AMOUNT 		= 61;
EF_INCUBATE 	= 78;
EF_INCUDELAY 	= 84;
EF_ITEMLEVEL 	= 87;
EF_MOBTYPE		= 112;
EF_NOSANC 		= 126;

ITEM_PLACE_EQUIP = 0;
ITEM_PLACE_CARRY = 1;
ITEM_PLACE_CARGO = 2;

params.slot.flag = {
	iSLOT_EQUIP = 1,
    iSLOT_CARRY = 2,
    iSLOT_STORAGE = 3,
	
	SLOT_EQUIP = iLSHIFT(1,0),
    SLOT_CARRY = iLSHIFT(1,1),
    SLOT_CARGO = iLSHIFT(1,2),

    --SLOT_ALL = SLOT_EQUIP+SLOT_CARRY+SLOT_CARGO
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

params.skills = {
	SoulLimit = 1 << 30
};

params.conditions = {
	CONDITION_SLOWNESS             = 01, --  Lentidão
	CONDITION_BUT_SPEED            = 02, --  Velocidade(+)
	CONDITION_LESS_RESISTANCE      = 03, --  Resistência(-)
	CONDITION_ATTACK_BONUS         = 04, --  Ataque_Bônus
	CONDITION_LESS_EVASION         = 05, --  Evasão(-)
	CONDITION_BUT_EVASION          = 06, --  Evasão(+)
	CONDITION_LESS_SPEED           = 07, --  Velocidade(-)
	CONDITION_JEWELRY              = 08, --  Jóia(s)
	CONDITION_BUT_DAMAGE           = 09, --  Dano(+)
	CONDITION_LESS_ATTACK          = 10, --  Ataque(-)
	CONDITION_MAGIC_SHIELD         = 11, --  Escudo_Mágico
	CONDITION_LESS_DEFENSE         = 12, --  Defesa(-)
	CONDITION_ASSAULT              = 13, --  Assalto
	CONDITION_OWNED                = 14, --  Possuído
	CONDITION_BUT_TECHNIQUE        = 15, --  Técnica(+)
	CONDITION_MUTATION             = 16, --  Transformação
	CONDITION_AURA_OF_LIFE         = 17, --  Aura_da_Vida
	CONDITION_CONTROL_MANA         = 18, --  Controle_de_Mana
	CONDITION_IMMUNITY             = 19, --  Imunidade
	CONDITION_POISON               = 20, --  Veneno
	CONDITION_MEDITATION           = 21, --  Meditação
	CONDITION_THUNDER              = 22, --  Trovão
	CONDITION_AURA_BESTIAL         = 23, --  Aura_Bestial
	CONDITION_SAMARITAN            = 24, --  Samaritano
	CONDITION_ELEMENTAL_PROTECTION = 25, --  Proteção_Elemental
	CONDITION_BUT_EVASION2         = 26, --  Evasão(+)
	CONDITION_FREEZE               = 27, --  Congelamento
	CONDITION_INVISIBILITY         = 28, --  Invisibilidade
	CONDITION_EDGE_OF_SOUL         = 29, --  Limite_da_Alma
	CONDITION_PVM_BONUS            = 30, --  Bônus_PvM
	CONDITION_GOLDEN_SHIELD        = 31, --  Escudo_Dourado
	CONDITION_CANCELLATION         = 32, --  Cancelamento
	CONDITION_TRANSFORMATION       = 33, --  Transformação
	CONDITION_FOOD                 = 34, --  Comida
	CONDITION_HP_MP_BONUS          = 35, --  Bônus_HP/MP
	CONDITION_GRAB_POISONOUS       = 36, --  Veneno
	CONDITION_CONNECT_SPECTRAL     = 37, --  Ligação_Espectral
	CONDITION_EXCHANGE_OF_SPIRIT   = 38, --  Troca_de_Espírito
	CONDITION_EXP_BONUS            = 39  --  Bônus_EXP
	-- Atordoado
	-- Esquiva(-)
	-- Magia_Misteriosa
	-- Anti_Magia
	-- Movimento_Zero
	-- Congelar
	-- Chama_Resistente
	-- Sangrar
	-- Última_Resistência
};

global_OWS = {
	environmetIdList = {
		HallOfKephraEnvId = 100,
		InitialCustomEnvId = 100000
	},
	map = {
		zoneIdList = {
			None  		= -1,
			Armia 		= 0,
			Azran 		= 1,
			Erion 		= 2,
			Nippleheim 	= 3,
			Noatum 		= 4
		}
	},
	protocol = {
		defines = {
			ESCENE_FIELD = 30000
		},
		opcode = {
			MSG_SoundEffect = 931 
		}
	},
	questList = {
		BencaoDeDeus 		 		= 1 << 1,
		PilulaOrc 	 		 		= 1 << 2,
		HallOfKefraIsAllowed 		= 1 << 3,
		TrainerOfNewbier_Leader 	= 1 << 4,
		TrainerOfNewbier_Trainer1	= 1 << 5,
		TrainerOfNewbier_Trainer2	= 1 << 6,
		TrainerOfNewbier_Trainer3	= 1 << 7,
		OpportunityCompound			= 1 << 8,
		BalanceCompound				= 1 << 9,
		MolarGargol                 = 1 << 10,
		Unicorn						= 1 << 11
	},
	
	playerEnvironmetIdList = {
		CitizenshipId		= 100000
	}
}
