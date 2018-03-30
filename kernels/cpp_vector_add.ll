; ModuleID = 'kernels/cpp_vector_add.cl'
target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-n8:16:32:64"
target triple = "spir64-unknown-unknown"

%"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" = type { float addrspace(1)* }
%"class.cl::global_ptr<float []>" = type { %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" }

@__spirv_BuiltInGlobalSize = external addrspace(1) global <3 x i64>
@__spirv_BuiltInGlobalInvocationId = external addrspace(1) global <3 x i64>

; Function Attrs: nounwind
define spir_kernel void @float_vector_add(float addrspace(1)* %a.coerce, float addrspace(1)* %b.coerce, float addrspace(1)* %result.coerce, i32 %vector_size) #0 {
entry:
  %this.addr.i.i29 = alloca %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*, align 8
  %this.addr.i30 = alloca %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*, align 8
  %pos.addr.i31 = alloca i64, align 8
  %this.addr.i.i22 = alloca %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*, align 8
  %this.addr.i23 = alloca %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*, align 8
  %pos.addr.i24 = alloca i64, align 8
  %this.addr.i.i = alloca %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*, align 8
  %this.addr.i = alloca %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*, align 8
  %pos.addr.i = alloca i64, align 8
  %retval.i16 = alloca i64, align 8
  %dimindx.addr.i17 = alloca i32, align 4
  %retval.i = alloca i64, align 8
  %dimindx.addr.i = alloca i32, align 4
  %a = alloca %"class.cl::global_ptr<float []>", align 8
  %b = alloca %"class.cl::global_ptr<float []>", align 8
  %result = alloca %"class.cl::global_ptr<float []>", align 8
  %vector_size.addr = alloca i32, align 4
  %idx = alloca i32, align 4
  %coerce.dive = getelementptr %"class.cl::global_ptr<float []>"* %a, i32 0, i32 0
  %coerce.dive1 = getelementptr %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"* %coerce.dive, i32 0, i32 0
  store float addrspace(1)* %a.coerce, float addrspace(1)** %coerce.dive1
  %coerce.dive2 = getelementptr %"class.cl::global_ptr<float []>"* %b, i32 0, i32 0
  %coerce.dive3 = getelementptr %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"* %coerce.dive2, i32 0, i32 0
  store float addrspace(1)* %b.coerce, float addrspace(1)** %coerce.dive3
  %coerce.dive4 = getelementptr %"class.cl::global_ptr<float []>"* %result, i32 0, i32 0
  %coerce.dive5 = getelementptr %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"* %coerce.dive4, i32 0, i32 0
  store float addrspace(1)* %result.coerce, float addrspace(1)** %coerce.dive5
  store i32 %vector_size, i32* %vector_size.addr, align 4
  store i32 0, i32* %dimindx.addr.i, align 4
  %0 = load i32* %dimindx.addr.i, align 4
  switch i32 %0, label %sw.default.i [
    i32 0, label %sw.bb.i
    i32 1, label %sw.bb1.i
    i32 2, label %sw.bb2.i
  ]

sw.bb.i:                                          ; preds = %entry
  %1 = load <3 x i64> addrspace(1)* @__spirv_BuiltInGlobalInvocationId, align 32
  %2 = extractelement <3 x i64> %1, i64 0
  store i64 %2, i64* %retval.i
  br label %_ZN2cl13get_global_idEj.exit

sw.bb1.i:                                         ; preds = %entry
  %3 = load <3 x i64> addrspace(1)* @__spirv_BuiltInGlobalInvocationId, align 32
  %4 = extractelement <3 x i64> %3, i64 1
  store i64 %4, i64* %retval.i
  br label %_ZN2cl13get_global_idEj.exit

sw.bb2.i:                                         ; preds = %entry
  %5 = load <3 x i64> addrspace(1)* @__spirv_BuiltInGlobalInvocationId, align 32
  %6 = extractelement <3 x i64> %5, i64 2
  store i64 %6, i64* %retval.i
  br label %_ZN2cl13get_global_idEj.exit

sw.default.i:                                     ; preds = %entry
  store i64 0, i64* %retval.i
  br label %_ZN2cl13get_global_idEj.exit

_ZN2cl13get_global_idEj.exit:                     ; preds = %sw.bb.i, %sw.bb1.i, %sw.bb2.i, %sw.default.i
  %7 = load i64* %retval.i
  %conv = trunc i64 %7 to i32
  store i32 %conv, i32* %idx, align 4
  br label %for.cond

for.cond:                                         ; preds = %_ZN2cl15get_global_sizeEj.exit, %_ZN2cl13get_global_idEj.exit
  %8 = load i32* %idx, align 4
  %9 = load i32* %vector_size.addr, align 4
  %cmp = icmp ult i32 %8, %9
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %10 = bitcast %"class.cl::global_ptr<float []>"* %a to %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"*
  %11 = load i32* %idx, align 4
  %conv6 = zext i32 %11 to i64
  %12 = addrspacecast %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"* %10 to %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*
  store %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %12, %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i30, align 8
  store i64 %conv6, i64* %pos.addr.i31, align 8
  %this1.i32 = load %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i30
  %13 = load i64* %pos.addr.i31, align 8
  store %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %this1.i32, %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i.i29, align 8
  %this1.i.i33 = load %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i.i29
  %__ptr.i.i34 = getelementptr inbounds %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %this1.i.i33, i32 0, i32 0
  %14 = load float addrspace(1)* addrspace(4)* %__ptr.i.i34, align 8
  %arrayidx.i35 = getelementptr inbounds float addrspace(1)* %14, i64 %13
  %15 = load float addrspace(1)* %arrayidx.i35
  %16 = bitcast %"class.cl::global_ptr<float []>"* %b to %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"*
  %17 = load i32* %idx, align 4
  %conv8 = zext i32 %17 to i64
  %18 = addrspacecast %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"* %16 to %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*
  store %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %18, %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i23, align 8
  store i64 %conv8, i64* %pos.addr.i24, align 8
  %this1.i25 = load %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i23
  %19 = load i64* %pos.addr.i24, align 8
  store %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %this1.i25, %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i.i22, align 8
  %this1.i.i26 = load %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i.i22
  %__ptr.i.i27 = getelementptr inbounds %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %this1.i.i26, i32 0, i32 0
  %20 = load float addrspace(1)* addrspace(4)* %__ptr.i.i27, align 8
  %arrayidx.i28 = getelementptr inbounds float addrspace(1)* %20, i64 %19
  %21 = load float addrspace(1)* %arrayidx.i28
  %add = fadd float %15, %21
  %22 = bitcast %"class.cl::global_ptr<float []>"* %result to %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"*
  %23 = load i32* %idx, align 4
  %conv10 = zext i32 %23 to i64
  %24 = addrspacecast %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>"* %22 to %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)*
  store %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %24, %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i, align 8
  store i64 %conv10, i64* %pos.addr.i, align 8
  %this1.i = load %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i
  %25 = load i64* %pos.addr.i, align 8
  store %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %this1.i, %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i.i, align 8
  %this1.i.i = load %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)** %this.addr.i.i
  %__ptr.i.i = getelementptr inbounds %"class.cl::__details::__as_ptr_impl<float [], add_global, global_ptr, cl::__details::__as_ptr_type::__as_ptr_array>" addrspace(4)* %this1.i.i, i32 0, i32 0
  %26 = load float addrspace(1)* addrspace(4)* %__ptr.i.i, align 8
  %arrayidx.i = getelementptr inbounds float addrspace(1)* %26, i64 %25
  store float %add, float addrspace(1)* %arrayidx.i
  br label %for.inc

