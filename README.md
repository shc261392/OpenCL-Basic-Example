# Basic Example for OpenCL

This is a basic example for OpenCL programming model, serving a main purpose for being a good reference when new to OpenCL. For simplicity, most OpenCL API calls are wrapped in C++ wrapper functions. Reference the `main` function for the programming flow, and trace details in each wrapper function to understand how exactly the OpenCL host-side API works.

The OpenCL kernel performs a very simple "Vector Add" operation like C = A + B. Since it is not a compute-intensive operation and OpenCL has some setup overhead, it is possible that the OpenCL kernel is slower in performance compared to C++ sequential code for small vector sizes and global work sizes.

## Getting Started

You should be able to run OpenCL on most CPUs and/or GPUs.

A quick way to check if your machine is capable of running OpenCL is to use `clinfo`, simply run:

```
$ clinfo
```

If at least one OpenCL platform is shown, your have one or more hardwares that support OpenCL. 

### Prerequisites

To run OpenCL programs, you have to install one of the OpenCL runtime/sdk:

* [AMD APP SDK 3.0](http://debian.nullivex.com/amd/AMD-APP-SDKInstaller-v3.0.130.136-GA-linux64.tar.bz2) - Mirror file for linux x86_64
* [Intel SDK for OpenCL](https://software.intel.com/en-us/intel-opencl) - Requires registration
* [Intel Compute Runtime](https://github.com/intel/compute-runtime)

AMD SDK is recommended if you do not know which one to use.

##### Installing AMD APP SDK 3.0

```
$ wget http://debian.nullivex.com/amd/AMD-APP-SDKInstaller-v3.0.130.136-GA-linux64.tar.bz2
$ tar jxvf AMD-APP-SDKInstaller-v3.0.130.136-GA-linux64.tar.bz2
$ chmod +x ./AMD-APP-SDK-v3.0.130.136-GA-linux64.sh
$ ./AMD-APP-SDK-v3.0.130.136-GA-linux64.sh
```

##### Setting up OpenCL path for compilation

After installation, environment variables `OCL_INC_DIR` and `OCL_LIB_DIR` should be set to OpenCL include directory and OpenCL lib directory, respectively.

If you are using AMD APP SDK, run:
```
$ export OCL_IND_DIR=$AMDAPPSDKROOT/include
$ export OCL_LIB_IDR=$AMDAPPSDKROOT/lib/x86_64
```

Alternatively, you could just modify the compiling flags in Makefile.

### Compilation

Compile:
```
make
```

Clean:
```
make clean
```

### Run

Specify vector size and global work size when running the program.

For example, if you want to run the vector add operation while vector size = 100,000 and global work size = 1,000, run:
```
./sample 100000 1000
```

You could see whether the program is successful or not and the relative speed compared to C++ sequential vector add.

### About why using clEnqueueMapBuffer

* [Intel's Opinion](https://software.intel.com/en-us/articles/getting-the-most-from-opencl-12-how-to-increase-performance-by-minimizing-buffer-copies-on-intel-processor-graphics)

