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
        IMAGE_NAME = 'shrey7781/demo-app:java-maven-3.0'
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
                   echo 'building docker image...'
                   buildImage(env.IMAGE_NAME)
                   dockerLogin()
                   dockerPush(env.IMAGE_NAME)
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
            sh 'envsubst < kubernetes/deployment.yaml | kubectl apply -f '
            sh 'envsubst < kubernetes/service.yaml | kubectl apply -f '
        }
    }
}
     }
}
