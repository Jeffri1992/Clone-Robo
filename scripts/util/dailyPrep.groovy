def getTestcaseFilename(){
    testSuite = "All\n"
    FILES_DIR = env.WORKSPACE + '/Web/TestCases/'
    def TMP_FILENAME = ".testcase_files_list"
    sh "ls ${FILES_DIR} > ${TMP_FILENAME}"
    def filenames = readFile(TMP_FILENAME).split( "\\r?\\n" );
    sh "rm -f ${TMP_FILENAME}"
    for (int i = 0; i < filenames.size(); i++) {
        if (filenames[i] != "PageObjects"){
            testSuite += filenames[i].replace(".robot", "") + '\n'
            echo filenames[i].replace(".robot", "")
        }
    }
    return testSuite
}

return this
