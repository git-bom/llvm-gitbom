; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown -O3 -cgp-icmp-eq2icmp-st -verify-machineinstrs < %s | FileCheck %s

; Test cases are generated from:
; long long NAME(PARAM a, PARAM b) {
;   if (LHS > RHS)
;     return b;
;   if (LHS < RHS)
;     return a;\
;   return a * b;
; }
; Please note funtion name is defined as <PARAM>_<LHS>_<RHS>. Take ll_a_op_b__1
; for example. ll is PARAM, a_op_b (i.e., a << b) is LHS, _1 (i.e., -1) is RHS.

target datalayout = "e-m:e-i64:64-n32:64"

define i64 @ll_a_op_b__2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b__2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    movq %rdi, %rdx
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    shlq %cl, %rdx
; CHECK-NEXT:    cmpq $-2, %rdx
; CHECK-NEXT:    jg .LBB0_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:  .LBB0_2: # %return
; CHECK-NEXT:    retq
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, -2
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b__1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b__1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    movq %rdi, %rdx
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    shlq %cl, %rdx
; CHECK-NEXT:    testq %rdx, %rdx
; CHECK-NEXT:    js .LBB1_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB1_1: # %if.end
; CHECK-NEXT:    cmpq $-1, %rdx
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:    retq
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, -1
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b_0(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b_0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    movq %rdi, %rdx
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    shlq %cl, %rdx
; CHECK-NEXT:    testq %rdx, %rdx
; CHECK-NEXT:    jle .LBB2_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB2_1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovsq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:    retq
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, 0
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b_1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    movq %rdi, %rdx
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    shlq %cl, %rdx
; CHECK-NEXT:    cmpq $1, %rdx
; CHECK-NEXT:    jg .LBB3_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:  .LBB3_2: # %return
; CHECK-NEXT:    retq
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, 1
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_op_b_2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_op_b_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    movq %rdi, %rdx
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    shlq %cl, %rdx
; CHECK-NEXT:    cmpq $2, %rdx
; CHECK-NEXT:    jg .LBB4_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:  .LBB4_2: # %return
; CHECK-NEXT:    retq
entry:
  %shl = shl i64 %a, %b
  %cmp = icmp sgt i64 %shl, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i64 %shl, 2
  %mul = select i1 %cmp2, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a__2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a__2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    cmpq $-2, %rdi
; CHECK-NEXT:    jg .LBB5_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:  .LBB5_2: # %return
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i64 %a, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, -2
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a__1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a__1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    testq %rdi, %rdi
; CHECK-NEXT:    js .LBB6_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB6_1: # %if.end
; CHECK-NEXT:    cmpq $-1, %rdi
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i64 %a, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, -1
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_0(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    testq %rdi, %rdi
; CHECK-NEXT:    jle .LBB7_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB7_1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovsq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i64 %a, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, 0
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_1(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    cmpq $1, %rdi
; CHECK-NEXT:    jg .LBB8_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:  .LBB8_2: # %return
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i64 %a, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, 1
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @ll_a_2(i64 %a, i64 %b) {
; CHECK-LABEL: ll_a_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rsi, %rax
; CHECK-NEXT:    cmpq $2, %rdi
; CHECK-NEXT:    jg .LBB9_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %ecx
; CHECK-NEXT:    cmovlq %rcx, %rax
; CHECK-NEXT:    imulq %rdi, %rax
; CHECK-NEXT:  .LBB9_2: # %return
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i64 %a, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i64 %a, 2
  %mul = select i1 %cmp1, i64 %b, i64 1
  %spec.select = mul nsw i64 %mul, %a
  ret i64 %spec.select

return:                                           ; preds = %entry
  ret i64 %b
}

define i64 @i_a_op_b__2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b__2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shll %cl, %eax
; CHECK-NEXT:    cmpl $-2, %eax
; CHECK-NEXT:    jg .LBB10_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %ecx
; CHECK-NEXT:    imull %edi, %ecx
; CHECK-NEXT:  .LBB10_2: # %return
; CHECK-NEXT:    movslq %ecx, %rax
; CHECK-NEXT:    retq
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, -2
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b__1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b__1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shll %cl, %eax
; CHECK-NEXT:    testl %eax, %eax
; CHECK-NEXT:    js .LBB11_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    movslq %ecx, %rax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB11_1: # %if.end
; CHECK-NEXT:    cmpl $-1, %eax
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %ecx
; CHECK-NEXT:    imull %edi, %ecx
; CHECK-NEXT:    movslq %ecx, %rax
; CHECK-NEXT:    retq
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, -1
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b_0(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b_0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shll %cl, %eax
; CHECK-NEXT:    testl %eax, %eax
; CHECK-NEXT:    jle .LBB12_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    movslq %ecx, %rax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB12_1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovsl %eax, %ecx
; CHECK-NEXT:    imull %edi, %ecx
; CHECK-NEXT:    movslq %ecx, %rax
; CHECK-NEXT:    retq
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, 0
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b_1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shll %cl, %eax
; CHECK-NEXT:    cmpl $1, %eax
; CHECK-NEXT:    jg .LBB13_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %ecx
; CHECK-NEXT:    imull %edi, %ecx
; CHECK-NEXT:  .LBB13_2: # %return
; CHECK-NEXT:    movslq %ecx, %rax
; CHECK-NEXT:    retq
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, 1
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_op_b_2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_op_b_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    shll %cl, %eax
; CHECK-NEXT:    cmpl $2, %eax
; CHECK-NEXT:    jg .LBB14_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %ecx
; CHECK-NEXT:    imull %edi, %ecx
; CHECK-NEXT:  .LBB14_2: # %return
; CHECK-NEXT:    movslq %ecx, %rax
; CHECK-NEXT:    retq
entry:
  %shl = shl i32 %a, %b
  %cmp = icmp sgt i32 %shl, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %shl, 2
  %mul = select i1 %cmp2, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a__2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a__2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $-2, %edi
; CHECK-NEXT:    jg .LBB15_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %esi
; CHECK-NEXT:    imull %edi, %esi
; CHECK-NEXT:  .LBB15_2: # %return
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %a, -2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, -2
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a__1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a__1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    js .LBB16_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB16_1: # %if.end
; CHECK-NEXT:    cmpl $-1, %edi
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %esi
; CHECK-NEXT:    imull %edi, %esi
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %a, -1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, -1
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_0(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    jle .LBB17_1
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB17_1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovsl %eax, %esi
; CHECK-NEXT:    imull %edi, %esi
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %a, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, 0
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $1, %edi
; CHECK-NEXT:    jg .LBB18_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %esi
; CHECK-NEXT:    imull %edi, %esi
; CHECK-NEXT:  .LBB18_2: # %return
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %a, 1
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, 1
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}

define i64 @i_a_2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: i_a_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $2, %edi
; CHECK-NEXT:    jg .LBB19_2
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    cmovll %eax, %esi
; CHECK-NEXT:    imull %edi, %esi
; CHECK-NEXT:  .LBB19_2: # %return
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %a, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %cmp1 = icmp eq i32 %a, 2
  %mul = select i1 %cmp1, i32 %b, i32 1
  %spec.select = mul nsw i32 %mul, %a
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0.in = phi i32 [ %b, %entry ], [ %spec.select, %if.end ]
  %retval.0 = sext i32 %retval.0.in to i64
  ret i64 %retval.0
}
