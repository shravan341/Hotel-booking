pipeline {
    agent any

    tools {
        nodejs "NODEJS"  // Ensure this is configured for Windows in Jenkins
    }

    environment {
        BUILD_DIR = 'build'
        SCRIPTS_DIR = '.\\jenkins\\scripts'  // Use Windows path separator
    }

    stages {
        stage('Install Dependencies') {
            steps {
                bat 'npm install'  // Changed to bat
            }
        }

        stage('Build App') {
            steps {
                bat 'npm run build'  // Changed to bat
            }
        }

        stage('Start Server') {
            steps {
                // Remove chmod as it's not needed on Windows
                bat "call ${SCRIPTS_DIR}\\kill.bat"  // Changed to .bat scripts
                bat "call ${SCRIPTS_DIR}\\deliver.bat"
            }
        }

        stage('Preview') {
            steps {
                input message: 'App is running on https://hotel-booking56988.vercel.app/. Click "Proceed" to stop it.'
            }
        }

        stage('Stop Server') {
            steps {
                bat "call ${SCRIPTS_DIR}\\kill.bat"  // Changed to .bat
            }
        }
    }
}
