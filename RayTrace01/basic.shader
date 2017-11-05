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

float noise01(vec2 P)
{
    float sinx = sin(P.x * 3.1415);
    //float siny = sin(P.y * 2.1415);
    return sinx;
}

void main()
{
    vec2 uv = inData.v_texcoord;
    fragColor = vec4(uv.x,uv.y,1-uv.y*uv.y,1) + noise01(uv) * spectrum.x * 200;
}
