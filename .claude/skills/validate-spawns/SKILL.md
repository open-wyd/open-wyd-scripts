---
name: validate-spawns
description: Valida referências de criaturas em Data/spawns.xml cruzando com Data/Creatures/*.xml, reporta nomes quebrados com sugestões e oferece correção automática
disable-model-invocation: true
---

# validate-spawns

Verifica se todos os valores de `leader` e `follower` em `Data/spawns.xml` possuem um arquivo XML correspondente em `Data/Creatures/`.

## Passos

### 1. Coletar nomes referenciados em spawns.xml

Extraia todos os valores únicos dos atributos `leader` e `follower` de `Data/spawns.xml`:

```bash
grep -oP '(?<=leader=")[^"]+|(?<=follower=")[^"]+' Data/spawns.xml | sort -u
```

### 2. Coletar nomes de arquivo existentes

Liste todos os arquivos em `Data/Creatures/` sem a extensão `.xml`:

```bash
ls Data/Creatures/*.xml | xargs -I{} basename {} .xml | sort
```

### 3. Identificar referências quebradas

Compare as duas listas. Para cada nome referenciado em spawns.xml que **não** possui arquivo correspondente:

- Calcule a similaridade com os nomes existentes usando distância de edição (Levenshtein) ou prefixo comum
- Identifique o candidato mais próximo

### 4. Exibir relatório

Apresente o resultado no formato:

```
Referências quebradas em spawns.xml: N

  ❌ NomeQuebrado
     → Sugestão: NomeSimilar (ou "sem sugestão próxima")

  ❌ OutroNome
     → Sugestão: OutroSimilar
```

Se não houver problemas:
```
✓ Todas as referências em spawns.xml são válidas.
```

### 5. Oferecer correção automática

Se houver problemas, pergunte:

> "Deseja aplicar as correções sugeridas automaticamente em `Data/spawns.xml`? Responda com `sim` para aplicar todas, ou informe quais corrigir."

Ao confirmar, substitua cada ocorrência do nome quebrado (nos atributos `leader` e `follower`) pelo nome correto sugerido. Aplique apenas as correções que o usuário confirmar.

Após aplicar, informe quantas substituições foram feitas.
