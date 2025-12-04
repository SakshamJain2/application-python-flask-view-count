pipeline {
   agent any
   environment {
      IMAGE_NAME = "view_count:latest"
   }
   stages {
      stage("checkout code"){
         steps{
            echo "pulling latest code from github..."
            git branch: 'main', url:'https://github.com/SakshamJain2/application-python-flask-view-count.git'
         }
      }
      stage("build docker images"){
         steps {
            echo "building docker images..."
            sh "docker build -t ${IMAGE_NAME} ."
         }
      }
      stage("create container using docker-compose up") {
         steps {
            echo " creating containers "
            sh "docker-compose down || true "
            sh "docker-compose up -d "
         }
      }
   }
}
