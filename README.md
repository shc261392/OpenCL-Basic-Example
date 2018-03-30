# Basic Example for OpenCL C and C++

This is a basic example for both OpenCL C and OpenCL C++, serving a main purpose for being a good reference when new to OpenCL or OpenCL C++. You have to edit the main host program to define whether OpenCL C kernel or OpenCL C++ kernel will be built and run.

## Getting Started

Since there are already tons of resources for OpenCL C on web, unless otherwise noted, all the following instructions are for OpenCL C++.

### Prerequisites

OpenCL C++ program can only be built and run on OpenCL 2.1 or OpenCL 2.2 runtime, since building OpenCL C++ program requires the 2.1/2.2 new API *clCreateProgramWithIL*, as well as runtime support for SPIR-V.

Other than the runtime, you will need the following:

* [OpenCL C++ Standard Library](https://github.com/KhronosGroup/libclcxx) - implemented by Khronos
* [SPIR generator/Clang](https://github.com/KhronosGroup/SPIR/tree/spirv-1.1)

After cloning these prerequisites and have LLVM installed, please modify the path of LIBCLCXX and LLVM_BIN in the Makefile.

Compile the host code and kernel code (C++ part):
```
make
```

Clean:
```
make clean
```


### About why using clEnqueueMapBuffer

Not related to OpenCL C++ though, just want to keep notes.

* [Intel's Opinion](https://software.intel.com/en-us/articles/getting-the-most-from-opencl-12-how-to-increase-performance-by-minimizing-buffer-copies-on-intel-processor-graphics)

### About programming in OpenCL C++ kernel language

* [OpenCL C to OpenCL C++ Porting Guidelines](https://github.com/OpenCL/OpenCLCXXPortingGuidelines/blob/master/OpenCLCToOpenCLCppPortingGuidelines.md)
