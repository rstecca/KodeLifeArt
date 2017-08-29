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

void main(void)
{
    float t = time * 0.1;
    vec2 uv = inData.v_texcoord;
    vec2 ncuv = 2.0 * (uv - vec2(0.5,0.5)); // normalized centered uvs
    
    vec2 fracs = vec2(ncuv.x*10 - floor(ncuv.x*10), ncuv.y*10 - floor(ncuv.y*10));

    fragColor = vec4(abs(sin(cos(t+3.*fracs.x)*2.*ncuv.x+t))*abs(cos(sin(t+2.*ncuv.x*fracs.y)*3.*ncuv.y+t)),
        0,
        spectrum.x * 100.,
        1.0);
}
