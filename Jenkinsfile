pipeline {
    agent any
    tools {
        nodejs "NODEJS"  // Ensure Node.js is configured in Jenkins Global Tools
    }
    stages {
        stage('Build') {
            steps {
                bat 'npm install'  // Use bat instead of sh for Windows
            }
        }
        stage('Deliver') {
            steps {
                // Windows equivalent of chmod +x
                bat 'icacls .\\jenkins\\scripts\\deliver.sh /grant Everyone:F'
                bat 'icacls .\\jenkins\\scripts\\kill.sh /grant Everyone:F'
                
                // Execute scripts using PowerShell or WSL bash
                bat 'powershell -Command ".\\jenkins\\scripts\\deliver.sh"'
                
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                
                bat 'powershell -Command ".\\jenkins\\scripts\\kill.sh"'
            }
        }
    }
}
