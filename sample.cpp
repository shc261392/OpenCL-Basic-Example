#include<iostream>
#include<fstream>
#include<vector>
#include<string.h>
#include<string>
#include<assert.h>

// ----- OpenCL header ----------------------------
#ifdef __APPLE__
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif
// ------------------------------------------------

// ----- Macro for OpenCL error code checking -----
#define ERR()\
    if (err != CL_SUCCESS)\
        std::cout << "OPENCL ERROR: "<< err <<" at file: "<< __FILE__ << ", line: " << __LINE__ << std::endl;\
    assert( err == CL_SUCCESS);\
// ------------------------------------------------

// ----- Debugging Info Printer -------------------
#define DEBUG_VERBOSE
// ------------------------------------------------
// ----- Use OpenCL C++ ---------------------------
#define OCL_CXX
// ------------------------------------------------



cl_context CreateContextForDefaultDevice()
{
    cl_int err;
    cl_uint num_platforms;
    size_t query_size;

    // Get the number of OpenCL platforms
    err = clGetPlatformIDs( 0, 0, &num_platforms );
    ERR();

    // Get all platforms
    std::vector<cl_platform_id> platforms(num_platforms);
    err = clGetPlatformIDs( num_platforms, platforms.data(), &num_platforms );
    ERR();

    #ifdef DEBUG_VERBOSE
    // Print all platform names
    for ( auto it = platforms.begin(); it != platforms.end(); ++it )
    {
        std::string platform_name;
        err = clGetPlatformInfo( *it, CL_PLATFORM_NAME, 0, NULL, &query_size);
        ERR();
        platform_name.resize(query_size / sizeof(char)) ;
        err = clGetPlatformInfo( *it, CL_PLATFORM_NAME, query_size, &platform_name[0], NULL);
        std::cout << "Platform name: " << platform_name << std::endl;
    }
    #endif

    // Create context on the first platform, with default OpenCL device
    cl_context_properties properties[] = { CL_CONTEXT_PLATFORM, 
                                           reinterpret_cast<cl_context_properties>(platforms[0]),
                                           0};
    cl_context context = clCreateContextFromType( properties, CL_DEVICE_TYPE_DEFAULT, NULL, NULL, &err );
    ERR();
    return context;
}

cl_command_queue CreateCommandQueue( cl_context* context ) 
{
    cl_int err;
    size_t query_size;    

    // Get the number of OpenCL devices
    err = clGetContextInfo( *context, CL_CONTEXT_DEVICES, 0, NULL, &query_size );
    ERR();

    // Get all devices
    std::vector<cl_device_id> devices( query_size / sizeof(cl_device_id) );
    err = clGetContextInfo ( *context, CL_CONTEXT_DEVICES, query_size, devices.data(), 0);
    ERR();

    // Print the name of first device
    #ifdef DEBUG_VERBOSE
    err = clGetDeviceInfo(devices[0], CL_DEVICE_NAME, 0, NULL, &query_size);
    std::string device_name;
    device_name.resize(query_size);
    clGetDeviceInfo(devices[0], CL_DEVICE_NAME, query_size, &device_name[0], 0);
    std::cout << "Device: " << device_name << std::endl;
    #endif

    // Create command queue with profiling enabled
    const cl_queue_properties properties[] = {CL_QUEUE_PROPERTIES, CL_QUEUE_PROFILING_ENABLE, 0};
    cl_command_queue queue = clCreateCommandQueueWithProperties( *context, devices[0], properties, &err );
    ERR();
    return queue;
}

cl_program CreateProgramWithSource( cl_context* context, const char* filename )
{
    cl_int err;

    // Read the file to program source string
    std::ifstream infile { filename };
    std::string program_source { std::istreambuf_iterator<char>(infile), std::istreambuf_iterator<char>() };

    // Create program from source    
    const char* src = program_source.c_str();
    cl_program program = clCreateProgramWithSource( *context, 1, &src, 0, &err );
    ERR();
    if ( !program ) std::cout << "Failed to create program: " << filename << " with source." << std::endl;

    // Build program
    err = clBuildProgram( program, 0, NULL, "-g", NULL, NULL);
    ERR();
    return program;
}

