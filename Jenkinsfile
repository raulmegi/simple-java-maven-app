pipeline {
    agent any
    stages {
        stage('Build') { 
            steps {
                bat 'C:/apache-maven-3.9.10/bin/mvn -B -DskipTests clean package'
            }
        }
    }
}