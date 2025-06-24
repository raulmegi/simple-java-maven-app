pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                bat 'C:/apache-maven-3.9.10/bin/mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                bat 'C:/apache-maven-3.9.10/bin/mvn test'
            }
        }

        stage('Deliver') {
            when {
                expression {
                    def commitMessage = bat(
                        script: 'git log -1 --pretty=%B',
                        returnStdout: true
                    ).trim()
                    return !commitMessage.contains("DO_NOT_DELIVER")
                }
            }
            steps {
                bat 'jenkins\\scripts\\deliver.bat'
            }
        }
    }
}

