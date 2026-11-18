# J3 — Azure CLI et ACR

Ressources créées avec Azure CLI, abonnement Azure for Students, région `francecentral`.

| Ressource | Nom | Résultat |
| --- | --- | --- |
| Groupe de ressources | `rg-quiz-app` | `Succeeded` |
| Azure Container Registry (SKU Basic) | `acrquizpar2612` | serveur `acrquizpar2612.azurecr.io` |

Images poussées, tag Git `43e5f8c` :

- `acrquizpar2612.azurecr.io/eval-quiz-app-frontend:43e5f8c`
- `acrquizpar2612.azurecr.io/eval-quiz-app-backend:43e5f8c`

Vérification : `az acr repository list` affiche les deux dépôts, `az acr repository show-tags` affiche `43e5f8c` pour chacun.

## Problème rencontré

`az` était absent du PC. Installation avec `winget install -e --id Microsoft.AzureCLI`, puis nouveau terminal.

La création du groupe a ensuite échoué avec `AADSTS50076` : la session ouverte par `az login` ne satisfaisait pas l’exigence MFA de l’administrateur. Azure CLI a demandé une reconnexion explicite :

```powershell
az logout
az login --tenant "75234489-685f-4bd1-8f8b-adc8102b6655" --scope "https://management.core.windows.net//.default" --claims-challenge "<claims-challenge fourni par Azure CLI>"