# -*- Python -*-
# This file is licensed under a pytorch-style license
# See frontends/pytorch/LICENSE for license information.

import typing

import torch
import torch_mlir

# RUN: %PYTHON %s | npcomp-opt | FileCheck %s

mb = torch_mlir.ModuleBuilder()



class TestModule(torch.nn.Module):
  def __init__(self):
    super().__init__()

  # CHECK-LABEL:   func private @__torch__.TestModule.forward(
  # CHECK-SAME:                                               %[[SELF:.*]]: !torch.nn.Module<"__torch__.TestModule">) -> !torch.optional<!torch.int> {
  # CHECK:           %[[NONE:.*]] = torch.constant.none
  # CHECK:           %[[DEREFINED:.*]] = torch.derefine %[[NONE]] : !torch.none to !torch.optional<!torch.int>
  # CHECK:           %[[RET:.*]] = torch.prim.CallMethod %[[SELF]]["callee"] (%[[DEREFINED]]) : !torch.nn.Module<"__torch__.TestModule">, (!torch.optional<!torch.int>) -> !torch.optional<!torch.int>
  # CHECK:           return %[[RET]] : !torch.optional<!torch.int>
  def forward(self):
    return self.callee(None)
  def callee(self, o: typing.Optional[int]):
    return o

test_module = TestModule()
recursivescriptmodule = torch.jit.script(test_module)
# TODO: Automatically handle unpacking Python class RecursiveScriptModule into the underlying ScriptModule.
mb.import_module(recursivescriptmodule._c)
mb.module.operation.print()
