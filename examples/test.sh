#!/bin/sh

run()
{
    name=$1
    shift
    echo "\033[1m== Running: $name ==\033[0m"
    $@
    if [ "$?" != "0" ]; then
        echo "FAILED"
    fi
}

echo "This script is currently non-functional. If zcm built, it's probably working"

## Test type generation
# run   zcm-gen-test    ./scripts/test-gen.sh

## Test subscribe and unsubscribe
run   coretest        ./build/test/zcm/coretest
run   sub-unsub-c     ./build/test/zcm/sub_unsub_c
run   sub-unsub-cpp   ./build/test/zcm/sub_unsub_cpp
run   api-retcodes    ./build/test/zcm/api_retcodes
run   dispatch-loop   ./build/test/zcm/dispatch_loop
run   forking         ./build/test/zcm/forking
run   forking2        ./build/test/zcm/forking2
run   flushing        ./build/test/zcm/flushing
run   logging         ./build/test/zcm/logtest
run   trackers        ./build/test/zcm/trackers
