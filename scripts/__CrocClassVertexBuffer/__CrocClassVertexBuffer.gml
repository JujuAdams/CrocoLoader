/// @param vertexBuffer
/// @param sprite

function __CrocClassVertexBuffer(_vertexBuffer, _sprite) constructor
{
    vertexBuffer = _vertexBuffer;
    sprite       = _sprite;
    texture      = sprite_get_texture(_sprite, 0);
    
    static Submit = function()
    {
        vertex_submit(vertexBuffer, pr_trianglelist, texture);
    }
    
    static __Freeze = function()
    {
        vertex_freeze(vertexBuffer);
    }
    
    static __Destroy = function()
    {
        if (vertex_buffer_exists(vertexBuffer))
        {
            vertex_delete_buffer(vertexBuffer);
            vertexBuffer = -1;
        }
        
        if (sprite_exists(sprite))
        {
            sprite_delete(sprite);
            sprite = -1;
        }
        
        texture = -1;
    }
}