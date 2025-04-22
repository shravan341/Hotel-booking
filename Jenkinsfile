pipeline {
  agent any

  environment {
    NODE_ENV = 'development'
    CI = 'true'
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
        wrap([$class: 'Xvfb']) {
          sh 'npx cypress run --e2e'
          sh 'npx cypress run --component --headless'
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
