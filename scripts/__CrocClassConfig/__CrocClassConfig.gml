function __CrocClassConfig() constructor
{
    tilesizeX = undefined;
    tilesizeY = undefined;
    
    skyboxSprite = -1;
    
    static __Destroy = function()
    {
        if (sprite_exists(skyboxSprite))
        {
            sprite_delete(skyboxSprite);
            skyboxSprite = -1;
        }
        
        return self;
    }
    
    static __Deserialize = function(_inputStruct)
    {
        if (_inputStruct == undefined) return;
        
        tilesizeX = _inputStruct.tilesizeX;
        tilesizeY = _inputStruct.tilesizeY;
        
        if (struct_exists(_inputStruct, "skybox"))
        {
            skyboxSprite = sprite_add(_inputStruct.skybox, 0, false, false, 0, 0);
            if (not sprite_exists(skyboxSprite))
            {
                __CrocTrace("Warning! Failed load to skybox sprite");
                skyboxSprite = -1;
            }
        }
        
        return self;
    }
}