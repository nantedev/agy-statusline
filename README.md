# 📊 Antigravity CLI (`agy`) — Custom Status Line

Une barre d'état légère et colorée pour **Google Antigravity CLI (`agy`)** sous **Linux / WSL / macOS**.  
Elle affiche en temps réel vos métriques essentielles directement sous la zone de saisie du terminal.

## ✨ Fonctionnalités

- 🤖 **Modèle actif** : Affiche le modèle en cours d'utilisation (`Gemini 4 Argon`, `Gemini 3.8 Flash`, `Claude Sonnet/Opus`, `GPT-OSS`, etc.).
- 🧠 **Fenêtre de contexte** : Affiche le pourcentage consommé avec une pastille colorée (🟢 $< 50$ %, 🟠 50-79 %, 🔴 $\ge 80$ %) et les tokens utilisés par rapport au plafond.
- ⏳ **Suivi dynamique des quotas sur 2e ligne** :
  - Filtre automatiquement selon le modèle actif (quotas **Gemini** si Gemini est utilisé, quotas **3p** si un modèle tiers est utilisé).
  - Tri logique par durée : fenêtre courte de **5 heures** en 1er, puis plafond **hebdomadaire**.
  - Indicateur visuel coloré (🟢/🟠/🔴) pour chaque réservoir.

## 📋 Prérequis

L'utilitaire `jq` doit être installé pour analyser le flux JSON envoyé par `agy` :

- **Ubuntu / Debian / WSL :**
  ```bash
  sudo apt update && sudo apt install -y jq
  ```
- **macOS (Homebrew) :**
  ```bash
  brew install jq
  ```

## 🚀 Installation rapide

1. Créez le dossier de configuration global et téléchargez le script :

   ```bash
   mkdir -p ~/.gemini/antigravity-cli
   curl -fsSL https://raw.githubusercontent.com/nantedev/agy-statusline/main/statusline.sh -o ~/.gemini/antigravity-cli/statusline.sh
   chmod +x ~/.gemini/antigravity-cli/statusline.sh
   ```

2. Lancez `agy` dans votre terminal et activez la barre d'état (une seule fois) :
   ```text
   /statusline ~/.gemini/antigravity-cli/statusline.sh
   ```

La configuration est enregistrée de façon permanente dans `~/.gemini/antigravity-cli/settings.json` et se lancera automatiquement à chaque ouverture d'Antigravity CLI.

## 🛠️ Commandes utiles dans `agy`

- `/statusline off` : Masquer temporairement la barre d'état.
- `/statusline on` : Réafficher la barre d'état.
- `/statusline reset` : Revenir à l'affichage par défaut d'Antigravity.
- `/context` : Inspecter en détail quels fichiers ou `.agents/skills/` consomment votre fenêtre de contexte.
