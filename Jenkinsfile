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
            steps {
                script {
                   echo 'deploying docker image to EC2...'

                    def shellCmd= "bash ./server-cmds.sh ${IMAGE_NAME}"

                   sshagent(['ec2-user-key']) {
                        sh "scp server-cmds.sh ec2-user@43.205.82.127:/home/ec2-user"
                       sh "scp docker-compose.yaml ec2-user@43.205.82.127:/home/ec2-user"
                       sh "ssh -o StrictHostKeyChecking=no ec2-user@43.205.82.127 ${shellCmd}"
                       
                   }
                }
            }
        }
    }
}
