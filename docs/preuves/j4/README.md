# J4 — Frontend et backend dans Azure Container Apps

## Ressources

| Ressource | Nom | Rôle |
| --- | --- | --- |
| Environnement Container Apps | `cae-quiz-app` | plan Consumption, domaine `agreeablefield-58d92aad.francecentral.azurecontainerapps.io` |
| Identité managée | `id-quiz-acr` | rôle `AcrPull` sur le registre `acrquizpar2612` |
| Application | `backend` | image `acrquizpar2612.azurecr.io/eval-quiz-app-backend:43e5f8c`, port cible **3007** |
| Application | `frontend` | image `acrquizpar2612.azurecr.io/eval-quiz-app-frontend:43e5f8c-4`, port cible **8080** |

Les deux applications tirent leurs images depuis ACR avec l’identité `id-quiz-acr`. Aucun compte admin du registre n’est utilisé.

## Révisions

| Application | Révision | Active | Réplicas | Trafic | Santé | État |
| --- | --- | --- | --- | --- | --- | --- |
| backend | `backend--latest` | True | 1 | 100 | Healthy | Provisioned |
| frontend | `frontend--latest` | True | 1 | 100 | Healthy | Provisioned |

La révision frontend a ensuite été recréée avec l’image `43e5f8c-4`. Elle est restée active, saine et provisionnée.

## URLs et test `/health`

- Frontend : `https://frontend.agreeablefield-58d92aad.francecentral.azurecontainerapps.io`
- Backend : `https://backend.agreeablefield-58d92aad.francecentral.azurecontainerapps.io/health`

Exemple de retour du backend :

```text
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"status":"ok"}