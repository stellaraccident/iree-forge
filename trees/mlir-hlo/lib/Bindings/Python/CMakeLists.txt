include(AddMLIRPython)
include(MLIRDetectPythonEnv)

mlir_detect_pybind11_install()
find_package(pybind11 2.6 CONFIG REQUIRED)
message(STATUS "Found pybind11 v${pybind11_VERSION}: ${pybind11_INCLUDE_DIR}")
message(STATUS "Python prefix = '${PYTHON_MODULE_PREFIX}', "
               "suffix = '${PYTHON_MODULE_SUFFIX}', "
               "extension = '${PYTHON_MODULE_EXTENSION}")

add_mlir_python_extension(MLIRHLOCoreBindingsPythonExtension _mlirHlo
  INSTALL_DIR
    python
  SOURCES
    CoreModule.cpp
  LINK_LIBS
    MLIRPublicAPI
    MLIRHLOPublicAPI
)
