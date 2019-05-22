include_directories(SYSTEM
  /usr/include
)

set(ARCH_FLAGS "-O2 -march=armv8-a+crc -mcpu=cortex-a73 -mtune=cortex-a73.cortex-a53 -ftree-vectorize -funsafe-math-optimizations -pipe")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ARCH_FLAGS}"  CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)

set(ARM64 ON)
set(HEADLESS OFF)
set(SIMULATOR OFF)
set(UNITTEST OFF)
set(USE_DISCORD OFF)
set(USE_FFMPEG OFF)
set(USE_SYSTEM_FFMPEG ON)
set(USE_WAYLAND_WSI OFF)
set(USING_EGL ON)
set(USING_FBDEV ON)
set(USING_GLES2 ON)
set(USING_QT_UI OFF)
set(USING_X11_VULKAN OFF CACHE BOOL "" FORCE)
set(VULKAN OFF)
