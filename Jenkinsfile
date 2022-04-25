pipeline {
    agent none 
    environment {
        registry = "linhbngo/go_server"
        docker_user = "linhbngo"
        docker_app = "go_server"
        GOCACHE = "/tmp"
    }
    stages {
        stage ('Deploy') {
            agent {
                node {
                    label 'deploy'
                }
            }
            steps {
                sshagent(credentials: ['cloudlab']) {
                    sh 'scp -r -v -o StrictHostKeyChecking=no *.yml lngo@155.98.37.91:~/'
                    sh 'ssh -o StrictHostKeyChecking=no lngo@155.98.37.91 kubectl apply -f /users/lngo/redis.yaml -n jenkins'
                    sh 'ssh -o StrictHostKeyChecking=no lngo@155.98.37.91 kubectl apply -f /users/lngo/redis-service.yml -n jenkins'                                        
                }
            }
        }
    }
}
