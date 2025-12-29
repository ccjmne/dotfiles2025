// Published at: https://www.shadertoy.com/view/WfVfDh

const float PI = 3.14159265359;

float AMPL = 0.15; // 0–1  Amplitude     How intense a glitch is
float SCRA = 0.2;  // 0–1  Scratchiness  How "jumpy" a glitch is
float PERI = 3.0;  // 0–?  Period        How often a glitch occurs (in seconds)
float DUTY = 0.15; // 0–1  Duty cycle    How much of that period is glitchy

float random2d(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float randomRange(in vec2 seed, in float min, in float max) {
    return min + random2d(seed) * (max - min);
}

float insideRange(float v, float bottom, float top) {
    return step(bottom, v) - step(top, v);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    float time = floor(iTime * SCRA * 60.0);
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Periodicity, see https://www.desmos.com/calculator/ygwb3sguu1
    AMPL *= sin(max(0.0, (mod(iTime / PERI, 1.0) - (1.0 - DUTY)) / DUTY) * 2.0 * PI - PI / 2.0) / 2.0 + 0.5;

    vec3 outCol = texture(iChannel0, uv).rgb;

    // Randomly offset slices horizontally
    float maxOffset = AMPL / 2.0;
    for (float i = 0.0; i < 10.0 * AMPL; i += 1.0) {
        float sliceY =  random2d(vec2(time, 2345.0 + float(i)));
        float sliceH =  random2d(vec2(time, 9035.0 + float(i))) * 0.25;
        float offsetH = randomRange(vec2(time, 9625.0 + float(i)), -maxOffset, maxOffset);
        vec2 uvOff = uv;
        uvOff.x += offsetH;
        if (insideRange(uv.y, sliceY, fract(sliceY + sliceH)) == 1.0) {
            outCol = texture(iChannel0, uvOff).rgb;
        }
    }

    // Slightly offset one entire channel
    float maxOffsetCol = AMPL / 6.0;
    float rnd = random2d(vec2(time, 9545.0));
    vec2 colOffset = vec2(
        randomRange(vec2(time, 9545.0), -maxOffsetCol, maxOffsetCol),
        randomRange(vec2(time, 7205.0), -maxOffsetCol, maxOffsetCol)
    );
    if      (rnd < 0.33) outCol.r = texture(iChannel0, uv + colOffset).r;
    else if (rnd < 0.66) outCol.g = texture(iChannel0, uv + colOffset).g;
    else                 outCol.b = texture(iChannel0, uv + colOffset).b;

    fragColor = vec4(outCol, 1.0);
}
