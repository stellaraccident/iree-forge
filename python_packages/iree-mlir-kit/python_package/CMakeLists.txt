# Copyright 2021 The IREE Authors
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

set(_python_mlir_install_prefix "python_package")
set(_install_library_targets
  MLIRPublicAPI
  MLIRCoreBindingsPythonExtension
  MLIRAllPassesRegistrationBindingsPythonExtension
  MLIRAsyncPassesBindingsPythonExtension
  MLIRSparseTensorPassesBindingsPythonExtension
  MLIRGPUPassesBindingsPythonExtension
  MLIRLinalgPassesBindingsPythonExtension
)

add_custom_target(
  PythonPackage ALL
  DEPENDS
    MLIRBindingsPythonSources
    ${_install_library_targets}
)

################################################################################
# Override some RPATH handling for libraries we are installing
################################################################################

set_target_properties(
  ${_install_library_targets}
  PROPERTIES
    INSTALL_RPATH "\$ORIGIN"  # TOOD: OSX
)

###############################################################################
# Copy sources for all sub projects
################################################################################

install(
  DIRECTORY ${CMAKE_BINARY_DIR}/llvm/python/mlir
  DESTINATION ${_python_mlir_install_prefix}
  COMPONENT PythonSources
  FILES_MATCHING PATTERN "*.py"
)

################################################################################
# Install the _mlir_libs directory
################################################################################

# Python files.
install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/_mlir_libs
  DESTINATION ${_python_mlir_install_prefix}
  COMPONENT PythonSources
  FILES_MATCHING PATTERN "*.py"
)

# C headers.
install(
  DIRECTORY ${CMAKE_SOURCE_DIR}/mlir/include/mlir-c
  DESTINATION ${_python_mlir_install_prefix}/_mlir_libs/include
  COMPONENT PythonSources
  FILES_MATCHING
    PATTERN "*.def"
    PATTERN "*.h"
    PATTERN "*.gen"
    PATTERN "*.inc"
    PATTERN "*.td"
    PATTERN "CMakeFiles" EXCLUDE
    PATTERN "config.h" EXCLUDE
)

# Shared libraries.
install(
  TARGETS ${_install_library_targets}
  COMPONENT PythonBinaries
  RUNTIME DESTINATION ${_python_mlir_install_prefix}/_mlir_libs
  LIBRARY DESTINATION ${_python_mlir_install_prefix}/_mlir_libs
)
