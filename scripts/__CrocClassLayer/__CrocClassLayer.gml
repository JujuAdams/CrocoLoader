function __CrocClassLayer() constructor
{
    type = undefined;
    num  = undefined;
    name = undefined;
    
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
        type = _inputStruct[$ "type"];
        num  = _inputStruct[$ "num" ];
        name = _inputStruct[$ "name"];
        
        __CrocDeserializeObject(objectArray, _inputStruct[$ "object"]);
        
        return self;
    }
    
    static __Submit = function(_modelArray)
    {
        var _i = 0;
        repeat(array_length(objectArray))
        {
            objectArray[_i].__Submit(_modelArray);
            ++_i;
        }
    }
}