for.inc:                                          ; preds = %for.body
  store i32 0, i32* %dimindx.addr.i17, align 4
  %27 = load i32* %dimindx.addr.i17, align 4
  switch i32 %27, label %sw.default.i21 [
    i32 0, label %sw.bb.i18
    i32 1, label %sw.bb1.i19
    i32 2, label %sw.bb2.i20
  ]

sw.bb.i18:                                        ; preds = %for.inc
  %28 = load <3 x i64> addrspace(1)* @__spirv_BuiltInGlobalSize, align 32
  %29 = extractelement <3 x i64> %28, i64 0
  store i64 %29, i64* %retval.i16
  br label %_ZN2cl15get_global_sizeEj.exit

sw.bb1.i19:                                       ; preds = %for.inc
  %30 = load <3 x i64> addrspace(1)* @__spirv_BuiltInGlobalSize, align 32
  %31 = extractelement <3 x i64> %30, i64 1
  store i64 %31, i64* %retval.i16
  br label %_ZN2cl15get_global_sizeEj.exit

sw.bb2.i20:                                       ; preds = %for.inc
  %32 = load <3 x i64> addrspace(1)* @__spirv_BuiltInGlobalSize, align 32
  %33 = extractelement <3 x i64> %32, i64 2
  store i64 %33, i64* %retval.i16
  br label %_ZN2cl15get_global_sizeEj.exit

sw.default.i21:                                   ; preds = %for.inc
  store i64 1, i64* %retval.i16
  br label %_ZN2cl15get_global_sizeEj.exit

_ZN2cl15get_global_sizeEj.exit:                   ; preds = %sw.bb.i18, %sw.bb1.i19, %sw.bb2.i20, %sw.default.i21
  %34 = load i64* %retval.i16
  %35 = load i32* %idx, align 4
  %conv13 = zext i32 %35 to i64
  %add14 = add i64 %conv13, %34
  %conv15 = trunc i64 %add14 to i32
  store i32 %conv15, i32* %idx, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!opencl.enable.FP_CONTRACT = !{}
!opencl.spir.version = !{!0}
!opencl.ocl.version = !{!1}
!opencl.used.extensions = !{!2}
!opencl.used.optional.core.features = !{!2}
!opencl.compiler.options = !{!2}
!llvm.ident = !{!3}
!spirv.Source = !{!4}
!spirv.String = !{!5}

!0 = !{i32 1, i32 2}
!1 = !{i32 2, i32 2}
!2 = !{}
!3 = !{!"clang version 3.6.1 (https://paladine.cs.nthu.edu.tw/opencl-next-fixed-point/llvm-spirv-clang.git bfdcc37bf3cc03ed67df313cfc83656e5150dcb1) (https://paladine.cs.nthu.edu.tw/opencl-next-fixed-point/llvm-spirv.git 040d090d7e39c1f4ff6f8f98ddc09c3e33a59ab2)"}
!4 = !{i32 4, i32 202000, !5}
!5 = !{!"kernels/cpp_vector_add.cl"}
