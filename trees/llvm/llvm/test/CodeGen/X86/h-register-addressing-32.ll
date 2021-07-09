; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- -mattr=-bmi | FileCheck %s

; Use h-register extract and zero-extend.

define double @foo8(double* nocapture inreg %p, i32 inreg %x) nounwind readonly {
; CHECK-LABEL: foo8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dh, %ecx
; CHECK-NEXT:    fldl (%eax,%ecx,8)
; CHECK-NEXT:    retl
  %t0 = lshr i32 %x, 8
  %t1 = and i32 %t0, 255
  %t2 = getelementptr double, double* %p, i32 %t1
  %t3 = load double, double* %t2, align 8
  ret double %t3
}

define float @foo4(float* nocapture inreg %p, i32 inreg %x) nounwind readonly {
; CHECK-LABEL: foo4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dh, %ecx
; CHECK-NEXT:    flds (%eax,%ecx,4)
; CHECK-NEXT:    retl
  %t0 = lshr i32 %x, 8
  %t1 = and i32 %t0, 255
  %t2 = getelementptr float, float* %p, i32 %t1
  %t3 = load float, float* %t2, align 8
  ret float %t3
}

define i16 @foo2(i16* nocapture inreg %p, i32 inreg %x) nounwind readonly {
; CHECK-LABEL: foo2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dh, %ecx
; CHECK-NEXT:    movzwl (%eax,%ecx,2), %eax
; CHECK-NEXT:    retl
  %t0 = lshr i32 %x, 8
  %t1 = and i32 %t0, 255
  %t2 = getelementptr i16, i16* %p, i32 %t1
  %t3 = load i16, i16* %t2, align 8
  ret i16 %t3
}

define i8 @foo1(i8* nocapture inreg %p, i32 inreg %x) nounwind readonly {
; CHECK-LABEL: foo1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dh, %ecx
; CHECK-NEXT:    movb (%eax,%ecx), %al
; CHECK-NEXT:    retl
  %t0 = lshr i32 %x, 8
  %t1 = and i32 %t0, 255
  %t2 = getelementptr i8, i8* %p, i32 %t1
  %t3 = load i8, i8* %t2, align 8
  ret i8 %t3
}

define i8 @bar8(i8* nocapture inreg %p, i32 inreg %x) nounwind readonly {
; CHECK-LABEL: bar8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dh, %ecx
; CHECK-NEXT:    movb (%eax,%ecx,8), %al
; CHECK-NEXT:    retl
  %t0 = lshr i32 %x, 5
  %t1 = and i32 %t0, 2040
  %t2 = getelementptr i8, i8* %p, i32 %t1
  %t3 = load i8, i8* %t2, align 8
  ret i8 %t3
}

define i8 @bar4(i8* nocapture inreg %p, i32 inreg %x) nounwind readonly {
; CHECK-LABEL: bar4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dh, %ecx
; CHECK-NEXT:    movb (%eax,%ecx,4), %al
; CHECK-NEXT:    retl
  %t0 = lshr i32 %x, 6
  %t1 = and i32 %t0, 1020
  %t2 = getelementptr i8, i8* %p, i32 %t1
  %t3 = load i8, i8* %t2, align 8
  ret i8 %t3
}

define i8 @bar2(i8* nocapture inreg %p, i32 inreg %x) nounwind readonly {
; CHECK-LABEL: bar2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movzbl %dh, %ecx
; CHECK-NEXT:    movb (%eax,%ecx,2), %al
; CHECK-NEXT:    retl
  %t0 = lshr i32 %x, 7
  %t1 = and i32 %t0, 510
  %t2 = getelementptr i8, i8* %p, i32 %t1
  %t3 = load i8, i8* %t2, align 8
  ret i8 %t3
}