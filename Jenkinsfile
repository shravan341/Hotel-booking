pipeline {
    agent any

    tools {
        nodejs "NODEJS"
    }

    environment {
        BUILD_DIR = 'build'
        SCRIPTS_DIR = './jenkins/scripts'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build App') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Start Server') {
            steps {
                sh "chmod +x ${SCRIPTS_DIR}/kill.sh ${SCRIPTS_DIR}/deliver.sh"
                sh "${SCRIPTS_DIR}/kill.sh || true"
                sh "${SCRIPTS_DIR}/deliver.sh"
            }
        }

        stage('Preview') {
            steps {
                input message: 'App is running on https://hotel-booking56988.vercel.app/. Click "Proceed" to stop it.'
            }
        }

        stage('Stop Server') {
            steps {
                sh "${SCRIPTS_DIR}/kill.sh || true"
            }
        }
    }
}
