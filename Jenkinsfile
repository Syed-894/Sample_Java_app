pipeline {
    agent { label 'docker-agent' }

    parameters {
        string(name: 'TAG', defaultValue: 'latest', description: 'Docker image tag')
    }

    environment {
        IMAGE_NAME = 'sample-node-app'
        IMAGE_TAG = "${params.TAG}"
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
                    def dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
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
            echo "✅ Build succeeded!"
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}
