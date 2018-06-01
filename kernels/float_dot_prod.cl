__kernel void float_dot_prod(__global const float* a, __global const float* b, __global float* result, const uint vector_size, __local float* local_sum)
{
    uint gid = get_global_id(0);
    uint lid = get_local_id(0);
    uint l_size = get_local_size(0);

    local_sum[lid] = a[gid] * b[gid];
    barrier(CLK_LOCAL_MEM_FENCE);

    for ( uint i = l_size >> 1; i > 0; i >>= 1)
    {
        if (lid < i)
            local_sum[lid] += local_sum[lid+i];
        barrier(CLK_LOCAL_MEM_FENCE);
    } 
    
    if (lid == 0)
        result[get_group_id(0)] = local_sum[0];
}
