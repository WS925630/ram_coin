pipeline {
    agent none 
    environment {
        registry = "linhbngo/go_server"
        docker_registry = "130.127.132.246:5000"
        docker_app = "go_server"
        GOCACHE = "/tmp"
    }
    stages {
        stage('Publish') {
            agent {
                kubernetes {
                    inheritFrom 'agent-template'
                }
            }
            steps{
                container('docker') {
                    sh 'cd webui; ls -l'
                    sh 'cd webui; docker build -t $DOCKER_REGISTRY/webui:$BUILD_NUMBER .'
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
                    sh "sed -i 's/DOCKER_REGISTRY/${docker_registry}/g' webui.yaml"
                    sh "sed -i 's/BUILD_NUMBER/${BUILD_NUMBER}/g' webui.yaml"
                    sh 'scp -r -v -o StrictHostKeyChecking=no *.yml lngo@130.127.132.246:~/'
                    sh 'ssh -o StrictHostKeyChecking=no lngo@130.127.132.246 kubectl apply -f /users/lngo/webui.yaml -n jenkins'
                    sh 'ssh -o StrictHostKeyChecking=no lngo@130.127.132.246 kubectl apply -f /users/lngo/webui-service.yaml -n jenkins'                                        
                }
            }
        }
    }
}
