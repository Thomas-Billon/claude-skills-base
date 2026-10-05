---
name: write-personal-skill
description: Crée ou modifie un skill perso de l'utilisateur dans son repo claude-skills. DÉCLENCHER avant toute écriture dans un skill perso — création d'un skill, ajout ou modification d'une règle, d'un exemple ou d'une section dans un skill existant, y compris quand une règle transverse formulée par l'utilisateur doit y être consignée.
---

# Écrire un skill perso

Ce skill s'applique à la création **et** à toute modification d'un skill perso. L'étape 3 ne concerne que la création.

Les skills perso vivent dans le repo git `claude-skills`, un dossier `<nom>/SKILL.md` par skill, et sont chargés par Claude Code via une jonction dans `%USERPROFILE%\.claude\skills`.

## 1. Retrouver le repo

Ne jamais écrire le chemin du repo en dur : le déduire de la jonction de ce skill.

```powershell
$repo = Split-Path (Get-Item "$env:USERPROFILE\.claude\skills\write-personal-skill").Target
```

## 2. Écrire ou modifier le skill

Créer `$repo\<nom>\SKILL.md`, ou éditer le fichier existant :

- `<nom>` en kebab-case, décrivant l'action ou le domaine (`python-writing-style`, `deploy-checklist`).
- Frontmatter obligatoire :
  ```yaml
  ---
  name: <nom>
  description: <ce que fait le skill>. DÉCLENCHER <quand exactement>.
  ---
  ```
- La `description` est le seul texte vu avant chargement : elle doit dire précisément **quand** déclencher le skill, pas seulement ce qu'il contient.
- Le corps : règles et procédure, concises, en français. Pas de chemin en dur vers un élément du repo.
- Exemples de code **toujours génériques** (`Order`, `Customer`, `Document`…), jamais extraits ni inspirés d'un code existant d'un projet : aucun nom de classe, de table, de champ ou de règle métier réel. Vaut aussi pour tout enrichissement d'un skill existant, **y compris quand la règle naît d'une correction faite à l'instant dans un projet** : le code qui vient d'être corrigé ne sert jamais d'exemple.
- **Skill autonome** : il ne mentionne aucun autre skill, ni pour lui déléguer une étape (« suivre le skill X »), ni pour en exiger le chargement, ni comme exemple. Chaque skill se déclenche seul, par sa propre description. Si un skill a besoin de règles portées par un autre, élargir la description de ce dernier pour qu'il se déclenche aussi dans ce cas, plutôt que de dupliquer ses règles.

## 3. Installer (création uniquement)

```powershell
& "$repo\install.ps1"
```

Crée la jonction du nouveau skill (idempotent pour les autres).

## 4. Proposer le commit

À la fin, que le skill soit créé ou modifié, afficher dans le terminal un rappel et proposer un message :

> 💾 Pense à commit le repo claude-skills. Message proposé : `Added logging rules`
> Je commit & push ?

Sans confirmation explicite : aucun commit, aucun push.
