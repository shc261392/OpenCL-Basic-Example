#include <opencl_memory>
#include <opencl_work_item>

using namespace cl;

kernel void float_vector_add(global_ptr<float[]> a, global_ptr<float[]> b, global_ptr<float[]> result, uint vector_size)
{
    for (uint idx = get_global_id(0); idx < vector_size; idx += get_global_size(0))
    {
        result[idx] = a[idx] + b[idx]; 
    }
}