cl_program CreateProgramWithIL(cl_context *context, std::string filename)
{
    cl_int err;
    void *il;
    size_t sz;

    // Read SPIR-V binary (.spv) from file
    std::ifstream in(filename, std::ios::in | std::ios::binary);
    if (in)
    {
        in.seekg( 0, std::ios::end );
        sz = in.tellg();
        il = calloc( sz , sizeof(char));
        in.seekg( 0, std::ios::beg );
        in.read( (char*)il, sz );
        in.close();
    }

    // Create program with IL
    cl_program program = clCreateProgramWithIL( *context, il, sz, &err);
    ERR();

    // Build program
    // Note that for OpenCL C++, no compilers flags can be passed here
    err = clBuildProgram( program, 0, NULL, NULL, NULL, NULL);
    ERR();
    return program;
}

cl_kernel CreateKernel( cl_program* program, const char* kernel_name )
{
    cl_int err;
    
    // Create kernel from program
    cl_kernel kernel = clCreateKernel( *program, kernel_name, &err );
    ERR();
    return kernel;
}

cl_mem CreateBuffer( cl_context* context, cl_int initial_copy_flag, size_t size, void* host_ptr )
{
    cl_int err;
    cl_mem_flags flag;

    // If there's data to be copied to buffer, use USE_HOST_PTR; otherwise, use ALLOC_HOST_PTR
    initial_copy_flag ? flag = CL_MEM_USE_HOST_PTR : flag = CL_MEM_ALLOC_HOST_PTR;

    // Create buffer
    cl_mem buffer = clCreateBuffer( *context, flag, size, host_ptr, &err );
    ERR();
    return buffer;
}

void SetKernelArg( cl_kernel* kernel, cl_uint arg_index, size_t arg_size, const void* arg_value )
{
    cl_int err;

    // Set kernel argument
    err = clSetKernelArg( *kernel, arg_index, arg_size, arg_value );
    ERR();
}

void* QuickMap( cl_command_queue* queue, cl_mem* buffer, cl_uint map_flag, size_t cb )
{
    cl_int err;
    cl_map_flags flag;

    // Set map flag
    map_flag == 1 ? flag = CL_MAP_READ : flag = CL_MAP_WRITE;

    // Enqueue map buffer
    void* ptr = clEnqueueMapBuffer( *queue, *buffer, CL_TRUE, flag, 0, cb, 0, NULL, NULL, &err );
    ERR();
    return ptr;
}

void QuickUnmap( cl_command_queue* queue, cl_mem* buffer, void* mapped_ptr )
{
    cl_int err;
    
    // Enqueue unmap by pointer
    err = clEnqueueUnmapMemObject( *queue, *buffer, mapped_ptr, 0, NULL, NULL );
    ERR();
}

void EnqueueKernel( cl_command_queue* queue, cl_kernel* kernel, cl_uint work_dim, const size_t* global_work_size )
{
    cl_int err;
    cl_event event;
    double time_start, time_end;

    // Enqueue kernel with profiling, without local work size assignment
    err = clEnqueueNDRangeKernel( *queue, *kernel, work_dim, NULL, global_work_size, NULL, 0, NULL, &event);
    ERR();

    // Blocking until the event is returned for profiling
    err = clWaitForEvents(1, &event);
    ERR();

    // Get profiled start time and end time of kernel
    err = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(time_start), &time_start, NULL);
    ERR();
    err = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(time_end), &time_end, NULL);
    ERR();
    double elapsed = time_end - time_start;
    std::cout << "Kernel execution time: " << elapsed/1000000.0 << " ms" <<std::endl;
}

// General OpenCL object release template specialization
template <typename T>
void ReleaseCL(T t)
{
}

template <>
void ReleaseCL( cl_context* context)
{
    cl_int err = clReleaseContext( *context );
    ERR();
}

template <>
void ReleaseCL( cl_program* program)
{
    cl_int err = clReleaseProgram( *program );
    ERR();
}

template <>
void ReleaseCL( cl_kernel* kernel)
{
    cl_int err = clReleaseKernel( *kernel );
    ERR();
}

template <>
void ReleaseCL( cl_command_queue* queue)
{
    cl_int err = clReleaseCommandQueue( *queue );
    ERR();
}

template <>
void ReleaseCL( cl_mem* buffer)
{
    cl_int err = clReleaseMemObject( *buffer );
    ERR();
}

