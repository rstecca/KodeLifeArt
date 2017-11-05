#version 150

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
uniform vec3 spectrum;
uniform sampler2D texture0;
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform sampler2D texture3;
uniform sampler2D prevFrame;

in VertexData
{
    vec4 v_position;
    vec3 v_normal;
    vec2 v_texcoord;
} inData;

out vec4 fragColor;


vec3 rotateVec3(vec3 vv, vec3 euler)
{
    // 
    float a = euler.x;
    float b = euler.y;
    float c = euler.z;
    mat4 M = mat4(
            vec4(cos(b) * cos(c),  -sin(c),              sin(b),           0),
            vec4(sin(c),           cos(a) * cos(c),      -sin(a),          0),
            vec4(-sin(b),          sin(a),               cos(a) * cos(b),  0),
            vec4(0,0,0,1)
        );
    vec4 vv4 = vec4(vv.xyz, 1);
    vv4 = vv4 * M;
    return vv4.xyz;
}


void main()
{
    vec2 uv = inData.v_texcoord;
    vec3 p = vec3(uv.x * 2.0, uv.y * 2.0, 1.0); // pixel 3D position 
    vec3 ro = vec3(0,0,0); // ray origin
    vec3 ray = normalize(p-ro);
    ray = rotateVec3(ray, vec3(0,time,0));
    fragColor = vec4(uv.y,clamp(0.25 + ray.x*0.5,0,1),ray.x,1);
}
