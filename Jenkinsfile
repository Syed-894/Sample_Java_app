pipeline {
    agent any

    environment {
        IMAGE_NAME = 'sample-node-app'
        IMAGE_TAG = 'latest'
        NEXUS_REPO = 'http://localhost:8081/repository/docker-hosted'
        DOCKER_CREDENTIALS_ID = 'nexus-docker-creds'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Syed-894/Sample_Java_app.git'
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
                        dockerImage.push()
                    }
                }
            }
        }
    }

    post {
        success {
            slackSend (
                channel: '#build-status',
                message: "✅ Build and push successful for ${IMAGE_NAME}:${IMAGE_TAG}",
                color: 'good'
            )
        }
        failure {
            slackSend (
                channel: '#build-status',
                message: "❌ Build failed for ${IMAGE_NAME}:${IMAGE_TAG}",
                color: 'danger'
            )
        }
    }
}
