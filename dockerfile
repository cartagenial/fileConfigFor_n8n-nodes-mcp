FROM n8nio/n8n:latest
# Installer le package directement dans l'image
RUN npm install -g n8n-nodes-mcp
