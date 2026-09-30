pipeline {
    agent any

    tools {
        maven 'maven'
    }

    environment {
        AWS_REGION = "us-east-1"
        AWS_ACCOUNT_ID = "250935839460"
        ECR_REPO = "web-calculator"

        IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
    }

    stages {

        stage('SCM') {
            steps {
                git branch: 'main',
                url: 'https://github.com/BhavyaAudisri/web-calculator.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Image Build') {
            steps {
                sh '''
                docker build -t $IMAGE:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin \
                $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

                docker push $IMAGE:${BUILD_NUMBER}
                '''
            }
        }

    }
}
