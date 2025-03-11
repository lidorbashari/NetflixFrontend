// pipelines/build.Jenkinsfile

pipeline {
    agent {
       label 'general'
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Build app container') {
            steps {
                sh '''
                    ls
                    echo hii lidi
                    # build an image
                    docker build -t netflix-front .
                '''
            }
        }
    }
}