function __CrocClassPoint() constructor
{
    name = undefined;
    
    x = undefined;
    y = undefined;
    z = undefined;
    
    
    
    static __Deserialize = function(_inputStruct)
    {
        name = _inputStruct.name;
        
        with(_inputStruct.pos)
        {
            other.x = x;
            other.y = y;
            other.z = z;
        }
        
        return self;
    }
}