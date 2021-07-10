# IREE MLIR Kit Python Package

Produces a python source and wheel distribution which contains python modules
for all MLIR dialects and tools useful for compiling and execution via IREE.

Note that this is a WIP. Specifically, it uses configuration and linking
modes not yet upstream in LLVM, and it squats on the global namespace too
much. In the fullness of time, it should export a hermetic namespace like
`iree.mlir`, `iree.mlir_hlo`, etc, in order to not preclude others from
producing their own collections.

This should work on Linux, MacOS and Windows but has only been tested in this
form on Linux so far.

## Structure

The produced package bundles all libraries into one `_mlir_libs` python
package directory, with all of the C++ deps statically linked into
`libIREEMLIRKitPublicAPI.so`, which all python extensions depend on. The
entire project is compiled with hidden visibility, so the only exported
symbols are those explicitly made visible (i.e. as part of the C-API or
other internal detritus like type uniquing, etc).

The upstream Python bindings support this layout specifically, probing for
an `_mlir_libs` module and falling back to a build-tree based layout if
needed. The `_mlir_libs` module exports several hooks for further integrations:

* `load_extension`: Used by the core MLIR library loader to find Python extension
  libraries.
* `preload_dependency`: Used on Windows to eagerly load dependency DLL(s)
  so that the search order approximates that on Unix.
* `get_include_dirs`: Gets paths to add to C include directories in order to
  compile against the C-API.
* `get_library_dirs`: Gets directories to add to the linker library search path
  to compile against the C-API.
* `get_api_libraries`: Gets list of absolute paths to API libraries that should
  be linked against to compile against the C-API.

The package is meant to be hermetic and not extended further with additioanl
C++ dependencies. However, sufficient headers and libraries are distributed
to link against the various exported C APIs. This is used, for example, to
build PyTorch and other plugins with their build system, depending on the
MLIR/et-al C APIs.

## Building

Eventually, there will be a `setup.py` here that does the right thing.

For now:

```
cmake -GNinja -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD/install .
ninja && ninja install
export PYTHONPATH=$PWD/install/python_package
```
