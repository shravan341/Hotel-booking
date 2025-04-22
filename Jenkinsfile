pipeline {
  agent any

  environment {
    NODE_ENV = 'development'
    CI = 'true'
  }

  tools {
    nodejs 'NodeJS 18'
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
        wrap([$class: 'Xvfb']) {
          sh 'npm run test'
        }
      }
    }
    
    agent {
    docker {
        image 'node:18'
        args '-u root -e DISPLAY=:99'
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
      echo '✅ Pipeline completed successfully.'
    }
    failure {
      echo '❌ Pipeline failed.'
    }
  }
}
