pipeline {
  agent any

  environment {
    NODE_ENV = 'development'
    CI = 'true'
    DISPLAY = ':99'  // Set the DISPLAY environment variable for Xvfb
  }

  tools {
    nodejs 'nodejs'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'npm ci'
      }
    }

    stage('Lint & Format Check') {
      steps {
        sh 'npm run lint:check'
        sh 'npm run format:check'
      }
    }

    stage('Run Cypress Tests') {
      steps {
        script {
          // Start Xvfb in the background
          sh 'Xvfb :99 -screen 0 1024x768x24 &'
          // Run Cypress tests
          sh 'npx cypress run --e2e'
          sh 'npx cypress run --component --headless'
          // Stop Xvfb after tests
          sh 'pkill Xvfb'
        }
      }
    }

    stage('Build') {
      steps {
        sh 'npm run build'
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'build/**', fingerprint: true
    }
    failure {
      echo '❌ Pipeline failed.'
    }
    success {
      echo '✅ Pipeline succeeded.'
    }
  }
}
