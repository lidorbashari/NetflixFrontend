// pipelines/build.Jenkinsfile

pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage('Build app container') {
            steps {
                sh '''

                    # build an imagek
                    docker build -t netflix-front .
                '''
            }
        }
    }
}