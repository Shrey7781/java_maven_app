#!/usr/bin/env groovy

pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                script {
                    echo "Building the application..."
                }
            }
        }
        stage('test') {
            steps {
                script {
                    echo "Testing the application..."
                }
            }
        }
       stage('deploy') {
    environment {
        AWS_ACCESS_KEY_ID = credentials('jenkins-aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
        AWS_DEFAULT_REGION = 'ap-south-1' // Always specify the region
    }
    steps {
        script {
            echo "Logging into EKS and Deploying..."
            // 1. Generate the kubeconfig so kubectl knows WHERE the cluster is
            sh 'aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name demo-cluster'
            
            // 2. Run the deployment
            sh 'kubectl create deployment nginx-deployment --image=nginx'
        }
    }
}
    }
}
