function __CrocDeserializeVertexBuffers(_inputArray, _vertexBufferArray, _textureArray, _originPoint)
{
    static _vertexFormat = (function()
    {
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_color();
        vertex_format_add_texcoord();
        return vertex_format_end();
    })();
    
    if (_originPoint == undefined)
    {
        var _xOrigin = 0;
        var _yOrigin = 0;
        var _zOrigin = 0;
    }
    else
    {
        var _xOrigin = _originPoint.x;
        var _yOrigin = _originPoint.y;
        var _zOrigin = _originPoint.z;
    }
    
    var _i = 0;
    repeat(array_length(_inputArray))
    {
        var _input = _inputArray[_i];
        
        var _texture = (_input[$ "texture"] ?? -1) + 1;
        if (_texture >= array_length(_vertexBufferArray))
        {
            _textureArray[@ _texture] = (_texture == 0)? undefined : _texture-1;
            
            var _vertexBuffer = vertex_create_buffer();
            vertex_begin(_vertexBuffer, _vertexFormat);
            _vertexBufferArray[@ _texture] = _vertexBuffer;
        }
        else
        {
            var _vertexBuffer = _vertexBufferArray[@ _texture];
        }
        
        with(_input.position)
        {
            var _xPos = x - _xOrigin;
            var _yPos = z - _yOrigin; //Z-up (the origin has already been corrected)
            var _zPos = y - _zOrigin;
        }
        
        var _vertexArray = _input.vertices;
        var _uvArray     = _input.uvs;
        
        var _faceArray = _input.faces;
        var _f = 0;
        repeat(array_length(_faceArray))
        {
            var _vertexOrderArray = _faceArray[_f];
            var _vertexUVArray    = _uvArray[_f];
            
            var _vertexA = _vertexOrderArray[0];
            var _vertexB = _vertexOrderArray[2]; //Reverse winding order
            var _vertexC = _vertexOrderArray[1];
            var _UVsA    = _vertexUVArray[0];
            var _UVsB    = _vertexUVArray[2]; //Reverse winding order
            var _UVsC    = _vertexUVArray[1];
            
            var _vertexPosA = _vertexArray[_vertexA];
            var _vertexPosB = _vertexArray[_vertexB];
            var _vertexPosC = _vertexArray[_vertexC];
            
            var _x0 = _xPos + _vertexPosA.x;
            var _y0 = _yPos + _vertexPosA.z; //Z-up
            var _z0 = _zPos + _vertexPosA.y;
            var _u0 = _UVsA.x;
            var _v0 = 1 - _UVsA.y;
            
            var _x1 = _xPos + _vertexPosB.x;
            var _y1 = _yPos + _vertexPosB.z; //Z-up
            var _z1 = _zPos + _vertexPosB.y;
            var _u1 = _UVsB.x;
            var _v1 = 1 - _UVsB.y;
            
            var _x2 = _xPos + _vertexPosC.x;
            var _y2 = _yPos + _vertexPosC.z; //Z-up
            var _z2 = _zPos + _vertexPosC.y;
            var _u2 = _UVsC.x;
            var _v2 = 1 - _UVsC.y;
            
            //What it should be:
            vertex_position_3d(_vertexBuffer, _x0, _y0, _z0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u2, _v2);
            
            ++_f;
        }
        
        ++_i;
    }
    
    var _i = array_length(_vertexBufferArray)-1;
    repeat(array_length(_vertexBufferArray))
    {
        var _vertexBuffer = _vertexBufferArray[_i];
        
        if (is_handle(_vertexBuffer) && vertex_buffer_exists(_vertexBuffer))
        {
            vertex_end(_vertexBuffer);
        }
        else
        {
            array_delete(_vertexBufferArray, _i, 1);
            array_delete(_textureArray, _i, 1);
        }
        
        --_i;
    }
}