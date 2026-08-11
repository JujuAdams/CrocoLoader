function __CrocClassSquashed() constructor
{
    vertexBufferDataArray = [];
    
    static Freeze = function()
    {
        var _i = 0;
        repeat(array_length(vertexBufferDataArray))
        {
            vertexBufferDataArray[_i].__Freeze();
            ++_i;
        }
        
        return self;
    }
    
    static Submit = function()
    {
        var _vertexBufferDataArray = vertexBufferDataArray;
        var _i = 0;
        repeat(array_length(_vertexBufferDataArray))
        {
            _vertexBufferDataArray[_i].Submit();
            ++_i;
        }
        
        return self;
    }
    
    static Destroy = function()
    {
        var _vertexBufferDataArray = vertexBufferDataArray;
        var _i = 0;
        repeat(array_length(_vertexBufferDataArray))
        {
            _vertexBufferDataArray[_i].__Destroy();
            ++_i;
        }
        
        array_resize(_vertexBufferDataArray, 0);
    }
}