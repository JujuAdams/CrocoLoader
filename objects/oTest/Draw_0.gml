gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_noculling);
gpu_set_alphatestenable(true);

matrix_set(matrix_world, matrix_build(640, 360, 0,   20, current_time/50, 0,   -50, -50, 1));
crocotile.Submit();
matrix_set(matrix_world, matrix_build_identity());

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);