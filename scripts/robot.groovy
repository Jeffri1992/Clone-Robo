def inputParameter
def webhook_id_failed = '3e8cc3ef-16ae-4d90-aad7-9b86faa1cc37@d9c709b5-56b4-4388-9d0e-36c4e84dd197'
def teams_id_failed = 'cdd837dd401c40e9ac8bb5ea769cde42/3bd35c06-101b-4c5d-b3f1-9d40ef785677'
def webhook_id_success = '3e8cc3ef-16ae-4d90-aad7-9b86faa1cc37@d9c709b5-56b4-4388-9d0e-36c4e84dd197'
def teams_id_success = '3a848f0d41244bbba74797a62e44499b/3bd35c06-101b-4c5d-b3f1-9d40ef785677'
def artifact_url = 'https://deploykid.kompas.id/job/sdet_playground/job/robo-docker/' + env.BUILD_NUMBER + '/artifact/result/robot/report.html'
def image_url_failed = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5lQVwW-0zImwfJcoWoBE4lv4rS4DIg0RyqQ&usqp=CAU'
def image_url_success = 'https://www.freeiconspng.com/thumbs/success-icon/success-icon-10.png'

pipeline {
    agent { label 'builder3' }

    parameters {
        string name: 'BRANCH', defaultValue: 'master', description: '**(mandatory)** Define branch name will be fetching the new code'
        string name: 'TESTCASE_PATH', defaultValue: 'Login.robot', description: '**(mandatory)** Define which test case will be run'
        booleanParam name: 'needUpdateDocker', defaultValue: false, description: 'check if any updated image'
    }

    options {
        skipDefaultCheckout()
    }

    stages {
        stage('Clean Up Code'){
            steps{
                sh 'ls -al && rm -rf ../robo-docker/*'
            }
        }

         stage('SCM'){
            steps{
                script{
                    println "Pulling branch. . . => ${params.BRANCH}"
                    println "Test case name. . . => ${params.TESTCASE_PATH}"
                    checkout changelog: false, poll: false,
                    scm: [
                        $class: 'GitSCM',
                        branches: [[name: params.BRANCH]],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [
                            [$class: 'CleanBeforeCheckout'],
                            [$class: 'CheckoutOption', timeout: 10],
                            [$class: 'CloneOption', noTags: true, reference: '', shallow: true, timeout: 10]
                        ],
                        submoduleCfg: [],
                        userRemoteConfigs: [[
                            credentialsId: 'github-aguscuk',
                            url: 'https://github.com/pt-kompas-media-nusantara/kompas-automation.git',
                            refspec: '+refs/heads/'+params.BRANCH+':refs/remotes/origin/'+params.BRANCH
                        ]]
                    ]
                }
            }
        }

        stage('Build Docker'){
            steps{
                script{
                    dockerPrep = load 'scripts/util/dockerPrep.groovy'

                    // Remove image and container and build from scratch
                    dockerPrep.dockerBuild(params.needUpdateDocker)
                }
            }
        }

        stage('Update Docker Files'){
            steps{
                sh 'docker exec robotframework rm -rf /home/robot/test_script_dir/Web'
                sh 'docker cp ../robo-docker/Web robotframework:/home/robot/test_script_dir'
            }
        }


        stage('Run the static test'){
            steps{
                script{
                    sh "docker exec robotframework robocop /home/robot"
                }
            }
        }

        stage('Run the test'){
            steps{
                script{
                    	if (!params.TESTCASE_PATH.contains("/home/robot/test_script_dir/Web/TestCases")) {
                            inputParameter = '/home/robot/test_script_dir/Web/TestCases/' + params.TESTCASE_PATH
                            tag_name = params.TESTCASE_PATH
                            message = 'File'
                    	}else {
                            inputParameter = params.TESTCASE_PATH
                            if(inputParameter.contains('-i')){
                                tag_name = inputParameter.split(' ')[2]
                                if(tag_name.contains('Squad-')){
                                    message = ''
                                }
                                else{
                                    message = 'Service'
                                }
                            }
                            else{
                                if(inputParameter.endsWith('.robot')==true){
                                    tag_name = inputParameter.split('/')[6]
                                    message = 'Test Suite'
                                }
                                else{
                                    tag_name = ''
                                    message  = 'All'
                                }
                            }
                        }
                    sh 'docker exec -u robot -w /home/robot robotframework robot ' + inputParameter
                }
            }
        }
    }
    post {
        always {
            // Copy result from docker and save as artifact
            sh 'mkdir result && docker cp robotframework:/home/robot/ result/'
            archiveArtifacts artifacts: 'result/**', fingerprint: true
        }
		success {
            script{
                notif = load 'scripts/util/webhook.groovy'
                notif.successNotification(webhook_id_success, teams_id_success, artifact_url, image_url_success, tag_name, message)
            }
        }
        failure {
            script{
                notif = load 'scripts/util/webhook.groovy'
                notif.failedNotification(webhook_id_failed, teams_id_failed, artifact_url, image_url_failed, tag_name, message)
            }
        }
    }
}
