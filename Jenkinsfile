pipeline {
  agent any

  environment {
    NODE_ENV = 'development'
    CI = 'true'
  }

  tools {
    nodejs 'NodeJS 18' // Ensure this matches the Node.js version installed on your Jenkins agent
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

    stage('Run Tests') {
      steps {
        sh 'npm run test'
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
    success {
      echo 'Pipeline completed successfully.'
    }
    failure {
      echo 'Pipeline failed.'
    }
  }
}
