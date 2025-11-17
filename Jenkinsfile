pipeline {
    agent any

    // Définition des stages
    stages {
        // --- STAGE 1 : CLONE (Effectué automatiquement par le Pipeline SCM de Jenkins) ---
        stage('Clone') {
            steps {
                echo "1/3. Le clonage du dépôt depuis la branche dev est effectué par Jenkins."
            }
        }

        // --- STAGE 2 : BUILD (Construction de l'Image Docker) ---
        stage('Build') {
            steps {
                echo "2/3. Construction de l'image Docker..."
                // COMMANDE CORRIGÉE : Utilisation de 'sh' pour exécuter la commande Docker
                sh 'docker build -t mon-portfolio:latest .'
            }
        }

        // --- STAGE 3 : DEPLOY (Déploiement du Conteneur sur le port 8081) ---
        stage('Deploy') {
            steps {
                echo "3/3. Déploiement du conteneur..."
                // Arrête et supprime l'ancien conteneur
                sh 'docker stop portfolio-web-dev || true'
                sh 'docker rm portfolio-web-dev || true'

                // Lance le nouveau conteneur sur le port 8081 pour la DEV
                sh 'docker run -d -p 8081:80 --name portfolio-web-dev mon-portfolio:latest'
                echo "Déploiement réussi sur le port 8081 (dev)."
            }
        }
    }

    // --- Post-actions pour les notifications ---
    post {
        success {
            // NOTE : Vous devez configurer les "Credentials" Slack dans Jenkins
            slackSend(
                channel: '#dev-alerts',
                color: 'good',
                message: "✅ SUCCÈS du Pipeline *${env.JOB_NAME}* #${env.BUILD_NUMBER} (Build : ${env.BUILD_URL}) : Déploiement Terminé."
            )
        }
        failure {
            slackSend(
                channel: '#dev-alerts',
                color: 'danger',
                // Utilisation de variables d'environnement simples pour éviter les erreurs Groovy
                message: "🔴 ÉCHEC du Pipeline *${env.JOB_NAME}* #${env.BUILD_NUMBER} (Build : ${env.BUILD_URL})."
            )
        }
    }
}
