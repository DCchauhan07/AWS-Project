pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        TF_IN_AUTOMATION   = 'true'
        TERRAFORM_BIN      = '/usr/bin/terraform'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set AWS Credentials') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'aws sts get-caller-identity'
                }
            }
        }

        stage('Debug Environment') {
            steps {
                sh 'whoami'
                sh 'pwd'
                sh 'ls -la'
                sh 'ls -la terraform || true'
                sh '$TERRAFORM_BIN version'
            }
        }

        stage('Terraform Format Check') {
            steps {
                dir('terraform') {
                    sh '$TERRAFORM_BIN fmt -check'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh '$TERRAFORM_BIN init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh '$TERRAFORM_BIN validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh '$TERRAFORM_BIN plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Approve Terraform apply?'
                dir('terraform') {
                    sh '$TERRAFORM_BIN apply -auto-approve tfplan'
                }
            }
        }

        stage('Deploy Static Files') {
            steps {
                sh 'bash scripts/deploy.sh'
            }
        }

        stage('Invalidate CloudFront Cache') {
            steps {
                sh 'bash scripts/invalidate.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
        always {
            cleanWs()
        }
    }
}
