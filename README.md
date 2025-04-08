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
