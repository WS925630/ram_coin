pipeline {
    agent none 
    stages {
        stage('Publish') {
            agent {
                kubernetes {
                    inheritFrom 'agent-template'
                }
            }
            steps{
                container('docker') {
                    sh 'echo $DOCKER_TOKEN | docker login --username $DOCKER_USER --password-stdin'
                    sh 'cd webui
                    sh 'docker build -t $DOCKER_REGISTRY/webui:$BUILD_NUMBER .'
                    sh 'docker push $DOCKER_REGISTRY/webui:$BUILD_NUMBER'
                }
            }
        }
        stage ('Deploy') {
            agent {
                node {
                    label 'deploy'
                }
            }
            steps {
                sshagent(credentials: ['cloudlab']) {
                    sh "sed -i 's/DOCKER_USER/${docker_user}/g' webui.yaml"
                    sh "sed -i 's/DOCKER_APP/${docker_app}/g' webui.yaml"
                    sh "sed -i 's/BUILD_NUMBER/${BUILD_NUMBER}/g' deployment.yaml"
                    sh 'scp -r -v -o StrictHostKeyChecking=no *.yml lngo@155.98.37.91:~/'
                    sh 'ssh -o StrictHostKeyChecking=no lngo@155.98.37.91 kubectl apply -f /users/lngo/webui.yaml -n jenkins'
                    sh 'ssh -o StrictHostKeyChecking=no lngo@155.98.37.91 kubectl apply -f /users/lngo/webui-service.yaml -n jenkins'                                        
                }
            }
        }
    }
}
