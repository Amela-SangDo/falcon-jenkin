pipeline {
  agent any
  stages {
    stage('Test'){
      steps {
        sh 'node -v'
        sh 'npm prune'
        sh 'npm install'
      }
    }

    stage('Deploy'){
      steps {
        echo 'Push to Repo'
        // sh './dockerPushToRepo.sh'
        // echo 'ssh to web server and tell it to pull new image'
        // sh 'ssh deploy@xxxxx.xxxxx.com running/xxxxxxx/dockerRun.sh'
      }
    }

    stage('Cleanup'){
      steps {
        echo 'prune and cleanup'
        sh 'npm prune'
        sh 'rm node_modules -rf'

        mail body: 'project build successful',
            from: 'falcon@dev.com',
            subject: 'project build successful',
            to: 'taobietladu@gmail.com'
      }
    }
  }
}
