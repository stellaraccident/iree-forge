# Copyright 2021 The IREE Authors
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
include(AddMLIR)

################################################################################
# Mondo exports library
################################################################################

add_mlir_c_api_export_library(
  IREEMLIRKitPublicAPI
  SHARED
  MLIR_CAPI_GROUPS
    CORE
    MLIRHLO
)

################################################################################
# Package setup
################################################################################

set(_python_mlir_install_prefix "python_package")
set(_install_library_targets
  # Mondo API library.
  IREEMLIRKitPublicAPI

  # MLIR
  MLIRAllPassesRegistrationBindingsPythonExtension
  MLIRAsyncPassesBindingsPythonExtension
  MLIRConversionsBindingsPythonExtension
  MLIRCoreBindingsPythonExtension
  MLIRGPUPassesBindingsPythonExtension
  MLIRLinalgPassesBindingsPythonExtension
  MLIRSparseTensorPassesBindingsPythonExtension
  MLIRTransformsBindingsPythonExtension

  # mlir-hlo
  MLIRHLOCoreBindingsPythonExtension
)

add_custom_target(
  PythonPackage ALL
  DEPENDS
    MLIRBindingsPythonSources
    MLIRHLOBindingsPythonMhloOps
    ${_install_library_targets}
)

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

install(
  DIRECTORY ${CMAKE_BINARY_DIR}/llvm/python/mlir_hlo
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
