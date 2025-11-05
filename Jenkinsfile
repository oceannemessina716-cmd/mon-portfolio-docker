pipeline {
    agent any
    options {
        // Le nom du canal et l'ID de l'identifiant secret de Slack dans Jenkins
        slackNotifier (
            notifyStart: true,
            notifySuccess: true,
            notifyFailure: true,
            notifyAborted: true,
            channel: '#dev-alerts',
            credentialsId: 'slack-credentials' 
        )
    }

    stages {
        // STAGE 1 : CLONE (Effectué automatiquement si configuré comme Pipeline SCM)
        stage('Clone') {
            steps {
                echo "1/3. Démarrage du clonage (auto par Jenkins)..."
            }
        }

        // STAGE 2 : BUILD
        stage('Build') {
            steps {
                echo "2/3. Construction de l'image Docker..."
                script {
                    // Le point '.' indique que le Dockerfile est à la racine
                    docker.build("mon-portfolio:latest", ".") 
                    // Optional: docker.push("mon-portfolio:latest")
                }
            }
        }

        // STAGE 3 : DEPLOY
        stage('Deploy') {
            steps {
                echo "3/3. Déploiement du conteneur..."
                script {
                    // Arrête et supprime l'ancien conteneur pour un déploiement propre
                    sh 'docker stop portfolio-web-dev || true'
                    sh 'docker rm portfolio-web-dev || true'
                    
                    // Lance le nouveau conteneur sur le port 8081 pour la DEV
                    sh 'docker run -d -p 8081:80 --name portfolio-web-dev mon-portfolio:latest'
                    echo "Déploiement réussi sur le port 8081 (dev)."
                }
            }
        }
    }
    
    // Notifications de fin (Success/Failure)
    post {
        failure {
            slackSend(
                channel: '#dev-alerts',
                color: 'danger',
                message: "🔴 ÉCHEC du Pipeline *${env.JOB_NAME}* #${env.BUILD_NUMBER} à l'étape *${currentBuild.stages.last.name}*."
            )
        }
    }
}