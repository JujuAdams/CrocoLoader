function __CrocClassImageFile() constructor
{
    path = undefined;
    name = undefined;
    
    
    
    static __Destroy = function()
    {
        //Do nothing
        
        return self;
    }
    
    static __Deserialize = function(_inputStruct)
    {
        path = _inputStruct.path;
        name = _inputStruct.name;
        
        return self;
    }
}