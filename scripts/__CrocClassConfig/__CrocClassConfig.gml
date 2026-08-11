function __CrocClassConfig() constructor
{
    tilesizeX    = undefined;
    tilesizeY    = undefined;
    gridRounding = undefined;
    
    skyboxSprite         = undefined;
    skyboxSphereSprite   = undefined;
    skyboxCylinderSprite = undefined;
    skyboxShape          = undefined;
    skyboxShow           = undefined;
    
    backgroundColor = undefined;
    baseUnit        = undefined;
    workingTime     = undefined;
    
    //TODO - Fetch more properties, including camera/effects/texel
    
    static __Destroy = function()
    {
        if (sprite_exists(skyboxSprite))
        {
            sprite_delete(skyboxSprite);
            skyboxSprite = -1;
        }
        
        if (sprite_exists(skyboxSphereSprite))
        {
            sprite_delete(skyboxSphereSprite);
            skyboxSphereSprite = -1;
        }
        
        if (sprite_exists(skyboxCylinderSprite))
        {
            sprite_delete(skyboxCylinderSprite);
            skyboxCylinderSprite = -1;
        }
        
        return self;
    }
    
    static __Deserialize = function(_inputStruct)
    {
        if (_inputStruct == undefined) return;
        
        tilesizeX    = _inputStruct[$ "tilesizeX"   ];
        tilesizeY    = _inputStruct[$ "tilesizeY"   ];
        gridRounding = _inputStruct[$ "gridRounding"];
        
        if (struct_exists(_inputStruct, "skybox"))
        {
            skyboxSprite = sprite_add(_inputStruct.skybox, 0, false, false, 0, 0);
            if (not sprite_exists(skyboxSprite))
            {
                __CrocTrace("Warning! Failed load to skybox sprite");
                skyboxSprite = -1;
            }
        }
        
        if (struct_exists(_inputStruct, "skyboxSphere"))
        {
            skyboxSphereSprite = sprite_add(_inputStruct.skyboxSphere, 0, false, false, 0, 0);
            if (not sprite_exists(skyboxSphereSprite))
            {
                __CrocTrace("Warning! Failed load to skybox sphere sprite");
                skyboxSphereSprite = -1;
            }
        }
        
        if (struct_exists(_inputStruct, "skyboxCylinder"))
        {
            skyboxCylinderSprite = sprite_add(_inputStruct.skyboxCylinder, 0, false, false, 0, 0);
            if (not sprite_exists(skyboxCylinderSprite))
            {
                __CrocTrace("Warning! Failed load to skybox cylinder sprite");
                skyboxCylinderSprite = -1;
            }
        }
        
        skyboxShape = _inputStruct[$ "skyboxShape"];
        skyboxShow  = _inputStruct[$ "showSkybox" ];
        
        backgroundColor = _inputStruct[$ "backgroundColor"];
        baseUnit        = _inputStruct[$ "baseUnit"       ];
        workingTime     = _inputStruct[$ "workingTime"    ];
        
        //TODO - Fetch more properties, including camera/effects/texel
        
        return self;
    }
}