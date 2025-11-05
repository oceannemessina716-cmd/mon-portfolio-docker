# Utilise l'image officielle Nginx en version Alpine (légère) comme base
FROM nginx:alpine

# Copie tous les fichiers de votre répertoire local (le site statique)
# vers le répertoire de publication par défaut de Nginx
# Le '.' représente tout ce qui est dans le dossier 'port_folio'
COPY . /usr/share/nginx/html

# Expose le port 80, le port par défaut de Nginx dans le conteneur
EXPOSE 80

# La commande par défaut de Nginx démarre le serveur.