pipeline {
    agent any

    environment {
        VERSION = "v1.0-${BUILD_NUMBER}-${new Date().format('yyyyMMdd-HHmm')}"
    }

    stages {
        stage('Clone repo') {
            steps {
                git 'https://github.com/твоя-ссылка-на-репозиторий.git'
            }
        }

        stage('Set version') {
            steps {
                script {
                    writeFile file: 'version.txt', text: "${VERSION}"
                    echo "🔖 App version set to: ${VERSION}"
                }
            }
        }

        stage('Build Docker image') {
            steps {
                dir('my-site') {
                    bat 'docker-compose build'
                }
            }
        }

        stage('Run containers') {
            steps {
                dir('my-site') {
                    bat 'docker-compose up -d'
                }
            }
        }

        stage('Health check') {
            steps {
                script {
                    sleep 5 // wait for container to start
                    def response = bat(script: 'curl -s -o nul -w "%{http_code}" http://localhost:5000', returnStdout: true).trim()
                    if (response != "200") {
                        error("❌ Health check failed with response code: ${response}")
                    } else {
                        echo "✅ Health check passed!"
                    }
                }
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment successful!'
            mail to: 'your-email@example.com',
                 subject: '✅ Build Success',
                 body: "Jenkins job '${env.JOB_NAME}' #${env.BUILD_NUMBER} completed successfully."
        }
        failure {
            echo '⚠️ Something went wrong.'
            dir('my-site') {
                bat 'docker-compose down || exit 0'
            }
            mail to: 'your-email@example.com',
                 subject: '❌ Build Failed',
                 body: "Jenkins job '${env.JOB_NAME}' #${env.BUILD_NUMBER} failed."
        }
    }
}

