pipeline {
    agent any
    environment {
        IMAGE_NAME = 'sample-node-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
        NEXUS_REPO = 'http://localhost:8082/repository/docker-hosted'
        DOCKER_CREDENTIALS_ID = 'nexus-docker-creds'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Syed-894/Sample_Java_app.git'
            }
        }

        stage('Build Docker Image') {       
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push to Nexus') {
            steps {
                script {
                    docker.withRegistry("${NEXUS_REPO}", "${DOCKER_CREDENTIALS_ID}") {
                         dockerImage.push("${IMAGE_TAG}")
                         dockerImage.push("latest")
                    }
                }
            }
        }
    }

    post {
        success {
            slackSend (
                channel: '#all-jenkins',
                message: "✅ Build and push successful for ${IMAGE_NAME}:${IMAGE_TAG}",
                color: 'good'
            )
        }
        failure {
            slackSend (
                channel: '#all-jenkins',
                message: "❌ Build failed for ${IMAGE_NAME}:${IMAGE_TAG}",
                color: 'danger'
            )
        }
    }
}
