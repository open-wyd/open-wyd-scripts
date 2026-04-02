---
name: new-creature
description: Scaffold a new creature XML file in Data/Creatures/ by collecting all required fields in a single prompt
disable-model-invocation: true
---

# new-creature

Cria um novo arquivo XML de criatura em `Data/Creatures/` seguindo o padrão exato dos arquivos existentes.

## Instruções

Solicite ao usuário **todas** as informações abaixo em uma única mensagem. Agrupe-as por seção para facilitar o preenchimento:

---

**Por favor, forneça os dados da nova criatura:**

**Identidade**
- `name` — nome único da criatura (usado como nome do arquivo e como referência em spawns.xml)
- `level` — nível
- `merchant` — tipo de NPC: `0` = mob, `1` = vendor, `2` = quest NPC (outros valores possíveis)
- `clan` — id do clã
- `class` — id da classe
- `experience` — experiência concedida ao morrer
- `gold` — gold concedido ao morrer

**Health**
- `now` — HP inicial
- `max` — HP máximo
- `regen` — regeneração de HP por tick

**Status**
- `str`, `dex`, `int`, `con`

**Special**
- `special1`, `special2`, `special3`, `special4`

**Strategy**
- `damage`, `magic`, `critical`, `attack_speed`, `move_speed`, `defense`

**Look** (IDs visuais dos equipamentos — use `0` para omitir)
- `corpse` id + brightness
- `helmet` id + brightness
- `armor` id + brightness
- `pants` id + brightness
- `glove` id + brightness
- `boots` id + brightness
- (opcionais) `rigth_weapon`, `left_weapon`, `kingdom`, `mantle` — inclua se necessário

**Shop Items** (apenas se `merchant > 0`)
- Lista de itens: `pos`, `id`, e effects (`id` + `value`) de cada item

---

## Geração do arquivo

Com os dados fornecidos, crie o arquivo `Data/Creatures/<name>.xml` seguindo este template:

```xml
<creature name="NAME" level="LEVEL" merchant="MERCHANT" clan="CLAN" class="CLASS" experience="EXP" gold="GOLD" >
	<health now="NOW" max="MAX" regen="REGEN" />
	<status str="STR" dex="DEX" int="INT" con="CON" />
	<special special1="S1" special2="S2" special3="S3" special4="S4" />
	<strategy damage="DMG" magic="MAGIC" critical="CRIT" attack_speed="ASPD" move_speed="MSPD" defense="DEF"/>
	<look>
		<corpse id="ID" brightness="0" />
		<helmet id="ID" brightness="0" />
		<armor id="ID" brightness="0" />
		<pants id="ID" brightness="0" />
		<glove id="ID" brightness="0" />
		<boots id="ID" brightness="0" />
		<!-- rigth_weapon, left_weapon, kingdom, mantle se fornecidos -->
	</look>
	<!-- shopItems apenas se merchant > 0 -->
</creature>
```

Regras:
- Use tabs para indentação (padrão dos arquivos existentes)
- Omita `<shopItems>` se `merchant = 0`
- Omita tags opcionais de `<look>` que não foram fornecidas
- Após criar o arquivo, informe o caminho e lembre o usuário de adicionar um `<spawn>` correspondente em `Data/spawns.xml` se for um mob
