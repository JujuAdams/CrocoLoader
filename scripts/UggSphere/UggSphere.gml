// Feather disable all

/// Draws at a sphere at the given coordinates.
/// 
/// @param x
/// @param y
/// @param z
/// @param radius
/// @param [color]
/// @param [wireframe]

function UggSphere(_x, _y, _z, _radius, _color = UGG_DEFAULT_DIFFUSE_COLOR, _wireframe = undefined)
{
    __UGG_GLOBAL
    __UGG_COLOR_UNIFORMS
    static _volumeSphere    = _global.__volumeSphere;
    static _wireframeSphere = _global.__wireframeSphere;
    static _nativeSphere    = _global.__nativeSphere;
    static _oldWorldMatrix  = matrix_build_identity();
    static _staticMatrix    = matrix_build_identity();
    static _newWorldMatrix  = matrix_build_identity();
    
    _staticMatrix[@  0] = _radius;
    _staticMatrix[@  5] = _radius;
    _staticMatrix[@ 10] = _radius;
    _staticMatrix[@ 12] = _x;
    _staticMatrix[@ 13] = _y;
    _staticMatrix[@ 14] = _z;
    
    matrix_get(matrix_world, _oldWorldMatrix);
    matrix_multiply(_staticMatrix, _oldWorldMatrix, _newWorldMatrix);
    matrix_set(matrix_world, _newWorldMatrix);
    
    if (_wireframe ?? __UGG_WIREFRAME)
    {
        __UGG_WIREFRAME_SHADER
        vertex_submit(_wireframeSphere, pr_linelist, -1);
    }
    else 
    {
        __UGG_VOLUME_SHADER
        vertex_submit(__UGG_USE_SHADERS? _volumeSphere : _nativeSphere, pr_trianglelist, -1);
    }
    
    __UGG_RESET_SHADER
    
    matrix_set(matrix_world, _oldWorldMatrix);
}