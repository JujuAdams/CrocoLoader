/// @param vertexBuffer
/// @param textureIndex

function __CrocClassIndexedVertexBuffer(_vertexBuffer, _textureIndex) constructor
{
    __vertexBuffer = _vertexBuffer;
    __textureIndex = _textureIndex;
    
    static __Submit = function(_modelArray)
    {
        vertex_submit(__vertexBuffer, pr_trianglelist, sprite_get_texture(_modelArray[__textureIndex].textureSprite, 0));
    }
    
    static __Destroy = function()
    {
        if (vertex_buffer_exists(__vertexBuffer))
        {
            vertex_delete_buffer(__vertexBuffer);
            __vertexBuffer = -1;
        }
        
        __textureIndex = undefined;
    }
    
    static __Freeze = function()
    {
        vertex_freeze(__vertexBuffer);
    }
    
    static __Squash = function(_outputVertexBufferMap, _outputVertexBufferArray, _modelArray)
    {
        var _outputVertexBufferData = _outputVertexBufferMap[? __textureIndex];
        if (_outputVertexBufferData == undefined)
        {
            var _outputVertexBufferData = new __CrocClassVertexBuffer(vertex_create_buffer(), _modelArray[__textureIndex].textureSprite);
            array_push(_outputVertexBufferArray, _outputVertexBufferData);
            _outputVertexBufferMap[? __textureIndex] = _outputVertexBufferData;
        }
        
        vertex_update_buffer_from_vertex(_outputVertexBufferData.vertexBuffer, 24*vertex_get_number(_outputVertexBufferData.vertexBuffer), __vertexBuffer, 0, vertex_get_number(__vertexBuffer));
    }
    
    static __SquashWithMatrix = function(_outputVertexBufferMap, _outputVertexBufferArray, _modelArray, _matrix)
    {
        var _outputVertexBufferData = _outputVertexBufferMap[? __textureIndex];
        if (_outputVertexBufferData == undefined)
        {
            var _outputVertexBufferData = new __CrocClassVertexBuffer(vertex_create_buffer(), _modelArray[__textureIndex].textureSprite);
            array_push(_outputVertexBufferArray, _outputVertexBufferData);
            _outputVertexBufferMap[? __textureIndex] = _outputVertexBufferData;
        }
        
        var _buffer = buffer_create_from_vertex_buffer(__vertexBuffer, buffer_fixed, 1);
        var _stride = buffer_get_size(_buffer) / vertex_get_number(__vertexBuffer);
        
        var _vertex = [0, 0, 0, 1];
        var _pos = 0;
        repeat(vertex_get_number(__vertexBuffer))
        {
            var _x = buffer_peek(_buffer, _pos,   buffer_f32);
            var _y = buffer_peek(_buffer, _pos+4, buffer_f32);
            var _z = buffer_peek(_buffer, _pos+8, buffer_f32);
            
            matrix_transform_vertex(_matrix, _x, _y, _z, 1, _vertex);
            
            buffer_poke(_buffer, _pos,   buffer_f32, _vertex[0]);
            buffer_poke(_buffer, _pos+4, buffer_f32, _vertex[1]);
            buffer_poke(_buffer, _pos+8, buffer_f32, _vertex[2]);
            
            _pos += _stride;
        }
        
        vertex_update_buffer_from_buffer(_outputVertexBufferData.vertexBuffer, 24*vertex_get_number(_outputVertexBufferData.vertexBuffer), _buffer, 0, buffer_get_size(_buffer));
        
        buffer_delete(_buffer);
    }
}