# TODO: This should be more straight-forward to bootstrap, and there should
# be a way to make it relocatable.
import importlib
import sys
sys.modules[__name__] = importlib.import_module("mlir.dialects._ods_common")
