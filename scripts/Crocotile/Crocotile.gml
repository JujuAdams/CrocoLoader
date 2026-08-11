function Crocotile() constructor
{
    config = undefined;
    modelArray = [];
    prefabArray = [];
    
    
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
        
        __Clear();
        
        config = (new __CrocClassConfig()).__Deserialize(_json[$ "config"]);
        
        var _modelArray = _json[$ "model"];
        if (is_array(_modelArray))
        {
            var _i = 0;
            repeat(array_length(_modelArray))
            {
                array_push(modelArray, (new __CrocClassModel()).__Deserialize(_modelArray[_i]));
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
    }
    
    static Submit = function()
    {
        var _i = 0;
        repeat(array_length(modelArray))
        {
            modelArray[_i].__Submit();
            ++_i;
        }
        
        var _i = 0;
        repeat(array_length(prefabArray))
        {
            prefabArray[_i].__Submit(modelArray);
            ++_i;
        }
    }
    
    static __Clear = function()
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