pipeline {
  agent any
  stages {
    stage('Testing Stage') {
      steps {
        echo 'Start Testing'
        sh 'node -v'
        sh 'npm prune'
        echo 'Install'
        sh 'npm install'
      }
    }

    stage('Deploy Stage') {
      parallel {
        stage('Deploy master') {
          when {
            branch 'master'
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
        mail(body: 'project build successful', from: 'falcon@dev.com', subject: 'project build successful', to: 'taobietladu@gmail.com')
      }
    }
  }
}
