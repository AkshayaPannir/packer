pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/AkshayaPannir/packer.git'
            }
        }

        stage('Packer') {
            steps {
                
                sh 'packer validate location.json'
                sh 'packer build location.json'
            }
        }

        stage('Deploy') {
            steps {
                sh 'chmod +x setup.sh'
                sh './setup.sh'
            }
        }
    }
}
