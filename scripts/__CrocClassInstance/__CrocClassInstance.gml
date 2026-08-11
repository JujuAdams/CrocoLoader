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
            other.y = z; //Z-up
            other.z = y;
        }
        
        with(_inputStruct.rotation)
        {
            //Weird variable names
            other.xRotation = radtodeg(_x);
            other.yRotation = radtodeg(_z); //Z-up
            other.zRotation = radtodeg(_y);
            other.order     = struct_get(self, "order"); //TODO
        }
        
        matrix = matrix_build(x, y, z,   xRotation, yRotation, zRotation,   1, 1, 1);
        
        return self;
    }
    
    static __Submit = function(_vertexBufferArray, _modelArray)
    {
        var _oldMatrix = matrix_get(matrix_world); //TODO - Optimize
        var _matrix = matrix_multiply(matrix, _oldMatrix);
        matrix_set(matrix_world, _matrix);
        
        var _i = 0;
        repeat(array_length(_vertexBufferArray))
        {
            _vertexBufferArray[_i].__Submit(_modelArray);
            ++_i;
        }
        
        matrix_set(matrix_world, _oldMatrix);
    }
    
    static __Squash = function(_outputVertexBufferMap, _outputVertexBufferArray, _modelArray, _vertexBufferArray)
    {
        var _i = 0;
        repeat(array_length(_vertexBufferArray))
        {
            _vertexBufferArray[_i].__SquashWithMatrix(_outputVertexBufferMap, _outputVertexBufferArray, _modelArray, matrix);
            ++_i;
        }
    }
}