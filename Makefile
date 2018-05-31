CC = gcc
CXX = g++
RM = rm -f
CFLAGS = -Wall -lm -g
CXXFLAGS = -lstdc++ -std=c++11

INCLUDE = -I ${OCL_INC_DIR}
LDFLAGS = -L ${OCL_LIB_DIR} -lOpenCL

SRCS = $(wildcard *.cpp)
BINS = $(SRCS:.cpp=)

all: host

host: 
	$(CXX) $(SRCS) -o $(BINS) $(CFLAGS) $(CXXFLAGS) $(INCLUDE) $(LDFLAGS)

clean:
	$(RM) sample
