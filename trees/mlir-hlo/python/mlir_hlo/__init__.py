def _load_extension():
  from mlir import _cext_loader
  _cext_loader._cext.globals.append_dialect_search_prefix("mlir_hlo.dialects")
  _mlirHloCext = _cext_loader._load_extension("_mlirHlo")
  _cext_loader._reexport_cext(None, __name__, _mlirHloCext)
  return _mlirHloCext

_load_extension()
