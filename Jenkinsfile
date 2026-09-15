pipeline {
    agent any

    environment {
        TF_DIR = 'terraform'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Format Check') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform fmt -check -recursive'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }

        stage('Manual Approval') {
            steps {
                input message: 'Terraform plan is ready. Do you want to apply the infrastructure?', 
                      ok: 'Apply Infrastructure'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        always {
            echo 'Terraform pipeline execution completed.'
        }

        success {
            echo 'Terraform infrastructure deployment completed successfully.'
        }

        failure {
            echo 'Terraform pipeline failed. Check the stage logs.'
        }
    }
}