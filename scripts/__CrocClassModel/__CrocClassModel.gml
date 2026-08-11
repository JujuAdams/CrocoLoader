function __CrocClassModel() constructor
{
    textureSprite = -1;
    imageFile = undefined;
    vertexBufferArray = [];
    
    
    
    static __Destroy = function()
    {
        if (sprite_exists(textureSprite))
        {
            sprite_delete(textureSprite);
            textureSprite = -1;
        }
        
        if (is_struct(imageFile))
        {
            imageFile.__Destroy();
            imageFile = undefined;
        }
        
        var _i = 0;
        repeat(array_length(vertexBufferArray))
        {
            vertexBufferArray[_i].__Destroy();
            ++_i;
        }
        
        array_resize(vertexBufferArray, 0);
        
        return self;
    }
    
    static __ReleaseMemory = function()
    {
        textureSprite = -1;
    }
    
    static __Deserialize = function(_inputStruct, _textureIndex)
    {
        if (struct_exists(_inputStruct, "texture"))
        {
            textureSprite = sprite_add(_inputStruct.texture, 0, false, false, 0, 0);
            if (not sprite_exists(textureSprite))
            {
                __CrocTrace("Warning! Failed load to texture sprite");
                textureSprite = -1;
            }
        }
        
        if (struct_exists(_inputStruct, "imgFile"))
        {
            imageFile = (new __CrocClassImageFile()).__Deserialize(_inputStruct.imgFile);
        }
        
        if (struct_exists(_inputStruct, "object"))
        {
            __CrocDeserializeVertexBuffers(_inputStruct.object, vertexBufferArray, undefined, _textureIndex);
        }
        
        return self;
    }
    
    static __Submit = function(_modelArray)
    {
        var _i = 0;
        repeat(array_length(vertexBufferArray))
        {
            vertexBufferArray[_i].__Submit(_modelArray);
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
        repeat(array_length(vertexBufferArray))
        {
            vertexBufferArray[_i].__Squash(_outputVertexBufferMap, _outputVertexBufferArray, _modelArray);
            ++_i;
        }
    }
}