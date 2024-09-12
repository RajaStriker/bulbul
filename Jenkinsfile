pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT', 
            choices: ['dev', 'prod'], 
            description: 'Choose the environment to deploy to'
        )
    }

    environment {
        GIT_CREDENTIALS = 'github-credentials-id' // Use your GitHub credentials ID here
        PATH = "$PATH:/opt/maven:/bin:/usr/bin:/usr/local/bin"
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

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying to $params.ENVIRONMENT environment..."
                    sh "./deploy.sh $params.ENVIRONMENT"
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

