pipeline {
    agent any

    environment {
        // Se estiver usando Generic Tool Installer:
        FLUTTER_HOME = tool name: 'flutter'

        // Se o Flutter estiver instalado manualmente:
        // FLUTTER_HOME = "C:\\flutter"

        PATH = "${FLUTTER_HOME}\\bin;${env.PATH}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Flutter Doctor') {
            steps {
                bat 'flutter doctor -v'
            }
        }

        stage('Accept Android Licenses') {
            steps {
                // Gera 100 "Y" e aceita todas as licenças
                bat '(for /l %%i in (1,1,100) do @echo y) | flutter doctor --android-licenses'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'flutter pub get'
            }
        }

        stage('Run Analyzer') {
            steps {
                bat 'flutter analyze'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'flutter test --coverage'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'coverage/**', fingerprint: true
                }
            }
        }

        stage('Build APK') {
            steps {
                bat 'flutter build apk --release'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build\\app\\outputs\\flutter-apk\\app-release.apk', fingerprint: true
                }
            }
        }

        stage('Build AppBundle') {
            steps {
                bat 'flutter build appbundle --release'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build\\app\\outputs\\bundle\\release\\app-release.aab', fingerprint: true
                }
            }
        }

    }
}
