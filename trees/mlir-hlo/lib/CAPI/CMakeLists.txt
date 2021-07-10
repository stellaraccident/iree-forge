add_mlir_public_c_api_library(MLIRHLOCAPI
  Dialects.cpp
  MLIR_CAPI_GROUP MLIRHLO
  LINK_LIBS PUBLIC
  MhloDialect
)

# Must come after the above, which populates groups
add_mlir_c_api_export_library(
  MLIRHLOPublicAPI
  MLIR_CAPI_GROUPS MLIRHLO
)
