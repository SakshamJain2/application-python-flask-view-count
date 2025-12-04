pipeline {
    agent any

    environment {
        IMAGE_NAME = "view_count:latest"
    }

    stages {
        stage("checkout code") {
            steps {
                echo "pulling latest code from github..."
                git branch: 'main', url: 'https://github.com/SakshamJain2/application-python-flask-view-count.git'
            }
        }

        stage("create container using docker-compose up") {
            steps {
                echo "sanitizing compose file (remove NBSPs) and bringing containers up"
                sh '''
                    sed -i 's/\\xC2\\xA0/ /g' docker-compose.yml || true
                    expand -t 2 docker-compose.yml > /tmp/compose_fixed.yml && mv /tmp/compose_fixed.yml docker-compose.yml || true
                    docker-compose down || true
                    docker-compose up -d --build
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline finished successfully."
        }
        failure {
            echo "Pipeline failed — check console output."
        }
    }
}
