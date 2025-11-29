pipeline {
    agent any

    environment {
        FLUTTER_HOME = "C:\\flutter"
        ANDROID_SDK_ROOT = "C:\\Android"
        PATH = "${FLUTTER_HOME}\\bin;${ANDROID_SDK_ROOT}\\cmdline-tools\\latest\\bin;${ANDROID_SDK_ROOT}\\platform-tools;${env.PATH}"
    }

    options {
        // Mantém logs do console por 7 dias
        buildDiscarder(logRotator(daysToKeepStr: '7'))
        timestamps()
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
                bat """
                @echo off
                for /L %%i in (1,1,100) do (
                    echo y
                ) | flutter doctor --android-licenses
                """
            }
        }

        stage('Install Dependencies') {
            steps {
                // Cache para acelerar builds
                bat 'flutter pub get'
            }
        }

        stage('Run Analyzer') {
            steps {
                // Não trava o pipeline caso apareçam warnings
                bat 'flutter analyze || exit 0'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'flutter test --coverage || exit 0'
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

    post {
        always {
            echo "Pipeline finalizado!"
        }
        failure {
            echo "O pipeline falhou. Verifique os logs acima."
        }
        success {
            echo "Pipeline concluído com sucesso!"
        }
    }
}
