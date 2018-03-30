SHELL = /bin/bash
CC = gcc
CFLAGS = -Wall -lm -g
CXXFLAGS = -lstdc++ -std=c++11

INCLUDE = -I $(LIBCLCXX)
LDFLAGS = -lOpenCL

LIBCLCXX = $(HOME)/fxp/libclcxx/include/

SRCS = $(wildcard *.cpp)
OBJS = $(SRCS:.cpp=.o)
BINS = $(OBJS:.o=)

CL_SRCS = $(wildcard src/*.cl)
LLVMIR = $(CL_SRCS:.cl=.ll)
SPT = $(LLVMIR:.ll=.spt)
SPV = $(LLVMIR:.ll=.spv)

.SUFFIXES:
.SUFFIXES: .cpp .o .cl .ll

.PHONY: all

all: host

host: 
	$(CC) $(SRCS) -o $(BINS) $(CFLAGS) $(CXXFLAGS) $(LDFLAGS)

.PHONY: clean

clean:
	rm sample
