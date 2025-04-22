pipeline {
  agent {
    docker {
      image 'node:18'
      args '-u root -e DISPLAY=:99'
    }
  }

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
        // Either use Xvfb (if installed on host) or run in headless mode
        script {
          try {
            wrap([$class: 'Xvfb', autoDisplayName: true]) {
              sh 'npm test'
            }
          } catch (e) {
            echo 'Xvfb not available, running tests in headless mode'
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