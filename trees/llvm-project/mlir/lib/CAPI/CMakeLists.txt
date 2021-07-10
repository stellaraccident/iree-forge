add_subdirectory(Debug)
add_subdirectory(Dialect)
add_subdirectory(Conversion)
add_subdirectory(ExecutionEngine)
add_subdirectory(IR)
add_subdirectory(Registration)
add_subdirectory(Transforms)

# Must come after the above, which populate the "core" group.
add_mlir_c_api_export_library(
  MLIRPublicAPI
  MLIR_CAPI_GROUPS CORE
)
