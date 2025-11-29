pipeline {
    agent any

    environment {
        FLUTTER = "C:/sdk/flutter/bin/flutter"
        ANDROID_HOME = "C:/Users/Gabriel/AppData/Local/Android/Sdk"
    }

    stages {

        stage('Check Flutter') {
            steps {
                bat """
                echo Verificando Flutter...
                "${FLUTTER}" --version
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
                bat """
                "${FLUTTER}" pub get
                """
            }
        }

        stage('Static Analysis') {
            steps {
                bat """
                "${FLUTTER}" analyze
                """
            }
        }

        stage('Unit Tests') {
            steps {
                bat """
                "${FLUTTER}" test --coverage
                """
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
                bat """
                "${FLUTTER}" build web --release
                """
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/web/**', fingerprint: true
                }
            }
        }

        stage('Build APK') {
            steps {
                bat """
                "${FLUTTER}" build apk --release
                """
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', fingerprint: true
                }
            }
        }
    }
}
