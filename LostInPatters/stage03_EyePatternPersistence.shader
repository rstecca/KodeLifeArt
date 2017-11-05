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

float pattern01(vec2 p, float distosion)
{
    float pmx = mod(p.x, 1000.0);
    return sin(pmx + distosion*sin(p.y/distosion));
}

float pattern02(vec2 p, float distorsion)
{
    float pmy = mod(p.y, 1000.0);
    return sin(pmy + distorsion*sin(p.x/distorsion));
}

// Waffle noise
float pattern03(vec2 p, float distorsion)
{
    float pm = mod(p.x*p.y*0.33, 20.0);
    return  cos(time*pm*0.1) * sin(abs(cos(p.x*p.x+p.y*p.y)));
}

void main()
{
    float t = time * 0.1;
    vec2 coords = gl_FragCoord.xy + vec2(cos(time), sin(time) * 2.0); // sligtly move coordinates
    fragColor = vec4(pattern01(coords + cos(t)*5.0, 6.0 + sin(t)*0.05)) + pattern02(coords + sin(t)*5.0, 8+0.02*sin(t)) + 1+sin(time)*0.5;
    //fragColor = vec4(pattern03(coords, 1.0));
}
