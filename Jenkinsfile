pipeline {
    agent any

    environment {
        FLUTTER_HOME = "C:/flutter"
        ANDROID_HOME = "C:/Users/Gabriel/AppData/Local/Android/Sdk"
        PATH = "${FLUTTER_HOME}/bin;${ANDROID_HOME}/platform-tools;${ANDROID_HOME}/tools;${env.PATH}"
    }

    stages {

        stage('Install Flutter') {
            steps {
                bat """
                if not exist C:\\flutter (
                    git clone https://github.com/flutter/flutter.git C:\\flutter
                )
                flutter --version
                """
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Flutter Dependencies') {
            steps {
                bat "flutter pub get"
            }
        }

        stage('Static Analysis') {
            steps {
                bat "flutter analyze"
            }
        }

        stage('Unit Tests') {
            steps {
                bat "flutter test --coverage"
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: "build/**/test/*.xml"
                    archiveArtifacts artifacts: "coverage/**", fingerprint: true
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
