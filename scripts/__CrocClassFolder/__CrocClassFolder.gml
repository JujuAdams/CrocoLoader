function __CrocClassFolder() constructor
{
    type    = undefined;
    name    = undefined;
    visible = undefined;
    
    objectArray = [];
    
    
    
    static __Destroy = function()
    {
        var _i = 0;
        repeat(array_length(objectArray))
        {
            objectArray[_i].__Destroy();
            ++_i;
        }
        
        array_resize(objectArray, 0);
        
        return self;
    }
    
    static __Deserialize = function(_inputStruct)
    {
        type    = _inputStruct[$ "type"   ];
        name    = _inputStruct[$ "name"   ];
        visible = _inputStruct[$ "visible"] ?? true;
        
        __CrocDeserializeObject(objectArray, _inputStruct[$ "content"]);
        
        return self;
    }
    
    static __Submit = function(_modelArray)
    {
        if (not visible) return;
        
        var _i = 0;
        repeat(array_length(objectArray))
        {
            objectArray[_i].__Submit(_modelArray);
            ++_i;
        }
    }
    
    static __Freeze = function()
    {
        var _i = 0;
        repeat(array_length(objectArray))
        {
            objectArray[_i].__Freeze();
            ++_i;
        }
    }
    
    static __Squash = function(_vertexBufferMap, _vertexBufferArray, _modelArray)
    {
        if (not visible) return;
        
        var _i = 0;
        repeat(array_length(objectArray))
        {
            objectArray[_i].__Squash(_vertexBufferMap, _vertexBufferArray, _modelArray);
            ++_i;
        }
    }
}