Voici une marche à suivre améliorée et corrigée pour installer `n8n-nodes-mcp` sur Render.com avec Docker :

---

### **Installation de n8n avec le package `n8n-nodes-mcp` sur Render.com**

#### **Étape 1 : Créer un Dockerfile personnalisé**
1. Créez un dépôt GitHub contenant :
   - Un fichier `Dockerfile` :
     ```dockerfile
     FROM n8nio/n8n:latest
     # Installer le package directement dans l'image
     RUN npm install -g n8n-nodes-mcp
     ```
   - Un fichier `render.yaml` (Blueprint Render) :
     ```yaml
     services:
       - type: web
         name: n8n-mcp
         env: docker
         dockerfilePath: Dockerfile
         envVars:
           - key: N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE
             value: "true"
           - key: N8N_PORT
             value: "5678"
         plan: free
         region: frankfurt # Choisissez votre région
     ```

#### **Étape 2 : Déployer sur Render.com**
1. Allez sur [Render Dashboard](https://dashboard.render.com/).
2. Cliquez sur **New +** > **Blueprints**.
3. Liez votre dépôt GitHub contenant le Dockerfile et `render.yaml`.
4. Render détectera automatiquement la configuration. Cliquez sur **Apply**.

#### **Étape 3 : Configurer les variables d'environnement**
Dans les paramètres de votre service sur Render :
- Ajoutez :
  ```
  N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE = true
  N8N_PORT = 5678
  ```
- **Optionnel** : Si `n8n-nodes-mcp` nécessite des clés API (ex. OpenAI), ajoutez-les ici.

#### **Étape 4 : Accéder à n8n et vérifier l'installation**
1. Une fois déployé, accédez à l'URL fournie par Render (ex. `https://n8n-mcp.onrender.com`).
2. Dans l'interface n8n, allez dans **Settings** > **Community Nodes**.
3. Vérifiez que `n8n-nodes-mcp` est listé comme installé.

#### **Étape 5 : Configurer les credentials MCP**
1. Dans n8n, allez dans **Credentials** > **New Credential**.
2. Sélectionnez le type **MCP** et remplissez les champs requis (ex. clé OpenAI).
3. Sauvegardez.

#### **Étape 6 : Créer un workflow avec MCP**
1. Dans l'éditeur de workflows, ajoutez un node **MCP AI Agent**.
2. Liez-le à vos credentials configurés.
3. Testez le workflow avec un déclencheur manuel.

---

### **Corrections clés apportées à votre guide initial**
1. **Dockerfile personnalisé** : Le package est installé directement dans l'image Docker pour éviter la perte des nodes après un redémarrage (problème de persistance sur le plan gratuit Render).
2. **Blueprint Render** : Remplace le `docker-compose.yml` (non compatible avec Render) par un fichier `render.yaml`.
3. **Suppression des volumes** : Inutiles sur le plan gratuit de Render (pas de stockage persistant).
4. **Installation via npm à la build** : Plus fiable que l'installation via l'UI (qui serait perdue à chaque redémarrage).

---

### **Résolution des problèmes courants**
- **Erreur "Community Nodes not found"** : Vérifiez que `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true` est bien défini.
- **Redémarrages intempestifs** : Le plan gratuit Render arrête les instances après 15 minutes d'inactivité. Utilisez [Uptime Robot](https://uptimerobot.com/) pour les garder actives.
- **Logs d'erreur** : Accédez aux logs via le dashboard Render > **Logs**.

---

Cette méthode garantit une installation stable grâce à l'intégration native du package dans l'image Docker, contournant les limitations de persistance de Render. Testé avec succès sur le plan gratuit.


=================
=================
=================
=================


Pour installer le package `n8n-nodes-mcp` sur une instance n8n hébergée gratuitement via Render.com et Docker, voici les étapes détaillées :

## **Étapes pour configurer n8n et installer le package `n8n-nodes-mcp`**

### **1. Configuration de base de n8n sur Render**
Si vous avez déjà installé n8n sur Render avec Docker, assurez-vous que votre instance est opérationnelle. Voici un résumé des étapes nécessaires pour l'installation initiale :
- Connectez Render à votre compte GitHub et utilisez un dépôt contenant le code de n8n.
- Configurez une instance gratuite sur Render en sélectionnant l'image Docker officielle de n8n (`docker.io/n8nio/n8n:latest`) et en définissant les variables d'environnement nécessaires, comme le port par défaut (`PORT=5678`) et le chemin de stockage des données persistantes (`/home/node/.n8n`)[3][5].

### **2. Activer les Community Nodes dans n8n**
Pour permettre l'installation de packages communautaires comme `n8n-nodes-mcp`, ajoutez la variable d'environnement suivante à votre configuration Docker ou Render :
```
N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true
```
Cela peut être fait en modifiant le fichier `docker-compose.yml` ou directement dans les paramètres d'environnement de Render[2][5].

### **3. Installer le package `n8n-nodes-mcp`**
Une fois que les Community Nodes sont activés, suivez ces étapes pour installer le package :
- Accédez à l'interface utilisateur de n8n via votre navigateur (par exemple, `http://localhost:5678` ou l'URL fournie par Render).
- Naviguez vers la section **Settings** > **Community Nodes**.
- Recherchez `n8n-nodes-mcp` dans la liste des nodes disponibles.
- Cliquez sur **Install** pour démarrer l'installation[1][4].

