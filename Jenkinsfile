pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Clone repo') {
            steps {
                bat 'IF EXIST my-site (rmdir /s /q my-site)'
                bat 'git clone https://github.com/Aigerim103/my-site.git'
            }
        }

        stage('Check files') {
            steps {
                bat 'dir my-site'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('my-site') {
                    bat 'docker-compose build'
                }
            }
        }

        stage('Run App') {
            steps {
                dir('my-site') {
                    bat 'docker-compose up -d'
                }
            }
        }

        stage('Health Check') {
            steps {
                bat 'ping 127.0.0.1 -n 6 > nul'
            }
        }

        stage('Post Actions') {
            steps {
                echo 'Pipeline complete'
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment successful!'
        }
        failure {
            echo '⚠️ Something went wrong.'
            dir('my-site') {
                bat 'docker-compose down || exit 0'
            }
        }
    }
}
