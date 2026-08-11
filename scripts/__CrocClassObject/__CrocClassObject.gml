function __CrocClassObject() constructor
{
    type = undefined;
    num  = undefined;
    name = undefined;
    
    instanceArray = [];
    pointArray = [];
    pointDict = {};
    
    vertexBufferArray = [];
    
    
    
    static __Destroy = function()
    {
        var _i = 0;
        repeat(array_length(vertexBufferArray))
        {
            vertexBufferArray[_i].__Destroy();
            ++_i;
        }
        
        array_resize(vertexBufferArray, 0);
        
        return self;
    }
    
    static __Deserialize = function(_inputStruct)
    {
        type = _inputStruct[$ "type"];
        num  = _inputStruct[$ "num" ];
        name = _inputStruct[$ "name"];
        
        var _pointArray = _inputStruct[$ "points"];
        if (is_array(_pointArray))
        {
            var _i = 0;
            repeat(array_length(_pointArray))
            {
                var _point = (new __CrocClassPoint()).__Deserialize(_pointArray[_i]);
                
                array_push(pointArray, _point);
                pointDict[$ _point.name] = _point;
                
                ++_i;
            }
        }
        
        var _instanceArray = _inputStruct[$ "instances"];
        if (is_array(_instanceArray))
        {
            var _i = 0;
            repeat(array_length(_instanceArray))
            {
                array_push(instanceArray, (new __CrocClassInstance()).__Deserialize(_instanceArray[_i]));
                ++_i;
            }
        }
        
        if (struct_exists(_inputStruct, "object"))
        {
            __CrocDeserializeVertexBuffers(_inputStruct.object, vertexBufferArray, pointDict[$ "Origin"], undefined);
        }
        
        return self;
    }
    
    static __Submit = function(_modelArray)
    {
        var _i = 0;
        repeat(array_length(instanceArray))
        {
            instanceArray[_i].__Submit(vertexBufferArray, _modelArray);
            ++_i;
        }
    }
    
    static __Freeze = function()
    {
        var _i = 0;
        repeat(array_length(vertexBufferArray))
        {
            vertexBufferArray[_i].__Freeze();
            ++_i;
        }
    }
    
    static __Squash = function(_outputVertexBufferMap, _outputVertexBufferArray, _modelArray)
    {
        var _i = 0;
        repeat(array_length(instanceArray))
        {
            instanceArray[_i].__Squash(_outputVertexBufferMap, _outputVertexBufferArray, _modelArray, vertexBufferArray);
            ++_i;
        }
    }
}