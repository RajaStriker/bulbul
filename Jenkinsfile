pipeline {
    agent any

    environment {
        GIT_CREDENTIALS = 'github-credentials-id' // Use your GitHub credentials ID here
        PATH = "$PATH:/opt/maven:/bin:/usr/bin:usr/local/bin"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo 'Checking out repository...'
                    checkout([$class: 'GitSCM', 
                              branches: [[name: '*/main']],  // Adjust branch as necessary
                              userRemoteConfigs: [[
                                  url: 'https://github.com/RajaStriker/bulbul.git',
                                  credentialsId: GIT_CREDENTIALS
                              ]]
                    ])
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    echo 'Building the project...'
                    sh './build.sh'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    sh './test.sh'
                }
            }
        }

        stage('Deploy to Dev') {
            when {
                expression { return env.BRANCH_NAME == 'dev' }
            }
            steps {
                script {
                    echo 'Deploying to the development environment...'
                    sh './deploy.sh dev'
                }
            }
        }

        stage('Approval') {
            when {
                expression { return env.BRANCH_NAME == 'main' }
            }
            steps {
                script {
                    echo 'Waiting for manual approval to deploy to production...'
                    input message: 'Approve deployment to production?', ok: 'Deploy'
                }
            }
        }

        stage('Deploy to Prod') {
            when {
                expression { return env.BRANCH_NAME == 'main' }
            }
            steps {
                script {
                    echo 'Deploying to the production environment...'
                    sh './deploy.sh prod'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

