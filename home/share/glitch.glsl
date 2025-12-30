// Published at: https://www.shadertoy.com/view/WfVfDh

const float PI = 3.14159265359;

/*      For visual explanation of the paramters, see      */
/*      https://www.desmos.com/calculator/vezu1wyqma      */

float PERI = 3.;  // Period        How often a glitch occurs  (in seconds)  0–?
float DURA = .33; // Duration      How long a glitch lasts    (in seconds)  0–Period
float AMPL = .15; // Amplitude     How intense a glitch is                  0–1
float SCRA = .2;  // Scratchiness  How jittery a glitch is                  0–1

float random2d(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float randomRange(in vec2 seed, in float lo, in float hi) {
    return lo + random2d(seed) * (hi - lo);
}

float insideRange(float v, float bottom, float top) {
    return step(bottom, v) - step(top, v);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    float time = floor(iTime * SCRA * 60.);
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Periodic intermittence
    AMPL *= cos(2. * PI * max(0., (mod(-iTime / PERI, 1.) - 1.) * PERI / DURA + 1.)) * -.5 + .5;

    vec3 outCol = texture(iChannel0, uv).rgb;

    // Randomly offset slices horizontally
    float offsetMax = AMPL / 2.;
    for (float i = 0.; i < 10. * AMPL; i += 1.) {
        float sliceY =  random2d(vec2(time, 2345. + float(i)));
        float sliceH =  random2d(vec2(time, 9035. + float(i))) * .25;
        float offsetH = randomRange(vec2(time, 9625. + float(i)), -offsetMax, offsetMax);
        vec2 uvOff = uv;
        uvOff.x += offsetH;
        if (insideRange(uv.y, sliceY, fract(sliceY + sliceH)) == 1.) {
            outCol = texture(iChannel0, uvOff).rgb;
        }
    }

    // Slightly offset one entire channel
    offsetMax = AMPL / 6.;
    vec2 colOff = vec2(
        randomRange(vec2(time, 9545.), -offsetMax, offsetMax),
        randomRange(vec2(time, 7205.), -offsetMax, offsetMax)
    );
    float rnd = random2d(vec2(time, 9545.));
    if      (rnd < .33) outCol.r = texture(iChannel0, uv + colOff).r;
    else if (rnd < .66) outCol.g = texture(iChannel0, uv + colOff).g;
    else                outCol.b = texture(iChannel0, uv + colOff).b;

    fragColor = vec4(outCol, 1.);
}
