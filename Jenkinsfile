pipeline {
    agent any

    environment {
        // Define environment variables here if needed
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building the project...'
                    // Replace with your actual build commands
                    sh './build.sh'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    // Replace with your actual test commands
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
                    // Replace with your actual deploy commands for dev
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
                    // Replace with your actual deploy commands for prod
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
