# Open WYD Scripts


## Estrutura

- **global.lua**: Contexto global para todo o jogo (valores constantes, parametros para as funções, ...)
- **pastas**: cada pasta guarda os scripts relativos a um tipo de elemento do jogo (eventos, itens, NPCs, teleports, ...)
  - **arquivo xml**: associa elementos do jogo aos scripts com ações
  - **lib**: scripts de biblioteca, utilizado como contexto para dos demais scripts, ideal para reutilizar funcionalidades comum aos scripts
  - **scripts**: ações a serem executadas no jogo quando interações descritas no **arquivo xml** ocorrerem
