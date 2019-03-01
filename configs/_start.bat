rem set GPU_FORCE_64BIT_PTR=1
rem set GPU_MAX_HEAP_SIZE=100
rem set GPU_USE_SYNC_OBJECTS=1
rem set GPU_MAX_ALLOC_PERCENT=100
rem set GPU_SINGLE_ALLOC_PERCENT=100

amdadl_util.exe 0 130000 200000 900 950 70 85 55
amdadl_util.exe 1 130000 200000 900 950 70 85 55
rem amdadl_util.exe 2 100000 200000 850 950 70 99 60

::-cclock 1366
::-cvddc 980,1000
::-mclock 2000,2050
::-mvddc 980,1000
::-tt -72,-55

xmr-stak.exe