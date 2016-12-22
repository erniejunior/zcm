#include <zcm/zcm.h>
#include <zcm/server.h>
#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <signal.h>

static volatile int running = 1;
static void sighandler(int signo) { running = 0; }

int main(int argc, char *argv[])
{
    signal(SIGINT, sighandler);
    signal(SIGQUIT, sighandler);
    signal(SIGTERM, sighandler);

    zcm_server_t *svr = zcm_server_create("tcp://localhost:6700");
    assert(svr);

    while (running) {
        zcm_t *zcm = zcm_server_accept(svr, 500);
        if (zcm) {
            zcm_publish(zcm, "CHANNEL", "FOOBAR", 7);
            zcm_flush(zcm);
            zcm_destroy(zcm);
        }
    }

    printf("hui!\n");

    zcm_server_destroy(svr);
    return 0;
}