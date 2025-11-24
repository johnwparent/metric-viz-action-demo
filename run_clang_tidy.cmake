find_program(
    PYTHON_EXECUTABLE
    NAMES python3 python
    REQUIRED_DOC "Path to the Python interpreter (required to run run-clang-tidy.py)"
)

if(NOT PYTHON_EXECUTABLE)
    message(FATAL_ERROR "Python interpreter not found. Please ensure Python is installed and in your system PATH.")
else()
    message(STATUS "Found Python interpreter: ${PYTHON_EXECUTABLE}")
endif()

# This script is typically installed in the path of the LLVM/Clang distribution.
find_program(
    RUN_CLANG_TIDY_SCRIPT
    NAMES run-clang-tidy run-clang-tidy.py
    REQUIRED_DOC "Path to the run-clang-tidy.py script"
)

if(NOT RUN_CLANG_TIDY_SCRIPT)
    message(FATAL_ERROR "run-clang-tidy script not found. Please ensure you have Clang/LLVM installed and its bin directory is in your system PATH.")
else()
    message(STATUS "Found run-clang-tidy script: ${RUN_CLANG_TIDY_SCRIPT}")
endif()

execute_process(
COMMAND ${PYTHON_EXECUTABLE} 
        ${RUN_CLANG_TIDY_SCRIPT}
        -p ${CTEST_BINARY_DIRECTORY}
        -header-filter=".*"
        -config-file=${CONFIG_FILE}
OUTPUT_FILE "run-clang-tidy-function-metrics.out"
ERROR_FILE "run-clang-tidy-function-metrics.out"
RESULT_VARIABLE result
)

ctest_upload(FILES run-clang-tidy-function-metrics.out
            CAPTURE_CMAKE_ERROR res)