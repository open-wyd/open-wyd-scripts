# Open WYD Scripts


## Estrutura
--------------------------------------------------------------------------------------------------------------------------
- ##### **Contexto global**
- **global.lua**: Contexto global (valores constantes, parâmetros para as funções, ...)
- **language.lua**: Informações sobre idiomas utilizado nos scritpts.
--------------------------------------------------------------------------------------------------------------------------
- ##### **Pastas**
- **Configuação**
- - **Data**: Arquivos gerais de configuração do servidor.
- - - **Creatures**: Arquivos .xml que possui as configurações das criaturas no jogo, ex: [Aki.xml](https://github.com/open-wyd/open-wyd-scripts/blob/master/Data/Creatures/Aki.xml). 
--------------------------------------------------------------------------------------------------------------------------
- **Modulos**
- **Events**: Modulo de eventos, detém todos os tipos de eventos no jogo ex: [up-level.lua](https://github.com/open-wyd/open-wyd-scripts/blob/master/Events/scripts/up-level/up-level.lua).
- - **arquivo xml**: associa elementos do jogo aos scripts com ações
- - **Libs**: scripts de biblioteca, utilizado como contexto global do modulo, ideal para reutilizar funcionalidades comum aos scripts.
- - **scripts**: ações a serem executadas no jogo quando interações descritas no **arquivo xml** ocorrerem.
- **Itens**: Modulo de itens que detém as funcionalidades básicas dos volatiles, ex: [Agua-n-s-1.lua](https://github.com/open-wyd/open-wyd-scripts/blob/master/Itens/scripts/Agua%20N/Agua-n-s-1.lua)
- - **arquivo xml**, **Libs** e  **scripts**: Funcionalidades similar ao descrito pelo modulo **Events**.
- **Merchants**: Modulo de Npc que possui as funcionalidades dos merchants, ex: [Mount_Master.lua](https://github.com/open-wyd/open-wyd-scripts/blob/master/Merchants/scripts/Mount_Master.lua)
- - **arquivo xml**, **Libs** e  **scripts**: Funcionalidades similar ao descrito pelo modulo **Events**.
- **Teleports**: Modulo de teletransportes, ex: [ArmiaToNoaton.lua](https://github.com/open-wyd/open-wyd-scripts/blob/master/Teleports/scripts/Armia/ArmiaToNoaton.lua)
- - **arquivo xml**, **Libs** e  **scripts**: Funcionalidades similar ao descrito pelo modulo **Events**.
--------------------------------------------------------------------------------------------------------------------------

## API da plataforma

### Módulo de eventos.
```
Definitions of types: 
    EVENT_TASK_NONE
    EVENT_TASK_EXECUTE
    EVENT_TASK_LOAD
    EVENT_TASK_START
    EVENT_TASK_STOP
    EVENT_TASK_FINNALY
```

```
Type: 
	EnvironmentEvent

Constructor:
    EnvironmentEvent()
   
Properties:
    number    envId
    CPosition from
    CPosition to
    CPosition center
    Player    owner
    Npc       npc
    
Methods:
    string  getName()
    void    setName(string newName)
    number  getEnvId()
    number  getEventTaskId()
    number  getTime()
    void    setTime(number newTime)
    boolean isStarted()
    void    start()
    void    stop()
    void    resetNpc()
    void    addMonster(string creatureName, number maxCreatures, number centerx, number centery, boolean randomPos = true)
    void    addRespawn(string respawnName, number respawnId, number centerx, number centery, boolean randomPos = true)
    void    executeSpawn(number respawnId)
    number  executeCreature(number creatureId)
    boolean addPlayer(ScriptEvent scriptEvent, Player player, CPosition pos)
    boolean addGroup(ScriptEvent scriptEvent, Player player, CPosition pos)
    boolean removePlayer(Player player, CPosition pos)
    number  removeAllPlayer(CPosition pos)
    number  checkPlayer()
    number  checkSpawn(number respawnId)
    void    addTask(ScriptEvent scriptEvent)
    boolean addScheduler(number delay, ScriptEvent scriptEvent)
    boolean removeTask()
    boolean InZone(CPosition pos)
    boolean InZone(Player player)
    void    sendTime(number sec, boolean inZone)
    void    sendEventMapEffect(number effectId)
```
--------------------------------------------------------------------------------------------------------------------------

