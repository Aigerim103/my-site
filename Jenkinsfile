pipeline {
    agent any

    environment {
        COMPOSE_DOCKER_CLI_BUILD = '1'
        DOCKER_BUILDKIT = '1'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Clone repo') {
            steps {
                bat 'git clone https://github.com/Aigerim103/my-site.git'
            }
        }

        stage('Check files') {
            steps {
                dir('my-site') {
                    bat 'dir'
                }
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
                echo 'Waiting for app to start...'
                bat 'ping 127.0.0.1 -n 6 > nul'
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

