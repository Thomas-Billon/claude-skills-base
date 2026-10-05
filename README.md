# claude-skills

Skills Claude Code personnels, partagés entre tous les projets.

Chaque skill est un dossier `<nom>/SKILL.md`, chargé par Claude Code via une jonction dans `%USERPROFILE%\.claude\skills`.

Le `CLAUDE.md` à la racine contient les règles globales, valables dans tous les projets. Claude Code le charge via `%USERPROFILE%\.claude\CLAUDE.md`, un simple relais qui l'importe : c'est le fichier du repo qu'il faut éditer.

Installation (une fois par machine, relançable sans risque), qui crée les jonctions des skills, le `CLAUDE.md` du repo s'il n'existe pas encore (vide), son relais et le remote `upstream` :

```powershell
./install.ps1
```

Pour créer ou modifier un skill, demander à Claude : le skill `write-personal-skill` s'en charge (et l'installe à la création).

## Base commune

L'outillage (`install.ps1`, `write-personal-skill`, ce README) vient de [claude-skills-base](https://github.com/Thomas-Billon/claude-skills-base). Skills et `CLAUDE.md` sont propres à chaque repo perso, la base n'en contient aucun : les mises à jour se récupèrent donc sans conflit, tant que les fichiers de la base ne sont pas modifiés localement.

`install.ps1` ajoute la base comme remote `upstream`. Récupérer les mises à jour de la base :

```powershell
git fetch upstream
git merge upstream/master
```

Le premier merge nécessite `--allow-unrelated-histories`, la base ayant son propre historique.
