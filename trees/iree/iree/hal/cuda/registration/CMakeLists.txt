################################################################################
# Autogenerated by build_tools/bazel_to_cmake/bazel_to_cmake.py from           #
# iree/hal/cuda/registration/BUILD                                             #
#                                                                              #
# Use iree_cmake_extra_content from iree/build_defs.oss.bzl to add arbitrary   #
# CMake-only content.                                                          #
#                                                                              #
# To disable autogeneration for this file entirely, delete this header.        #
################################################################################

iree_add_all_subdirs()

if(${IREE_HAL_DRIVER_CUDA})

iree_cc_library(
  NAME
    registration
  HDRS
    "driver_module.h"
  SRCS
    "driver_module.c"
  DEPS
    iree::base
    iree::base::cc
    iree::base::core_headers
    iree::base::tracing
    iree::hal
    iree::hal::cuda
  DEFINES
    "IREE_HAL_HAVE_CUDA_DRIVER_MODULE=1"
  PUBLIC
)

endif()

### BAZEL_TO_CMAKE_PRESERVES_ALL_CONTENT_BELOW_THIS_LINE ###
