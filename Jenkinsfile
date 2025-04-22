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

    stage('Run Tests') {
      steps {
        script {
          try {
            wrap([$class: 'Xvfb', autoDisplayName: true]) {
              sh 'npm test'
            }
          } catch(e) {
            echo 'Running tests in headless mode'
            sh 'npm test -- --headless'
          }
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
      script {
        archiveArtifacts artifacts: 'build/**', fingerprint: true
      }
    }
    failure {
      echo '❌ Pipeline failed.'
    }
    success {
      echo '✅ Pipeline succeeded.'
    }
  }
}