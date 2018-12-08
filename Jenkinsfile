pipeline {
  agent {
    label "jenkins-nodejs"
  }
  environment {
    ORG = 'gbrivate'
    APP_NAME = 'ninja-belt-ng'
    CHARTMUSEUM_CREDS = credentials('jenkins-x-chartmuseum')
  }
  stages {
    stage('CI Build and push snapshot') {
      when {
        branch 'PR-*'
      }
      environment {
        PREVIEW_VERSION = "0.0.0-SNAPSHOT-$BRANCH_NAME-$BUILD_NUMBER"
        PREVIEW_NAMESPACE = "$APP_NAME-$BRANCH_NAME".toLowerCase()
        HELM_RELEASE = "$PREVIEW_NAMESPACE".toLowerCase()
      }
      steps {
        container('nodejs') {
          sh "npm install"
          sh "CI=true DISPLAY=:99 npm test"
          sh "export VERSION=$PREVIEW_VERSION && skaffold build -f skaffold.yaml"
          sh "jx step post build --image $DOCKER_REGISTRY/$ORG/$APP_NAME:$PREVIEW_VERSION"
          dir('./charts/preview') {
            sh "make preview"
            sh "jx preview --app $APP_NAME --dir ../.."
          }
        }
      }
    }
    stage('Build dev') {
      when {
        branch 'development'
      }
      steps {
        container('nodejs') {

          // ensure we're not on a detached head
          sh "git checkout development"
          sh "git config --global credential.helper store"
          sh "jx step git credentials"

          // so we can retrieve the version in later steps
          sh "echo \$(jx-release-version) > VERSION"
          sh "jx step tag --version \$(cat VERSION)"
          sh "npm install"
          sh "npm run build:dev"

          sh "CI=true DISPLAY=:99 npm test"
          sh "export VERSION=`cat VERSION` && skaffold build -f skaffold.yaml"
          sh "jx step post build --image $DOCKER_REGISTRY/$ORG/$APP_NAME:\$(cat VERSION)"
        }
      }
    }
    stage('Build Release') {
          when {
            branch 'master'
          }
          steps {
            container('nodejs') {

              // ensure we're not on a detached head
              sh "git checkout staging"
              sh "git config --global credential.helper store"
              sh "jx step git credentials"

              // so we can retrieve the version in later steps
              sh "echo \$(jx-release-version) > VERSION"
              sh "jx step tag --version \$(cat VERSION)"
              sh "npm install"
              sh "npm run build:dev"
              sh "npm run build:stag"
              sh "npm run build:prod"

              sh "CI=true DISPLAY=:99 npm test"
              sh "export VERSION=`cat VERSION` && skaffold build -f skaffold.yaml"
              sh "jx step post build --image $DOCKER_REGISTRY/$ORG/$APP_NAME:\$(cat VERSION)"
            }
          }
        }
    stage('Promote to Environment DEV') {
      when {
        branch 'development'
      }
      steps {
        container('nodejs') {
          dir('./charts/ninja-belt-ng') {
            sh "jx step changelog --version v\$(cat ../../VERSION)"

            // release the helm chart
            sh "jx step helm release"

                      // promote through all 'Auto' promotion Environments
            sh "jx promote -b --env development --timeout 1h --version \$(cat ../../VERSION)"
          }
        }
      }
    }
        stage('Promote to Environment PROD') {
              when {
                branch 'master'
              }
              steps {
                container('nodejs') {
                  dir('./charts/ninja-belt-ng') {
                    sh "jx step changelog --version v\$(cat ../../VERSION)"

                    // release the helm chart
                    sh "jx step helm release"

                    // promote through all 'Auto' promotion Environments
                    //sh "jx promote -b  -env production --timeout 1h --version \$(cat ../../VERSION)"
                    sh "jx promote -b --all-auto --timeout 1h --version \$(cat ../../VERSION)"
                  }
                }
              }
            }
  }
  post {
        always {
          cleanWs()
        }
  }
}
