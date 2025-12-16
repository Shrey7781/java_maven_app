#!/usr/bin/env groovy

pipeline {
    agent any

    tools {
        maven 'maven-3.9'
    }

    stages {

        stage('read version') {
            steps {
                script {
                    echo 'reading app version from pom.xml...'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "${version}-${BUILD_NUMBER}"
                    echo "Docker image tag will be: ${env.IMAGE_NAME}"
                }
            }
        }

        stage('build app') {
            steps {
                echo "building the application..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('build & push image') {
            steps {
                echo "building and pushing docker image..."
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-repo',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh """
                    docker build -t shrey7781/demo-app:${IMAGE_NAME} .
                    echo \$PASS | docker login -u \$USER --password-stdin
                    docker push shrey7781/demo-app:${IMAGE_NAME}
                    """
                }
            }
        }

        stage('deploy') {
            steps {
                echo 'deploying docker image to EC2...'
                // your deploy logic here
            }
        }
    }
}
