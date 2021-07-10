include(AddMLIRPython)

################################################################################
# Generate dialect-specific bindings.
################################################################################

add_mlir_dialect_python_bindings(MLIRHLOBindingsPythonMhloOps
  TD_FILE MhloOps.td
  DIALECT_NAME mhlo
  PACKAGE_PATH mlir_hlo/dialects)
