function __CrocClassInstance() constructor
{
    x = 0;
    y = 0;
    z = 0;
    
    xRotation = 0;
    yRotation = 0;
    zRotation = 0;
    
    order = undefined;
    
    matrix = matrix_build_identity();
    
    
    
    static __Deserialize = function(_inputStruct)
    {
        with(_inputStruct.position)
        {
            other.x = x;
            other.y = y;
            other.z = z;
        }
        
        with(_inputStruct.rotation)
        {
            other.xRotation = radtodeg(_x); //Weird variable names
            other.yRotation = radtodeg(_y);
            other.zRotation = radtodeg(_z);
            other.order     = struct_get(self, "order");
        }
        
        matrix = matrix_build(x, y, z,   xRotation, yRotation, zRotation,   1, 1, 1);
        
        return self;
    }
    
    static __Submit = function(_vertexBufferArray, _textureIndexArray, _modelArray)
    {
        var _oldMatrix = matrix_get(matrix_world);
        var _matrix = matrix_multiply(matrix, _oldMatrix);
        matrix_set(matrix_world, _matrix);
        
        var _i = 0;
        repeat(array_length(_vertexBufferArray))
        {
            var _textureIndex = _textureIndexArray[_i];
            if (is_numeric(_textureIndex))
            {
                vertex_submit(_vertexBufferArray[_i], pr_trianglelist, sprite_get_texture(_modelArray[_textureIndex].textureSprite, 0));
            }
            
            ++_i;
        }
        
        matrix_set(matrix_world, _oldMatrix);
    }
}