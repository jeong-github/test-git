pipeline {
    agent any

    environment {
        // 초기 이미지 태그 (필요 시 기본값 설정)
        IMAGE_TAG = 'initial'
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Update deploy.yaml') {
            steps {
                script {
                    // 가장 최근 Docker Hub 이미지 태그를 가져오는 부분 (예시: API 없이 Jenkins 빌드 번호 사용)
                    IMAGE_TAG = env.BUILD_NUMBER
                    echo "Image Tag: ${IMAGE_TAG}"

                    // deploy.yaml 파일의 image 부분을 sed로 치환
                    sh """
                        sed -i 's|image: .*|image: jeonghyuck/jenkins-test:${IMAGE_TAG}|' deploy.yaml
                    """
                }
            }
        }

        stage('Commit and Push') {
            steps {
                script {
                    sshagent(credentials: ['jenkins-ssh-private']) {
                        sh '''
                            git config user.email "user email 입력"
                            git config user.name "user name 입력"
                            git add deploy.yaml
                            git commit -m "Update image tag to jeonghyuck/jenkins-test:${IMAGE_TAG}"
                            git push git@github.com:jeong-github/test-app.git
                            //git push https://${GIT_CREDENTIALS_ID}@github.com/{user name 입력}/Manifest.git HEAD:main
                            //git push https://github.com/jeong-github/test-app.git
                        '''
                    }
                }
            }
        }
    }
}
