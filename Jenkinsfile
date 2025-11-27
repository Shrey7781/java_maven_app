#!/usr/bin/env groovy

pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                script {
                    echo "testing the application..."
                    echo "Executing pipeline for branch $BRANCH_NAME"
                    echo "Testing the integration"
                }
            }
        }
        stage('build') {
            when{
                expression{
                    BRANCH_NAME == "main"
                }
            }
            steps {
                script {
                    echo "building the application..."
                }
            }
        }
        stage('deploy') {
            when{
                expression{
                    BRANCH_NAME == "main"
                }
            }
            steps {
                script {
                    echo "Deploying the application..."
                }
            }
        }
    }
}
