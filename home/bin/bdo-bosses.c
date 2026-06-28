#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define TSLOTS_S (sizeof(SCHEDULE) / sizeof(SCHEDULE[0]))
#define SPAWNS_S (TSLOTS_S * 7)

typedef uint32_t timew; // seconds since start of week

typedef struct {
    const uint8_t h;       // Hour
    const uint8_t m;       // Minute
    const uint8_t b[7][2]; // Boss spawns across the week
} tslot;

typedef struct {
    timew         t;  // Time of week
    const uint8_t *b; // Bosses IDs
} spawn;

enum { NONE, BKSH, BGSL, GMTH, GPKG, KRND, KTUM, KZRK, MRKA, NVER, OFFN, QINT, SNGN, UTRI, VELL };
static const char *const B[] = {
    [BKSH] = "Black Shadow",    [BGSL] = "Bulgasal", [GMTH] = "Garmoth",
    [GPKG] = "Golden Pig King", [KRND] = "Karanda",  [KTUM] = "Kutum",
    [KZRK] = "Kzarka",          [MRKA] = "Muraka",   [NVER] = "Nouver",
    [OFFN] = "Offin",           [QINT] = "Quint",    [SNGN] = "Sangoon",
    [UTRI] = "Uturi",           [VELL] = "Vell",
};

static const tslot SCHEDULE[] = {
    //              MONDAY          TUESDAY        WEDNESDAY       THURSDAY         FRIDAY         SATURDAY         SUNDAY
    { 00, 15, { { UTRI, KTUM }, { SNGN, KRND }, { GPKG, KZRK }, { UTRI, NVER }, { GPKG, KRND }, { BGSL, KZRK }, { BGSL, NVER } } },
    { 02, 00, { { SNGN, KRND }, {            }, {            }, { GPKG, KZRK }, { BGSL, NVER }, { UTRI, OFFN }, { GPKG, KTUM } } },
    { 12, 00, { { SNGN, NVER }, { BGSL, KTUM }, { SNGN, KRND }, {            }, { UTRI, KTUM }, { GPKG, NVER }, { UTRI, KZRK } } },
    { 14, 00, { { GMTH       }, { GMTH       }, { GMTH       }, { GMTH       }, { GMTH       }, { GMTH       }, { GMTH       } } },
    { 16, 00, { { UTRI, KTUM }, { GPKG, NVER }, { BGSL, OFFN }, { SNGN, KRND }, { BGSL, KZRK }, { BKSH       }, { VELL       } } },
    { 19, 00, { { GPKG, NVER }, { UTRI, KZRK }, { VELL       }, { BGSL, KTUM }, { SNGN, OFFN }, { SNGN, KRND }, {            } } },
    { 19, 15, { {            }, {            }, {            }, {            }, {            }, {            }, { GMTH       } } },
    { 22, 15, { { BGSL, KZRK }, { QINT, MRKA }, { UTRI, NVER }, { QINT, MRKA }, { GPKG, KTUM }, {            }, { SNGN, KRND } } },
    { 23, 15, { { GMTH       }, { GMTH       }, { GMTH       }, { GMTH       }, { GMTH       }, {            }, { GMTH       } } },
};

static spawn SPAWNS[SPAWNS_S];

timew norm(const int d, const int h, const int m, const int s) {
    return 86400 * d + 3600 * h + 60 * m + s;
}

timew now(void) {
    const time_t           t = time(NULL);
    const struct tm *const l = localtime(&t);
    return norm((l->tm_wday + 6) % 7, l->tm_hour, l->tm_min, l->tm_sec);
}

spawn extract(const tslot *const s, const uint8_t d) {
    return (spawn) { norm(d, s->h, s->m, 0), s->b[d] };
}
spawn next(const timew t) { // previous if <5m ago, next otherwise
    for (uint8_t i = 0; i < SPAWNS_S; i++)
        if (SPAWNS[i].b[0] && SPAWNS[i].t > t - 300) return SPAWNS[i];
    return (spawn){ SPAWNS[0].t + 604800, SPAWNS[0].b };
}

const char *pretty(const uint32_t dur) {
    static char buf[16];
    const uint8_t h = dur / 3600, m = dur % 3600 / 60, s = dur % 60;
    if      (h > 0) snprintf(buf, sizeof buf, "%dh %dm %ds", h, m, s);
    else if (m > 0) snprintf(buf, sizeof buf, "%dm %ds",     m, s);
    else            snprintf(buf, sizeof buf, "%ds",         s);
    return buf;
}

void run(const timew t) {
    const spawn   s  = next(t);
    const int32_t dt = s.t - t;
    printf("{\"text\":\"");
    printf("%s%s%s ", B[s.b[0]], s.b[1] ? ", " : "", s.b[1] ? B[s.b[1]] : "");
    printf(s.t < t ? "%s ago" : "in %s", pretty(abs(dt)));
    printf("\",\"class\":\"%s\"}\n", dt > 0 && dt < 300 ? "imminent" : "");
    fflush(stdout);
}

int main(void) {
    for (uint8_t s = 0; s < TSLOTS_S; s++)
        for (uint8_t d = 0; d < 7; d++)
            SPAWNS[d * TSLOTS_S + s] = extract(&SCHEDULE[s], d);
    for (;; sleep(1)) run(now());
}
