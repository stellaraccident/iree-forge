# Copyright 2021 The IREE Authors
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import importlib
import os

_this_dir = os.path.dirname(__file__)

def load_extension(name):
  return importlib.import_module(f".{name}", __package__)


def preload_dependency(public_name):
  pass


def get_include_dirs():
  return [os.path.join(_this_dir, "include")]


def get_library_dirs():
  return [_this_dir]
