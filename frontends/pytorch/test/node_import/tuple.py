# -*- Python -*-
# This file is licensed under a pytorch-style license
# See frontends/pytorch/LICENSE for license information.

import torch
import torch_mlir

# RUN: %PYTHON %s | npcomp-opt | FileCheck %s

mb = torch_mlir.ModuleBuilder()

# CHECK-LABEL:   func @__torch__.f(
# CHECK-SAME:            %[[T0:.*]]: !torch.tensor,
# CHECK-SAME:            %[[T1:.*]]: !torch.tensor) -> !torch.tuple<!torch.tensor, !torch.tensor> {
# CHECK:           %[[RET:.*]] = torch.prim.TupleConstruct %[[T0]], %[[T1]] : !torch.tensor, !torch.tensor
# CHECK:           return %[[RET]] : !torch.tuple<!torch.tensor, !torch.tensor>

@mb.import_function
@torch.jit.script
def f(t0, t1):
  return t0, t1

assert isinstance(f, torch.jit.ScriptFunction)
mb.module.operation.print()
print()
