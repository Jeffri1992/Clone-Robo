def inputParameter
def testSuite

node {
    try {
        dailyPrep = load 'scripts/util/dailyPrep.groovy'
        testSuite = dailyPrep.getTestcaseFilename()
    } catch(Exception ex) {
        testSuite = ['All']
    }
}

pipeline {
    agent { label 'builder3' }

    parameters {
        string name: 'BRANCH', defaultValue: 'master', description: '**(mandatory)** Define branch name will be fetching the new code'
        choice choices: testSuite, description: '**(mandatory)** Choose your Test Suite', name: 'TESTSUITE'
        choice choices: ['All', 'Squad-A', 'Squad-B', 'Squad-C', 'Squad-D', 'Squad-E', 'Squad-F', 'Squad-T'], description: '**(Optional)** Choose your Squad', name: 'SQUAD'
    }

    stages {
        stage('SCM'){
            steps{
                script{
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

        stage('Run the test'){
            steps{
                script{
                    if (params.TESTSUITE == "All" && params.SQUAD == "All") {
                        inputParameter = '/home/robot/test_script_dir/Web/TestCases/'
                    } else if (params.TESTSUITE != "All" && params.SQUAD == "All"){
                        inputParameter = '/home/robot/test_script_dir/Web/TestCases/' + params.TESTSUITE + '.robot'
                    } else {
                        inputParameter = ' -i ' + params.SQUAD + ' /home/robot/test_script_dir/Web/TestCases/'
                    }
                }
                build job: 'robo-docker',
                    parameters: [
                        string(name: 'BRANCH', value: params.BRANCH),
                        string(name: 'TESTCASE_PATH', value: inputParameter)
                ]
            }
        }
    }
}
