pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/oguzhanaydogan/Azure-Devops-Angular-Real-World-Example-App.git']])
            }
        }
        stage('docker login'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr', passwordVariable: 'password', usernameVariable: 'username')]) {
                
                    sh 'docker login -u ${username} -p ${password} oguzhanaydogan.azurecr.io'
                }
            }
        }
        stage('docker build'){
            steps {
                sh 'docker build -t oguzhanaydogan.azurecr.io/angular .'
            }
        }
        stage('docker push'){
            steps {
                sh 'docker push oguzhanaydogan.azurecr.io/angular'
            }
        }
        stage('az login'){
            steps {
                withCredentials([azureServicePrincipal('azure_service_principal')]){
                sh 'az login --service-principal -u ${AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} --tenant ${AZURE_TENANT_ID}'
                }
                withCredentials([usernamePassword(credentialsId: 'acr', passwordVariable: 'password', usernameVariable: 'username')]) {
                
                    sh 'az webapp config container set --name oguzhanaydogan-app --resource-group rg1 --docker-custom-image-name oguzhanaydogan.azurecr.io/angular:latest --docker-registry-server-url https://oguzhanaydogan.azurecr.io --docker-registry-server-user ${username} --docker-registry-server-password ${password}'
                }
            }
        }
    }
}
