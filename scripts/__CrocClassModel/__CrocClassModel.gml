function __CrocClassModel() constructor
{
    textureSprite = -1;
    imageFile = undefined;
    vertexBuffer = undefined;
    
    vertexBufferArray = [];
    textureArray = [];
    
    
    
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
        
        if (vertex_buffer_exists(vertexBuffer))
        {
            vertex_delete_buffer(vertexBuffer);
            vertexBuffer = undefined;
        }
        
        return self;
    }
    
    static __Deserialize = function(_inputStruct)
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
            __CrocDeserializeVertexBuffers(_inputStruct.object, vertexBufferArray, textureArray, undefined);
        }
        
        return self;
    }
    
    static __Submit = function()
    {
        var _i = 0;
        repeat(array_length(vertexBufferArray))
        {
            vertex_submit(vertexBufferArray[_i], pr_trianglelist, sprite_get_texture(textureSprite, 0));
            ++_i;
        }
    }
}