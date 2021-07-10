# Copyright 2019 The IREE Authors
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

cmake_minimum_required(VERSION 3.13.4)

project(iree_mlir_kit C CXX)

# Some niceties.
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()

# CMake settings.
set(BUILD_SHARED_LIBS ON CACHE BOOL "Shared libs are required")
set(CMAKE_PLATFORM_NO_VERSIONED_SONAME ON CACHE BOOL "Python soname linked libraries are bad")
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON CACHE BOOL "Hide inlines")

# Required LLVM settings.
set(LLVM_ENABLE_PROJECTS mlir CACHE STRING "LLVM projects")
set(LLVM_ENABLE_Z3_SOLVER OFF CACHE BOOL "Disable Z3")
set(LLVM_ENABLE_ZLIB OFF CACHE BOOL "Disable ZLIB")
set(LLVM_TARGETS_TO_BUILD "host" CACHE STRING "Only build for the host")
set(LLVM_INCLUDE_EXAMPLES OFF CACHE BOOL "Disable examples")
# TODO: MLIR is a "tool"
set(LLVM_INCLUDE_TOOLS ON CACHE BOOL "Disable tools")
set(LLVM_INCLUDE_TESTS ON CACHE BOOL "Disable tests")

# Requited MLIR settings.
set(MLIR_ENABLE_BINDINGS_PYTHON ON CACHE BOOL "Enable MLIR python bindings")
set(MLIR_BINDINGS_PYTHON_LOCK_VERSION OFF CACHE BOOL "Disable linking against libpython")

find_package(Python3 COMPONENTS Interpreter Development REQUIRED)

# LLVM configuration.
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/llvm")

#-------------------------------------------------------------------------------
# Installation targets
#-------------------------------------------------------------------------------

add_custom_target(
  install-iree-mlir-kit-mlir-python-deps
  DEPENDS
  install-mlir-headers
  install-MLIRBindingsPythonSources
  install-MLIRBindingsPythonDialects
  install-MLIRPublicAPI
  # Python extensions.
  install-MLIRCoreBindingsPythonExtension
  install-MLIRTransformsBindingsPythonExtension
)
