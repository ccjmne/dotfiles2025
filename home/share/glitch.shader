// Port of: https://www.shadertoy.com/view/WfVfDh

#define PI 3.14159265359

uniform float AMPL< // 0–1  Amplitude     How intense a glitch is
    string label       = "Amplitude";
    string widget_type = "slider";
    float minimum      = 0.0;
    float maximum      = 1.0;
    float step         = 0.01;
> = 0.15;

uniform float SCRA< // 0–1  Scratchiness  How "jumpy" a glitch is
    string label       = "Scratchiness";
    string widget_type = "slider";
    float minimum      = 0.0;
    float maximum      = 1.0;
    float step         = 0.01;
> = 0.2;

uniform float PERI< // 0–?  Period        How often a glitch occurs (in seconds)
    string label       = "Period";
    string widget_type = "slider";
    float minimum      = 1.0;
    float maximum      = 10.0;
    float step         = 1.0;
> = 3.0;

uniform float DUTY< // 0–1  Duty cycle    How much of that period is glitchy
    string label       = "Duty Cycle";
    string widget_type = "slider";
    float minimum      = 0.0;
    float maximum      = 1.0;
    float step         = 0.01;
> = 0.15;

float random2d(float2 n) {
    return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
}

float randomRange (in float2 seed, in float min, in float max) {
    return min + random2d(seed) * (max - min);
}

float insideRange(float v, float bottom, float top) {
    return step(bottom, v) - step(top, v);
}

float4 mainImage(VertData v_in): TARGET {
    float time = floor(elapsed_time * SCRA * 60.0);
    float2 uv = v_in.uv;

    // Periodicity, see https://www.desmos.com/calculator/ygwb3sguu1
    float AMP = AMPL * sin(max(0.0, (mod(iTime / PERI, 1.0) - (1.0 - DUTY)) / DUTY) * 2.0 * PI - PI / 2.0) / 2.0 + 0.5;

    float4 outCol = image.Sample(textureSampler, uv);

    // Randomly offset slices horizontally
    float maxOffset = AMP / 2.0;
    for (float i = 0.0; i < 10.0 * AMP; i += 1.0) {
        float sliceY = random2d(float2(time, 2345.0 + float(i)));
        float sliceH = random2d(float2(time, 9035.0 + float(i))) * 0.25;
        float offsetH = randomRange(float2(time, 9625.0 + float(i)), -maxOffset, maxOffset);
        float2 uvOff = uv;
        uvOff.x += offsetH;
        if (insideRange(uv.y, sliceY, frac(sliceY + sliceH)) == 1.0) {
            outCol = image.Sample(textureSampler, uvOff);
        }
    }

    // Slightly offset one entire channel
    float maxOffsetCol = AMP / 6.0;
    float rnd = random2d(float2(time , 9545.0));
    float2 colOffset = float2(
        randomRange(float2(time, 9545.0), -maxOffsetCol, maxOffsetCol),
        randomRange(float2(time, 7205.0), -maxOffsetCol, maxOffsetCol)
    );
    if      (rnd < 0.33) outCol.r = image.Sample(textureSampler, uv + colOffset).r;
    else if (rnd < 0.66) outCol.g = image.Sample(textureSampler, uv + colOffset).g;
    else                 outCol.b = image.Sample(textureSampler, uv + colOffset).b;

    return outCol;
}
