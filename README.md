# 📊 Antigravity CLI (`agy`) — Custom Status Line

Une barre d'état légère et colorée pour **Google Antigravity CLI (`agy`)** sous **Linux / WSL / macOS**.  
Elle affiche en temps réel vos métriques essentielles directement sous la zone de saisie du terminal.

## ✨ Fonctionnalités

- 🤖 **Modèle actif** : Affiche le modèle en cours d'utilisation (`Gemini 4 Argon`, `Gemini 3.8 Flash`, `Claude Sonnet/Opus`, `GPT-OSS`, etc.).
- 🧠 **Fenêtre de contexte dynamique** : Affiche le pourcentage et le volume de tokens utilisés (`used/max`) avec un code couleur intuitif :
  - 🟢 **Vert** : `< 50%` (confortable)
  - 🟡 **Jaune** : `50% - 79%` (attention à la taille du contexte)
  - 🔴 **Rouge** : `≥ 80%` (proche de la saturation)
- 🔋 **Suivi des quotas en direct** : Affiche les jauges restantes pour la session de **5 heures** et le plafond **hebdomadaire (7j)**.

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
   curl -fsSL https://githubusercontent.com<TON-PSEUDO>/<NOM-DU-REPO>/main/statusline.sh -o ~/.gemini/antigravity-cli/statusline.sh
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
