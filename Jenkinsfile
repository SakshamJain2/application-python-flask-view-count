pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-view-count"
        BUILD_TAG  = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Requirements') {
            steps {
                script {
                    if (fileExists('requirements.txt')) {
                        sh "pip3 install -r requirements.txt"
                    } else {
                        echo "requirements.txt not found, skipping installation."
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    dockerImage = docker.build("${IMAGE_NAME}:${BUILD_TAG}")
                }
            }
        }

        stage('Deploy using docker-compose') {
            steps {
                script {
                    echo "Deploying with docker-compose..."

                    // Stop old containers
                    sh """
                        docker-compose down || true
                    """

                    // Start new containers, rebuilding images
                    sh """
                        IMAGE_TAG=${BUILD_TAG} \
                        IMAGE_NAME=${IMAGE_NAME} \
                        docker-compose up -d --build
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Application deployed successfully using docker-compose!"
        }
        failure {
            echo "Build failed. Check console logs."
        }
    }
}
