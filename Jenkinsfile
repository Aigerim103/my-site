pipeline {
    agent any

    stages {
        stage('Clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Aigerim103/my-site.git'
            }
        }

        stage('Check files') {
            steps {
                bat 'dir'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker-compose build'
            }
        }

        stage('Run App') {
            steps {
                bat 'docker-compose up -d'
            }
        }

        stage('Health Check') {
            steps {
                bat 'timeout /t 5'
                bat 'curl -s http://localhost:5000'
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment successful!'
        }
        failure {
            echo '⚠️ Something went wrong.'
            bat 'docker-compose down || exit 0'
        }
        always {
            echo '🔁 Pipeline finished (success or fail).'
        }
    }
}