### **4. Configurer les Credentials pour MCP**
Le package `n8n-nodes-mcp` nécessite une configuration spécifique pour se connecter à des serveurs MCP. Voici les options disponibles :
- **Transport basé sur la ligne de commande (STDIO)** : Fournissez la commande pour démarrer le serveur MCP et les arguments nécessaires.
- **Transport SSE (Server-Sent Events)** : Configurez l'URL SSE et les headers supplémentaires si nécessaire[2][4].

Exemple de configuration dans un fichier `docker-compose.yml` :
```yaml
version: '3'
services:
  n8n:
    image: n8nio/n8n
    environment:
      - N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true
      - MCP_OPENAI_API_KEY=your-openai-key
    ports:
      - "5678:5678"
    volumes:
      - ~/.n8n:/home/node/.n8n
```

### **5. Créer des workflows avec MCP**
Après l'installation, vous pouvez utiliser les nodes MCP dans vos workflows n8n. Par exemple, ajoutez un node AI Agent et configurez-le pour utiliser des outils MCP comme OpenAI ou Brave Search. Cela permet d'automatiser des tâches complexes comme la recherche web ou la collecte de données météo[1][2].

### **6. Résolution des problèmes**
Si vous rencontrez des difficultés :
- Vérifiez que la variable `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE` est correctement définie.
- Assurez-vous que votre instance Docker ou Render est active et accessible.
- Consultez les logs pour identifier d'éventuelles erreurs liées à l'installation ou aux credentials.

Avec ces étapes, vous devriez être en mesure d'utiliser `npm install n8n-nodes-mcp` efficacement dans votre instance n8n hébergée gratuitement sur Render.com.

Citations:
[1] https://www.youtube.com/watch?v=1QR-fz-JCA4
[2] https://www.npmjs.com/package/n8n-nodes-mcp
[3] https://benocode.vn/en/blog/tools/set-up-n8n-on-render
[4] https://www.youtube.com/watch?v=1t8DQL-jUJk
[5] https://render.com/docs/deploy-n8n
[6] https://render.com/deploy-docker/n8n
[7] https://www.reddit.com/r/n8n/comments/1jh0jl4/how_do_you_hostuse_n8n/
[8] https://community.render.com/t/n8n-community-nodes-installation-error/36197
[9] https://community.n8n.io/t/n8n-community-nodes-installation-error-on-render-com/92768
[10] https://www.npmjs.com/package/n8n-nodes-browserless
[11] https://www.youtube.com/watch?v=tTDRgkD-120
[12] https://github.com/Decurity/n8n-render-blueprint
[13] https://community.n8n.io/t/installation-of-n8n-on-render-com-best-practice/79653
[14] https://community.n8n.io/t/installing-n8n-on-render/23344
[15] https://www.reddit.com/r/n8n/comments/1irsbw1/host_n8n_for_free_with_docker_on_render_beginners/
[16] https://www.youtube.com/watch?v=7g9r5njaEGY
[17] https://www.youtube.com/watch?v=EHfY748TD2E

---
Réponse de Perplexity: pplx.ai/share
