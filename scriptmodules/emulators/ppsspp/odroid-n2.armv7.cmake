include_directories(SYSTEM
  /usr/local/include
  /usr/include
)

set(ARCH_FLAGS "-O2  -march=armv8-a+crc -mcpu=cortex-a73 -mtune=cortex-a73.cortex-a53 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations -pipe")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ARCH_FLAGS}"  CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${ARCH_FLAGS}" CACHE STRING "" FORCE)

set(OPENGL_LIBRARIES GLESv2)
set(ARMV7 ON)
set(USING_GLES2 ON)
set(FORCED_CPU armv7)
set(USING_X11_VULKAN OFF CACHE BOOL "" FORCE)
set(USING_EGL OFF)
set(VULKAN OFF)
set(HEADLESS OFF)
set(USING_QT_UI OFF)
set(UNITTEST OFF)
set(USE_WAYLAND_WSI OFF)
set(USE_FFMPEG YES)
set(USE_SYSTEM_FFMPEG NO)
set(SIMULATOR OFF)
