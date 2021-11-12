pipeline {
  agent any
  environment {
    PROJECT_NAME = "JENKIN FALCON"
    EMAIL = "${env.BRANCH_NAME == 'master' ? 'sang.do@amela.vn' : 'taobietladu@gmail.com'}"
  }
  stages {
    stage('Before test stage') {
      steps {
        echo "The build number is ${env.BUILD_NUMBER}"
        echo "Project name: ${env.PROJECT_NAME}"
        echo "Email notification: ${env.EMAIL}"
      }
    }
    stage('Testing Stage') {
      steps {
        echo 'Start Testing'
        sh 'node -v'
        echo 'Install'
      }
    }

    stage('Deploy Stage') {
      parallel {
        stage('Deploy master') {
          when {
            branch 'master'
            environment name: 'IS_PULL_REQUEST', value: 'false'
          }
          steps {
            echo 'Push to Repo'
            sh 'rsync -azP --exclude="node_modules" --exclude=".git" . ubuntu@3.0.98.209:/home/ubuntu/jenkins'
            sh 'ssh ubuntu@3.0.98.209 "cd jenkins && rm -rf .git"'
            sh 'ssh ubuntu@3.0.98.209 "sudo service nginx restart"'
          }
        }

        stage('Deploy develop') {
          when {
            branch 'develop'
            environment name: 'IS_PULL_REQUEST', value: 'false'
          }
          steps {
            echo 'Push to Repo'
            sh 'rsync -azP --exclude="node_modules" --exclude=".git" . ubuntu@3.0.98.209:/home/ubuntu/jenkins'
          }
        }
      }
    }

    stage('Cleanup Stage') {
      steps {
        echo 'prune and cleanup'
        sh 'rm node_modules -rf'
        mail(body: 'project build successful', from: 'falcon@dev.com', subject: "B&D ${env.PROJECT_NAME} successfully!", to: "${env.EMAIL}")
      }
    }
  }
}
