function __CrocDeserializeObject(_destinationArray, _sourcePrefab)
{
    if (_sourcePrefab == undefined)
    {
        return;
    }
    
    if (is_array(_sourcePrefab))
    {
        var _i = 0;
        repeat(array_length(_sourcePrefab))
        {
            __CrocDeserializeObject(_destinationArray, _sourcePrefab[_i]);
            ++_i;
        }
        
        return;
    }
    
    var _type = _sourcePrefab[$ "type"];
    if (_type == "layer")
    {
        var _prefab = new __CrocClassLayer();
    }
    else if ((_type == "object") || (_type == undefined))
    {
        var _prefab = new __CrocClassObject();
    }
    
    array_push(_destinationArray, _prefab.__Deserialize(_sourcePrefab));
}