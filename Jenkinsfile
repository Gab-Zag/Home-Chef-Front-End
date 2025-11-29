pipeline {
    agent any

    tools {
        nodejs "nodejs"   
        git "Git"           
    }

    environment {
        FLUTTER_HOME = "C:/sdk/flutter"
        ANDROID_HOME = "C:/Users/Gabriel/AppData/Local/Android/Sdk"
        PATH = "${FLUTTER_HOME}/bin;${env.PATH}"
    }

    stages {

        stage('Prepare Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Flutter') {
            steps {
                bat """
                echo ===== FLUTTER VERSION =====
                flutter --version
                git --version
                """
            }
        }

        stage('Install Dependencies') {
            steps {
                bat "flutter pub get"
            }
        }

        stage('Analyze') {
            steps {
                bat "flutter analyze"
            }
        }

        stage('Run Tests') {
            steps {
                bat "flutter test --coverage"
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: "**/test/*.xml"
                }
            }
        }

        stage('Build Web') {
            steps {
                bat "flutter build web --release"
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/web/**', fingerprint: true
                }
            }
        }

        stage('Build APK') {
            steps {
                bat "flutter build apk --release"
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', fingerprint: true
                }
            }
        }
    }
}
