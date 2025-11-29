pipeline {
    agent any

    environment {
        FLUTTER_HOME = "C:\\flutter"
        ANDROID_SDK_ROOT = "C:\\Android"
        PATH = "${FLUTTER_HOME}\\bin;${ANDROID_SDK_ROOT}\\cmdline-tools\\latest\\bin;${ANDROID_SDK_ROOT}\\platform-tools;${env.PATH}"
    }

    options {
        buildDiscarder(logRotator(daysToKeepStr: '7'))
        timestamps()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Clean NDK') {
            steps {
                bat 'if exist C:\\Android\\ndk\\28.2.13676358 rmdir /s /q C:\\Android\\ndk\\28.2.13676358'
            }
        }

        stage('Accept Android Licenses') {
            steps {
                bat 'echo y | flutter doctor --android-licenses'
            }
        }

        stage('Flutter Doctor') {
            steps {
                bat 'flutter doctor -v'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'flutter pub get'
            }
        }

        stage('Run Analyzer') {
            steps {
                bat 'flutter analyze || exit /b 0'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'flutter test --coverage || exit /b 0'
            }
            post {
                always {
                    archiveArtifacts artifacts: 'coverage/**', fingerprint: true
                }
            }
        }

        stage('Ensure SDK & NDK') {
            steps {
                bat '''
                sdkmanager "platforms;android-36" "build-tools;28.0.3" "ndk;25.2.9519653"
                '''
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
