# GTM Landing Pages

Static-file server for AI-generated HTML landing pages. Pages are committed directly to `pages/` and served immediately — no build step, no CMS, no database.

## How pages are added

Commit any `.html` file to `pages/`. The Wellspring `GTM - Build Landing Page` workflow does this automatically via the GitHub MCP tool. On push to `main`, GitHub Actions builds a new Docker image and triggers a Komodo redeploy.

Path convention: `pages/<page-slug>.html` → served at `/pages/<page-slug>.html`.

## Local development

```bash
docker compose up --build
```

Open http://localhost:8080/pages/ for the directory listing.

To add a test page:

```bash
echo "<h1>Hello</h1>" > pages/test.html
docker compose up --build
# → http://localhost:8080/pages/test.html
```

## Routing

| Path | Behavior |
|---|---|
| `/` | Redirect → `/pages/` |
| `/pages/` | Directory listing of all `.html` files |
| `/pages/<slug>.html` | Serve file directly |
| Everything else | 404 |

## Deployment (Komodo)

The `docker-compose.yml` references the GHCR image `ghcr.io/diegoibarra93/gtm-landing-pages:latest`. GitHub Actions builds and pushes this image on every push to `main`, then calls the Komodo API to redeploy.

### Required GitHub secrets

| Secret | Value |
|---|---|
| `KOMODO_API_URL` | Your Komodo instance URL |
| `KOMODO_API_KEY` | Komodo API key |
| `KOMODO_API_SECRET` | Komodo API secret |

### Komodo stack name

The workflow triggers the stack named `gtm-landing-pages`. Set this as the stack name in Komodo when creating the deployment.
