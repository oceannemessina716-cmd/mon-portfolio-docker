pipeline {
    agent any
    
    // Définition des stages
    stages {
        // --- STAGE 1 : CLONE (Effectué automatiquement par le Pipeline SCM de Jenkins) ---
        stage('Clone') {
            steps {
                echo "1/3. Démarrage du clonage (auto par Jenkins)..."
            }
        }

        // --- STAGE 2 : BUILD (Construction de l'Image Docker) ---
        stage('Build') {
            steps {
                echo "2/3. Construction de l'image Docker..."
                script {
                    // Utilise le Dockerfile présent à la racine du workspace
                    docker.build("mon-portfolio:latest", ".") 
                }
            }
        }

        // --- STAGE 3 : DEPLOY (Déploiement du Conteneur sur le port 8081) ---
        stage('Deploy') {
            steps {
                echo "3/3. Déploiement du conteneur..."
                script {
                    // Arrête et supprime l'ancien conteneur (|| true empêche l'étape d'échouer s'il n'existe pas)
                    sh 'docker stop portfolio-web-dev || true'
                    sh 'docker rm portfolio-web-dev || true'
                    
                    // Lance le nouveau conteneur sur le port 8081 pour la DEV
                    sh 'docker run -d -p 8081:80 --name portfolio-web-dev mon-portfolio:latest'
                    echo "Déploiement réussi sur le port 8081 (dev)."
                }
            }
        }
    }
    
    // --- Post-actions pour les notifications (Obligatoire pour votre devoir) ---
    post {
        // Notification en cas de SUCCÈS
        success {
            slackSend(
                channel: '#dev-alerts',
                color: 'good',
                message: "✅ SUCCÈS du Pipeline *${env.JOB_NAME}* #${env.BUILD_NUMBER} (Build : ${env.BUILD_URL}) : Déploiement Terminé."
            )
        }
        
        // Notification en cas d'ÉCHEC
        failure {
            slackSend(
                channel: '#dev-alerts',
                color: 'danger',
                message: "🔴 ÉCHEC du Pipeline *${env.JOB_NAME}* #${env.BUILD_NUMBER} à l'étape *${currentBuild.stages.last.name}*."
            )
        }
    }
}