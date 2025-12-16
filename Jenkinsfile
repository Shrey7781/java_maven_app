#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
     remote: 'https://github.com/Shrey7781/jenkins-shared-library.git',
     credentialsId: 'github'
    ]
)

pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    environment {
        IMAGE_NAME = 'shrey7781/demo-app:java-maven-2.0'
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
            steps {
                script {
                   echo 'deploying docker image to EC2...'
                    def dockerCmd="docker run -p 8080:8080 -d ${IMAGE_NAME}
                   sshagent(['ec2-user-key']) {
                       sh "ssh -o StrictHostKeyChecking=no ec2-user@43.205.82.127 ${dockerCmd}"
                       
                   }
                }
            }
        }
    }
}
