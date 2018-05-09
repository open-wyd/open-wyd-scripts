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
