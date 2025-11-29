pipeline {
    agent any

    stages {

        stage('Install Flutter') {
            steps {
                powershell '''
                if (!(Test-Path "C:/flutter")) {
                    git clone https://github.com/flutter/flutter.git C:/flutter
                }

                $env:PATH += ";C:/flutter/bin"
                flutter --version
                '''
            }
        }

        stage('Build Flutter') {
            steps {
                powershell '''
                $env:PATH += ";C:/flutter/bin"

                flutter pub get
                flutter build apk
                '''
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Flutter Dependencies') {
            steps {
                powershell '''
                $env:PATH += ";C:/flutter/bin"
                flutter pub get
                '''
            }
        }

        stage('Static Analysis') {
            steps {
                echo "Running flutter analyze..."
                powershell '''
                $env:PATH += ";C:/flutter/bin"
                flutter analyze
                '''
            }
        }

        stage('Unit Tests') {
            steps {
                echo "Running unit tests..."
                powershell '''
                $env:PATH += ";C:/flutter/bin"
                flutter test --coverage
                '''
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: "build/**/test/*.xml"
                    archiveArtifacts artifacts: "coverage/**", fingerprint: true
                }
            }
        }

        stage('Integration Tests') {
            when { branch "main" }
            steps {
                echo "Running integration tests..."
                powershell '''
                $env:PATH += ";C:/flutter/bin"
                flutter test integration_test
                '''
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: "build/**/integration_test/*.xml"
                }
            }
        }

        stage('Build Android APK') {
            when { branch "main" }
            steps {
                echo "Building release APK..."
                powershell '''
                $env:PATH += ";C:/flutter/bin"
                flutter build apk --release
                '''
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', fingerprint: true
                }
            }
        }

        stage('Build Web') {
            when { branch "main" }
            steps {
                echo "Building Flutter Web..."
                powershell '''
                $env:PATH += ";C:/flutter/bin"
                flutter build web
                '''
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/web/**', fingerprint: true
                }
            }
        }

    }
}
