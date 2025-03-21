; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -verify-machineinstrs | FileCheck %s

@buf = dso_local global [3072 x i8] zeroinitializer, align 64

define dso_local void @test_api(i16 signext %0, i16 signext %1) nounwind {
; CHECK-LABEL: test_api:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $2120, %rsp # imm = 0x848
; CHECK-NEXT:    movl %esi, %ebx
; CHECK-NEXT:    movl %edi, %ebp
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, (%rsp)
; CHECK-NEXT:    movb $1, (%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg (%rsp)
; CHECK-NEXT:    movl $32, %r14d
; CHECK-NEXT:    movl $buf+2048, %r15d
; CHECK-NEXT:    tileloadd (%r15,%r14), %tmm5
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_2
; CHECK-NEXT:  # %bb.1: # %if.true
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movw $8, %cx
; CHECK-NEXT:    tileloadd (%rax,%r14), %tmm0
; CHECK-NEXT:    movl $buf+1024, %eax
; CHECK-NEXT:    tileloadd (%rax,%r14), %tmm1
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tilestored %tmm5, 1088(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    tdpbssd %tmm1, %tmm0, %tmm5
; CHECK-NEXT:    tilestored %tmm5, 64(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    ldtilecfg (%rsp)
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tileloadd 64(%rsp,%rax), %tmm6 # 1024-byte Folded Reload
; CHECK-NEXT:    jmp .LBB0_3
; CHECK-NEXT:  .LBB0_2: # %if.false
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movw $8, %cx
; CHECK-NEXT:    tileloadd (%rax,%r14), %tmm2
; CHECK-NEXT:    movl $buf+1024, %eax
; CHECK-NEXT:    tileloadd (%rax,%r14), %tmm3
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tilestored %tmm5, 1088(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    tdpbssd %tmm3, %tmm2, %tmm5
; CHECK-NEXT:    tilestored %tmm5, 64(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    ldtilecfg (%rsp)
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tileloadd 64(%rsp,%rax), %tmm6 # 1024-byte Folded Reload
; CHECK-NEXT:    tilestored %tmm6, (%r15,%r14)
; CHECK-NEXT:  .LBB0_3: # %exit
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movl $32, %ecx
; CHECK-NEXT:    movw $8, %dx
; CHECK-NEXT:    tileloadd (%rax,%rcx), %tmm4
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tileloadd 1088(%rsp,%rax), %tmm5 # 1024-byte Folded Reload
; CHECK-NEXT:    tdpbssd %tmm4, %tmm6, %tmm5
; CHECK-NEXT:    movl $buf+2048, %eax
; CHECK-NEXT:    tilestored %tmm5, (%rax,%rcx)
; CHECK-NEXT:    addq $2120, %rsp # imm = 0x848
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    retq
  %c = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 2048), i64 32)
  br i1 undef, label %if.true, label %if.false
if.true:
  %a1 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 8, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 0), i64 32)
  %b1 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 1024), i64 32)
  %d1 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %0, i16 %1, i16 8, x86_amx %c, x86_amx %a1, x86_amx %b1)
  tail call void (...) @foo()
  br label %exit
if.false:
  %a2 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 8, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 0), i64 32)
  %b2 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 1024), i64 32)
  %d2 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %0, i16 %1, i16 8, x86_amx %c, x86_amx %a2, x86_amx %b2)
  tail call void (...) @foo()
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 2048), i64 32, x86_amx %d2)
  br label %exit
exit:
  %d = phi x86_amx [ %d1, %if.true ], [ %d2, %if.false ]
  %a = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 8, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 0), i64 32)
  %res = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %0, i16 %1, i16 8, x86_amx %c, x86_amx %d, x86_amx %a)
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 2048), i64 32, x86_amx %res)
  ret void
}

define dso_local void @test3(i8 *%buf) nounwind {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, %bp
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB1_3
; CHECK-NEXT:  # %bb.1: # %loop.header.preheader
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $32, %r14d
; CHECK-NEXT:    xorl %r15d, %r15d
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB1_2: # %loop.header
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    tilestored %tmm0, (%rbx,%r14)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    tileloadd (%rbx,%r14), %tmm1
; CHECK-NEXT:    tileloadd (%rbx,%r14), %tmm2
; CHECK-NEXT:    tdpbssd %tmm2, %tmm1, %tmm0
; CHECK-NEXT:    tilestored %tmm0, (%rbx,%r14)
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    incl %r15d
; CHECK-NEXT:    cmpw $100, %r15w
; CHECK-NEXT:    jl .LBB1_2
; CHECK-NEXT:  .LBB1_3: # %exit
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %t5 = tail call x86_amx @llvm.x86.tilezero.internal(i16 8, i16 8)
  br i1 undef, label %loop.header, label %exit

loop.header:
  %ivphi = phi i16 [0, %entry], [%iv, %loop.latch]
  call void @llvm.x86.tilestored64.internal(i16 8, i16 8, i8* %buf, i64 32, x86_amx %t5)
  call void (...) @foo()
  br label %loop.body

loop.body:
  %t1 = tail call x86_amx @llvm.x86.tilezero.internal(i16 8, i16 8)
  %t2 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 8, i8* %buf, i64 32)
  %t3 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 8, i8* %buf, i64 32)
  %t4 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 8, i16 8, i16 8, x86_amx %t1, x86_amx %t2, x86_amx %t3)
  tail call void @llvm.x86.tilestored64.internal(i16 8, i16 8, i8* %buf, i64 32, x86_amx %t4)
  br label %loop.latch

loop.latch:
  %iv = add i16 %ivphi, 1
  %c = icmp slt i16 %iv, 100
  br i1 %c, label %loop.header, label %exit

exit:
  ret void
}

declare dso_local void @foo(...) nounwind

declare x86_amx @llvm.x86.tilezero.internal(i16, i16)
declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, i8*, i64)
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare void @llvm.x86.tilestored64.internal(i16, i16, i8*, i64, x86_amx)
