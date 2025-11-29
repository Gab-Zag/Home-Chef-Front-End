pipeline {
    agent any

    environment {
        FLUTTER_HOME = "C:/sdk/flutter"
        ANDROID_HOME = "C:/Users/Gabriel/AppData/Local/Android/Sdk"
        PATH = "${FLUTTER_HOME}/bin;${ANDROID_HOME}/platform-tools;${ANDROID_HOME}/tools;${env.PATH}"
    }

    stages {

        stage('Check Flutter') {
            steps {
                bat """
                echo Verificando Flutter...
                C:\\sdk\\flutter\\bin\\flutter --version
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
                C:\\sdk\\flutter\\bin\\flutter pub get
                """
            }
        }

        stage('Static Analysis') {
            steps {
                bat """
                C:\\sdk\\flutter\\bin\\flutter analyze
                """
            }
        }

        stage('Unit Tests') {
            steps {
                bat """
                C:\\sdk\\flutter\\bin\\flutter test --coverage
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
                C:\\sdk\\flutter\\bin\\flutter build web --release
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
                C:\\sdk\\flutter\\bin\\flutter build apk --release
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
