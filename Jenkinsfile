pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Test (Maven container)') {
      steps {
        sh '''
          docker run --rm \
            -v "$PWD":/work \
            -w /work \
            maven:3.9-eclipse-temurin-17 \
            mvn -B clean test
        '''
      }
      post {
        always {
          junit 'target/surefire-reports/*.xml'
        }
      }
    }

    stage('Package (Maven container)') {
      steps {
        sh '''
          docker run --rm \
            -v "$PWD":/work \
            -w /work \
            maven:3.9-eclipse-temurin-17 \
            mvn -B -DskipTests package
        '''
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t devops-demo:${BUILD_NUMBER} .'
      }
    }

    stage('Run Container (demo)') {
      steps {
        sh 'docker run --rm devops-demo:${BUILD_NUMBER}'
      }
    }
  }
}
