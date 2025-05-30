pipeline {
    agent {
        label 'general'
    }

    triggers {
        githubPush()   // trigger the pipeline upon push event in github
    }

    options {
        timeout(time: 10, unit: 'MINUTES')  // discard the build after 10 minutes of running
        timestamps()  // display timestamp in console outputs
    }

    environment {
        // GIT_COMMIT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        // TIMESTAMP = new Date().format("yyyyMMdd-HHmmss")

        IMAGE_TAG = "v1.0.$BUILD_NUMBER"
        IMAGE_BASE_NAME = "netflix-frontend"

        DOCKER_CREDS = credentials('dockerhub')
        DOCKER_USERNAME = "${DOCKER_CREDS_USR}"  // The _USR suffix added to access the username value
        DOCKER_PASS = "${DOCKER_CREDS_PSW}"      // The _PSW suffix added to access the password value
    }

    stages {
        stage('Docker setup') {
            steps {
                sh '''
                  docker login -u $DOCKER_USERNAME -p $DOCKER_PASS
                '''
            }
        }

        stage('Build & Push') {
            steps {
                sh '''
                  IMAGE_FULL_NAME=$DOCKER_USERNAME/$IMAGE_BASE_NAME:$IMAGE_TAG
                  docker build --push -t $IMAGE_FULL_NAME .

                '''
            }
        }
        stage('Trigger Deploy') {
            steps {
                build job: 'frontend-deploy', wait: false, parameters: [
                string(name: 'SERVICE_NAME', value: "NetflixFrontend"),
                string(name: 'IMAGE_FULL_NAME_PARAM', value: "$DOCKER_USERNAME/$IMAGE_BASE_NAME:$IMAGE_TAG")
                ]
            }
        }
    }
}