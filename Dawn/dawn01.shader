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

const float PI = 3.141592653;

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
    float siny = sin(P.y * 3.1415);
    for(int i=0; i<3; i++)
    {
        sinx = sin(sinx * sinx * 1.2);
        siny = sin(siny * siny * 1.2);
    }
    return sinx+siny;
}

float atan2(float y, float x)
{
    return x == 0.0 ? sign(y)*PI/2 : atan(y, x);
}

vec2 polar(vec2 P)
{
    return vec2(
        atan2(P.y, P.x),
        sqrt(P.x*P.x + P.y*P.y));
}

vec2 ncuv(vec2 UV)
{
    return vec2(
        (UV.x-0.5)*(resolution.x/resolution.y),
        (UV.y-0.5));
}

void main()
{
    float dayTime = (sin(time*0.1));
    vec2 pol = polar(ncuv(inData.v_texcoord + vec2(0,0.5*dayTime)));
    pol.x += sin(time*0.25);
    pol.y += spectrum.x*100;// + spectrum.x*25*sin(pol.x*4*PI);
    vec2 uv = (ncuv(inData.v_texcoord)) * 1.5;
    fragColor = clamp(vec4(dayTime+uv.y-spectrum.x, dayTime+uv.y-spectrum.x-0.5, dayTime*(spectrum.x-uv.y), 1) + noise01(pol*10) * spectrum.x * 500, 0,1);
}
