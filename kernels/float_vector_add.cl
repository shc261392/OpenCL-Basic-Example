__kernel void float_vector_add(__global const float* a, __global const float* b, __global float* result, const uint vector_size)
{
    for (uint idx = get_global_id(0); idx < vector_size; idx += get_global_size(0))
    {
        result[idx] = a[idx] + b[idx]; 
    }
}
