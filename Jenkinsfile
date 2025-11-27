#!/usr/bin/env groovy
@Library('jenkins-shared-library')_
def gv

pipeline {
    agent any
    tools{
        maven 'maven-3.9'
    }
    stages {
        stage("init"){
            steps{
                script{
                    gv=load "script.groovy"
                }
            }
        }
        stage("build jar") {
            steps {
                script {
                   buildJar()
                }
            }
        }
        stage("build and push image") {
            steps {
                script {
                    buildImage('shrey7781/demo-app:jma-3.0')
                    dockerLogin()
                    dockerPush('shrey7781/demo-app:jma-3.0')
                    }
                }
            }
        
        stage('deploy') {
            steps {
                script {
                    gv.deployApp()
                }
            }
        }}
    }

