pipeline {
    agent any

    stages {
        
        stage('Build') {
            steps {
                sh 'docker-compose build --no-cache'
                }
            }
 
        stage('Staging') {
            steps {
                sh 'sudo docker-compose up -d'
            }
        }
        
    }
}
