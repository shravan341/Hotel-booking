pipeline {
    agent any

    tools {
        nodejs "NODEJS"  // Ensure Windows Node.js is configured in Jenkins Global Tools
    }

    environment {
        BUILD_DIR = "${WORKSPACE}\\build"
        SCRIPTS_DIR = "${WORKSPACE}\\jenkins\\scripts"  // Absolute path with workspace
        APP_URL = "https://hotel-booking56988.vercel.app/"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                bat 'npm install --no-fund --no-audit'  // Suppress npm warnings
            }
        }

        stage('Build App') {
            steps {
                bat 'npm run build'
            }
        }

        stage('Start Server') {
            steps {
                script {
                    // Cleanup any existing processes first
                    bat "call \"${SCRIPTS_DIR}\\kill.bat\""
                    
                    // Start the application
                    bat "call \"${SCRIPTS_DIR}\\deliver.bat\""
                    
                    // Wait for server to start
                    sleep(time: 15, unit: 'SECONDS')
                }
            }
        }

        stage('Preview') {
            steps {
                script {
                    // Interactive confirmation with timeout
                    timeout(time: 30, unit: 'MINUTES') {
                        input message: "App is running at ${APP_URL}. Click Proceed to stop.", 
                              ok: "Proceed"
                    }
                }
            }
        }

        stage('Stop Server') {
            steps {
                script {
                    bat "call \"${SCRIPTS_DIR}\\kill.bat\""
                    bat "echo Cleaning up workspace..."
                    bat "rd /s /q ${BUILD_DIR}"  // Clean build directory
                }
            }
        }
    }

    post {
        always {
            bat "call \"${SCRIPTS_DIR}\\kill.bat\""  // Ensure cleanup even if pipeline fails
            cleanWs()  // Optional: Clean workspace after build
        }
    }
}
