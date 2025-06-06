pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Aigerim103/my-site.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker-compose build'
            }
        }

        stage('Run App') {
            steps {
                sh 'docker-compose up -d'
            }
        }

        stage('Health Check') {
            steps {
                script {
                    sleep 5
                    def response = sh(script: "curl -s http://localhost:5000", returnStdout: true).trim()
                    if (!response.contains("Welcome")) {
                        error("App failed health check!")
                    }
                }
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment successful!'
        }
        failure {
            echo '⚠️ Build failed. Rolling back...'
            sh 'docker-compose down'
        }
    }
}
