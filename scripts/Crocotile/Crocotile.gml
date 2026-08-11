function Crocotile() constructor
{
    config = undefined;
    modelArray = [];
    prefabArray = [];
    
    //TODO - Fetch tile palette, UV animation, "acts" (?!), misc
    
    
    static LoadFromFile = function(_path)
    {
        if (not file_exists(_path))
        {
            __CrocError($"\"{_path}\" does not exist");
        }
        
        var _buffer = buffer_load(_path);
        if (not buffer_exists(_buffer))
        {
            __CrocError($"Failed to load \"{_path}\"");
        }
        
        LoadFromString(buffer_read(_buffer, buffer_text));
        buffer_delete(_buffer);
        
        return self;
    }
    
    static LoadFromString = function(_string)
    {
        var _json = undefined;
        try
        {
            _json = json_parse(_string);
        }
        catch(_error)
        {
            show_debug_message(_error);
            __CrocError($"Failed to parse string");
        }
        
        Destroy();
        
        config = (new __CrocClassConfig()).__Deserialize(_json[$ "config"]);
        
        var _modelArray = _json[$ "model"];
        if (is_array(_modelArray))
        {
            var _i = 0;
            repeat(array_length(_modelArray))
            {
                array_push(modelArray, (new __CrocClassModel()).__Deserialize(_modelArray[_i], _i));
                ++_i;
            }
        }
        
        var _prefabArray = _json[$ "prefabs"];
        if (is_array(_prefabArray))
        {
            var _i = 0;
            repeat(array_length(_prefabArray))
            {
                __CrocDeserializeObject(prefabArray, _prefabArray[_i]);
                ++_i;
            }
        }
        
        return self;
    }
    
    static Submit = function()
    {
        var _modelArray = modelArray;
        
        var _i = 0;
        repeat(array_length(modelArray))
        {
            modelArray[_i].__Submit(_modelArray);
            ++_i;
        }
        
        var _i = 0;
        repeat(array_length(prefabArray))
        {
            prefabArray[_i].__Submit(_modelArray);
            ++_i;
        }
        
        return self;
    }
    
    static Freeze = function()
    {
        var _i = 0;
        repeat(array_length(modelArray))
        {
            modelArray[_i].__Freeze();
            ++_i;
        }
        
        var _i = 0;
        repeat(array_length(prefabArray))
        {
            prefabArray[_i].__Freeze();
            ++_i;
        }
        
        return self;
    }
    
    static Squash = function()
    {
        var _squashed = new __CrocClassSquashed();
        
        var _vertexBufferMap = ds_map_create();
        var _vertexBufferArray = _squashed.vertexBufferDataArray;
        
        var _i = 0;
        repeat(array_length(modelArray))
        {
            modelArray[_i].__Squash(_vertexBufferMap, _vertexBufferArray, modelArray);
            ++_i;
        }
        
        var _i = 0;
        repeat(array_length(prefabArray))
        {
            prefabArray[_i].__Squash(_vertexBufferMap, _vertexBufferArray, modelArray);
            ++_i;
        }
        
        var _i = 0;
        repeat(array_length(modelArray))
        {
            modelArray[_i].__ReleaseMemory();
            ++_i;
        }
        
        ds_map_destroy(_vertexBufferMap);
        
        Destroy();
        
        return _squashed;
    }
    
    static Destroy = function()
    {
        if (is_struct(config))
        {
            config.__Destroy();
            config = undefined;
        }
        
        var _i = 0;
        repeat(array_length(modelArray))
        {
            modelArray[_i].__Destroy();
            ++_i;
        }
        
        array_resize(modelArray, 0);
        
        var _i = 0;
        repeat(array_length(prefabArray))
        {
            prefabArray[_i].__Destroy();
            ++_i;
        }
        
        array_resize(prefabArray, 0);
    }
}