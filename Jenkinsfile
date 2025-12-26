#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
    [$class: 'GitSCMSource',
     remote: 'https://github.com/Shrey7781/jenkins-shared-library.git',
     credentialsId: 'github'
    ]
)

pipeline {
    agent any
    tools {
        maven 'maven-3.9'
    }
    environment {
        DOCKER_REPO_SERVER = '699966192901.dkr.ecr.ap-south-1.amazonaws.com'
        IMAGE_NAME = 'java-maven-3.0'
        DOCKER_REPO = "/java-maven-app"
    }
    stages {
        stage('build app') {
            steps {
               script {
                  echo 'building application jar...'
                  buildJar()
               }
            }
        }
        
        stage('build image') {
            steps {
                script {
                    echo "building docker image..."
                    withCredentials([usernamePassword(
                        credentialsId: 'ecr-credentials',
                        usernameVariable: 'USER',
                        passwordVariable: 'PASS'
                    )]) {
                        sh """
                        docker build -t ${DOCKER_REPO}:${IMAGE_NAME} .
                        echo \$PASS | docker login -u \$USER --password-stdin ${DOCKER_REPO_SERVER}
                        docker push ${DOCKER_REPO}:${IMAGE_NAME}
                        """
                    }
                }
            }
        }

        stage('deploy') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins-aws-access-key-id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
                AWS_DEFAULT_REGION = 'ap-south-1' 
                APP_NAME = 'java-maven-app'
            }
            steps {
                script {
                    
                    sh "export IMAGE_NAME=${DOCKER_REPO}:${IMAGE_NAME} && envsubst < kubernetes/deployment.yaml | kubectl apply -f -"
                    sh "envsubst < kubernetes/service.yaml | kubectl apply -f -"
                }
            }
        }
    }
}