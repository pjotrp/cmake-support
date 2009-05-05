# CMake script to locate external libraries 
#
# Using
#
#   USE_RLIB
#   USE_ZLIB
#   USE_CORE
#

# ---- Using libraries

IF(USE_RLIB)
  SET (USE_CORE TRUE)
  FIND_PACKAGE(RLibs)
ENDIF(USE_RLIB)

IF(USE_ZLIB)
  SET (USE_CORE TRUE)
  FIND_PACKAGE(ZLIB)
ENDIF(USE_ZLIB)

IF(USE_CORE)
  SET(_LIBCORENAME ${MAP_projectname}_core)
  SET(_LIBCOREPATH ${MAP_CLIBS_PATH}/${_LIBCORENAME})
  INCLUDE_DIRECTORIES(${_LIBCOREPATH}/include)
  if(NOT BUILD_LIBS)
    SET(_LIBNAME ${_LIBCORENAME}-${MAP_VERSION})
    SET(_LINKLIB lib${_LIBNAME}.so)
    IF(CYGWIN)
      SET(_LINKLIB lib${_LIBNAME}.dll.a)
    ENDIF(CYGWIN)
    message("Looking for ${_LINKLIB} in ${_LIBCOREPATH}")
    FIND_LIBRARY(CORE_LIBRARY NAMES ${_LINKLIB} HINTS ${_LIBCOREPATH}/build ${_LIBCOREPATH}/src)
    message("Found ${CORE_LIBRARY}")
  endif(NOT BUILD_LIBS)
  # UNSET(_LIBNAME)
  SET(_LIBNAME 'unknown')
ENDIF(USE_CORE)

IF(USE_RLIB)
  # handle the QUIETLY and REQUIRED arguments and set RLIBS_FOUND to TRUE if 
  # all listed variables are TRUE
  INCLUDE(FindPackageHandleStandardArgs)
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(RLibs DEFAULT_MSG MAP_VERSION)
ENDIF(USE_RLIB)


