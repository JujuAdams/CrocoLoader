var _oldTexFilter = gpu_get_tex_filter();
gpu_set_tex_filter(false);
gpu_set_alphatestenable(true);
matrix_set(matrix_world, matrix_build(0,0,0,   0,0,0,   32, 32, 32));

crocotile.Submit();

gpu_set_tex_filter(_oldTexFilter);
gpu_set_alphatestenable(false);
matrix_set(matrix_world, matrix_build_identity());