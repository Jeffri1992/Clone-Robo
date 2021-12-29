#!/usr/bin/env groovy

def dockerBuild(boolean rebuild) {
    sh '''
	if [ "$(docker ps -q -f name=robotframework)" ]; then
		# cleanup
		docker container rm -f robotframework
	fi
    '''
    if (rebuild){
    	sh 'docker rmi -f damarre/robodocker:update_01'
    }

    // run your container
    // default for web only. Please change to dynamics profile
    sh 'docker run -d --name robotframework -p 6080:6080 -v Web:/home/robot/test_script_dir damarre/robodocker:update_01'

}

return this