int main(int argc, char* argv[])
{
    typedef float Numeric_Type;

    // Create host vectors
    cl_uint vector_size = 10000000;
    std::vector<Numeric_Type> vector_a( vector_size, 10 );
    std::vector<Numeric_Type> vector_b( vector_size, 32 );
    std::vector<Numeric_Type> vector_res( vector_size, 0 ) ;
    std::vector<Numeric_Type> vector_val( vector_size, 42 ) ;

    size_t global_work_size = 1000;

    #ifdef OCL_CXX
    std::string version = "OpenCL C++";
    #else
    std::string version = "OpenCL C";
    #endif
    std::string kernel_name = "float_vector_add";

    // Create context and command queue
    cl_context context = CreateContextForDefaultDevice();
    cl_command_queue queue = CreateCommandQueue( &context );

    // Either create OpenCL C++ program or OpenCL C program
    // For host code, this is the only difference for OCL C and C++
    #ifdef OCL_CXX
    cl_program program = CreateProgramWithIL( &context, "kernels/cpp_vector_add.spv" );
    #else
    cl_program program = CreateProgramWithSource( &context, "kernels/vector_add.cl" );
    #endif

    // Display information
    std::cout << "=============================================" << std::endl;
    std::cout << "Testing " << version << " kernel: " << kernel_name << std::endl;
    std::cout << "Vector size: " << vector_size << std::endl;
    std::cout << "Global work size: " << global_work_size <<std::endl;

    // Create kernel by program and function name
    cl_kernel kernel = CreateKernel( &program, kernel_name.c_str() );

    // arg2 = 1 if there is data to be copied to buffer
    cl_mem cl_a = CreateBuffer( &context, 1, sizeof(Numeric_Type) * vector_size, vector_a.data() );
    cl_mem cl_b = CreateBuffer( &context, 1, sizeof(Numeric_Type) * vector_size, vector_b.data() );
    cl_mem cl_res = CreateBuffer ( &context, 0, sizeof(Numeric_Type) * vector_size, NULL );

    // Set kernel arguments
    SetKernelArg( &kernel, 0, sizeof(cl_mem), &cl_a );
    SetKernelArg( &kernel, 1, sizeof(cl_mem), &cl_b );
    SetKernelArg( &kernel, 2, sizeof(cl_mem), &cl_res );
    SetKernelArg( &kernel, 3, sizeof(cl_uint), &vector_size );

    // Map buffer, copy host vector to mapped pointer, unmap to sync with device
    Numeric_Type* map_ptr_a = (Numeric_Type*)QuickMap( &queue, &cl_a, 1, sizeof(Numeric_Type) * vector_size );
    Numeric_Type* map_ptr_b = (Numeric_Type*)QuickMap( &queue, &cl_b, 1, sizeof(Numeric_Type) * vector_size );
    memcpy( map_ptr_a, vector_a.data(), sizeof(Numeric_Type) * vector_size );
    memcpy( map_ptr_b, vector_b.data(), sizeof(Numeric_Type) * vector_size );
    QuickUnmap( &queue, &cl_a, map_ptr_a );
    QuickUnmap( &queue, &cl_b, map_ptr_b );

    // Enqueue kernel and wait for execution
    EnqueueKernel( &queue, &kernel, 1, &global_work_size );

    // Map buffer, copy mapped pointer back to host vector, then unmap
    Numeric_Type* map_ptr_res = (Numeric_Type*)QuickMap( &queue, &cl_res, 0, sizeof(Numeric_Type) * vector_size );
    memcpy( vector_res.data(), map_ptr_res, sizeof(Numeric_Type) * vector_size );
    QuickUnmap( &queue, &cl_res, map_ptr_res );

    // Release OpenCL objects
    ReleaseCL( kernel );
    ReleaseCL( program );
    ReleaseCL( cl_a );
    ReleaseCL( cl_b );
    ReleaseCL( cl_res );
    ReleaseCL( queue );
    ReleaseCL( context );

    int flag = 0;
    for ( auto it = vector_res.begin(); it != vector_res.end(); ++it )
    {
        if ( abs( *it - 42 ) > 1e-4 )
        {
            flag = 1;
            break;
        }
    }
    flag == 0 ? std::cout << "SUCCESS\n" : std::cout << "FAILURE\n";

    return 0;
}
