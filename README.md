# claude-skills

Skills Claude Code personnels, partagés entre tous les projets.

> [!WARNING]
> **Code généré par IA** : ce repo a été écrit avec Claude Code. Il est fourni **tel quel, sans aucune garantie** : relire les scripts avant de les lancer, leur utilisation se fait **à vos risques et périls**.

## Contenu

| Élément | Rôle | Chargé par Claude Code via |
|---------|------|----------------------------|
| `<nom>/SKILL.md` | Un skill par dossier | Jonction dans `%USERPROFILE%\.claude\skills` |
| `CLAUDE.md` | Règles globales, valables dans tous les projets | Relais `%USERPROFILE%\.claude\CLAUDE.md` qui l'importe |

> [!IMPORTANT]
> Le relais ne fait qu'importer : c'est **le `CLAUDE.md` du repo** qu'il faut éditer.

## Installation

Une fois par machine, **relançable sans risque** :

```powershell
./install.ps1
```

- 🔗 Crée les **jonctions** des skills
- 📄 Crée le `CLAUDE.md` du repo s'il n'existe pas (vide) et son **relais**
- 🌐 Ajoute la base comme remote **`upstream`**

## Créer ou modifier un skill

Le demander à Claude : le skill **`write-personal-skill`** s'en charge, et installe le skill à sa création.

## Base commune

L'outillage vient de [claude-skills-base](https://github.com/Thomas-Billon/claude-skills-base) :

| Vient de la base | Propre à chaque repo perso |
|------------------|----------------------------|
| `install.ps1`, `write-personal-skill`, ce README | Skills, `CLAUDE.md` |

Les mises à jour de la base se récupèrent donc **sans conflit**, tant que ses fichiers ne sont pas modifiés localement :

```powershell
git fetch upstream
git merge upstream/master
```

> [!NOTE]
> Le **premier merge** nécessite `--allow-unrelated-histories` : la base a son propre historique.
