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
                sh 'git checkout master'
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
                    withCredentials([usernamePassword(credentialsId: 'git-jenkins', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                        sh '''
                            git config user.email "jch951753@gmail.com"
                            git config user.name "jeong"
                            git add deploy.yaml
                            git commit -m "Update image tag to jeonghyuck/jenkins-test:${BUILD_NUMBER}" || echo "No changes to commit"
                            
                            # 병합 시 내 쪽(Jenkins)이 우선되도록 충돌 자동 해결
                            git fetch origin master
                            git merge -X ours origin/master -m "Merge with origin/master using ours strategy"

                            
                            
                            git push https://${GIT_USER}:${GIT_TOKEN}@github.com/jeong-github/test-git.git
                        '''
                    }
                }
            }
        }
    }
}
