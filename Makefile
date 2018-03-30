SHELL = /bin/bash
CC = gcc
CFLAGS = -Wall -lm -g
CXXFLAGS = -lstdc++ -std=c++11

INCLUDE = -I $(LIBCLCXX)
LDFLAGS = -lOpenCL

LIBCLCXX = $(HOME)/fxp/libclcxx/include/
LLVM_BIN = $(HOME)/fxp/build/bin/

SRCS = $(wildcard *.cpp)
OBJS = $(SRCS:.cpp=.o)
BINS = $(OBJS:.o=)

CL_SRCS = $(wildcard kernels/cpp_*.cl)
LL_SRCS = $(wildcard kernels/cpp_*.ll)
BC_SRCS = $(wildcard kernels/cpp_*.bc)
LLVMIR = $(CL_SRCS:.cl=.ll)
LLVMAS = $(LL_SRCS:.ll=.bc)
SPT = $(BC_SRCS:.bc=.spt)
SPV = $(BC_SRCS:.bc=.spv)

CL = $(LLVM_BIN)clang
CLFLAGS = -cc1 -triple spir64-unknown-unknown -cl-std=c++ -x cl -O0 -emit-llvm
AS = $(LLVM_BIN)llvm-as
SPIRV = $(LLVM_BIN)llvm-spirv

.SUFFIXES:
.SUFFIXES: .cpp .o .cl .ll

.PHONY: all

all: host kernel

host: 
	$(CC) $(SRCS) -o $(BINS) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS)

kernel: clang as spirv spirv-text

spirv:
	$(SPIRV) $(BC_SRCS) -o $(SPV)

spirv-text:
	$(SPIRV) $(BC_SRCS) -spirv-text -o $(SPT)

as:
	$(AS) $(LL_SRCS) -o $(LLVMAS)

clang:
	$(CL) $(CLFLAGS) $(INCLUDE) $(CL_SRCS) -o $(LLVMIR)



.PHONY: clean

clean:
	rm sample
