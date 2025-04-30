pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    bat 'npm install --no-fund --no-audit'
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    bat 'npm run build'
                }
            }
        }

        stage('Start Server') {
            steps {
                script {
                    bat 'call "jenkins\\scripts\\kill.bat"'
                    sleep(time: 5, unit: 'SECONDS')  // Add cleanup delay
                    bat 'call "jenkins\\scripts\\deliver.bat"'
                }
            }
        }

        stage('Preview') {
            steps {
                script {
                    timeout(time: 30, unit: 'MINUTES') {
                        input message: 'App is running at http://localhost:3000. Click Proceed to stop.', 
                               ok: 'Proceed'
                    }
                }
            }
        }

        stage('Stop Server') {
            steps {
                script {
                    bat 'call "jenkins\\scripts\\kill.bat"'
                    sleep(time: 5, unit: 'SECONDS')
                    bat 'rd /s /q build || echo Build folder cleanup failed'
                }
            }
        }
    }
    
    post {
        always {
            script {
                bat 'call "jenkins\\scripts\\kill.bat"'
                sleep(time: 5, unit: 'SECONDS')
                cleanWs(
                    cleanWhenAborted: true,
                    cleanWhenFailure: true,
                    cleanWhenSuccess: true,
                    notFailBuild: true
                )
            }
        }
    }
}
