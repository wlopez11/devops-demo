pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Test') {
      steps { sh 'mvn -B clean test' }
      post { always { junit 'target/surefire-reports/*.xml' } }
    }

    stage('Package') {
      steps { sh 'mvn -B -DskipTests package' }
    }

    stage('Docker Build') {
      steps { sh 'docker build -t devops-demo:${BUILD_NUMBER} .' }
    }

    stage('Run Container (demo)') {
      steps { sh 'docker run --rm devops-demo:${BUILD_NUMBER}' }
    }
  }
}
