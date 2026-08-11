function __CrocClassObject() constructor
{
    type = undefined;
    num  = undefined;
    name = undefined;
    
    instanceArray = [];
    pointArray = [];
    pointDict = {};
    
    vertexBufferArray = [];
    textureArray = [];
    
    
    
    static __Destroy = function()
    {
        if (is_struct(vertexBuffer))
        {
            vertexBuffer.__Destroy();
            vertexBuffer = undefined;
        }
        
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
        
        if (array_length(instanceArray) <= 0)
        {
            array_push(instanceArray, new __CrocClassInstance());
        }
        
        if (struct_exists(_inputStruct, "object"))
        {
            __CrocDeserializeVertexBuffers(_inputStruct.object, vertexBufferArray, textureArray, pointDict[$ "Origin"]);
        }
        
        return self;
    }
    
    static __Submit = function(_modelArray)
    {
        var _i = 0;
        repeat(array_length(instanceArray))
        {
            instanceArray[_i].__Submit(vertexBufferArray, textureArray, _modelArray);
            ++_i;
        }
    }
}