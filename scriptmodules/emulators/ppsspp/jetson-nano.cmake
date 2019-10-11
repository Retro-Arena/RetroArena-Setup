include_directories(SYSTEM
  /usr/local/include
  /usr/include
)

set(ARCH_FLAGS "-O2 -march=armv8-a+crc -mcpu=cortex-a57 -mtune=cortex-a57 -ftree-vectorize -funsafe-math-optimizations -pipe")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)

set(ARM64 ON)
set(USING_X11_VULKAN ON CACHE BOOL "" FORCE)
set(VULKAN ON)
set(HEADLESS OFF)
set(UNITTEST OFF)
set(USE_FFMPEG YES)
set(USE_SYSTEM_FFMPEG NO)
