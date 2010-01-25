# CMake script to locate external libraries
#
# Using
#
#   USE_RLIB
#   USE_ZLIB
#   USE_CORE
#   USE_GSL

ASSERT_FOUNDMAP()

MESSAGE(STATUS,"FindMapLibraries.cmake")

# ---- Using libraries

IF(USE_RLIB)
  SET (USE_CORE TRUE)
  FIND_PACKAGE(RLibs)
ENDIF(USE_RLIB)

IF(USE_ZLIB)
  FIND_PACKAGE(ZLIB)
ENDIF(USE_ZLIB)

IF(USE_CORE)
  SET(_LIBCORENAME ${MAP_projectname}_core)
  SET(_LIBCOREPATH ${MAP_CLIBS_PATH}/${_LIBCORENAME})
  INCLUDE_DIRECTORIES(${_LIBCOREPATH}/include)
  SET(_LIBNAME ${_LIBCORENAME}-${MAP_VERSION})
  if(NOT BUILD_LIBS)
    # building from higher level and need to name/find core libs explicitly
    SET(_LINKLIB lib${_LIBNAME}.so)
    IF(CYGWIN)
      SET(_LINKLIB lib${_LIBNAME}.dll.a)
    ENDIF(CYGWIN)
    IF(APPLE)
      SET(_LINKLIB lib${_LIBNAME}.dylib)
    ENDIF(APPLE)
    message("Looking for ${_LINKLIB} in ${_LIBCOREPATH}")
    FIND_LIBRARY(CORE_LIBRARY NAMES ${_LINKLIB} HINTS ${_LIBCOREPATH}/build ${_LIBCOREPATH}/src)
    IF(NOT CORE_LIBRARY)
      FIND_LIBRARY(CORE_LIBRARY NAMES ${_LINKLIB} PATHS ${_LIBCOREPATH}/build ${_LIBCOREPATH}/src)
    ENDIF()
    message("Found ${CORE_LIBRARY}")
  else()
    IF(BLD_BIOLIB_CORE)  # set explicitly
      SET(CORE_LIBRARY ${_LIBNAME})
    ENDIF()
  endif()
  # UNSET(_LIBNAME)
  SET(_LIBNAME 'unknown')
  message("CORE_LIBRARY=${CORE_LIBRARY}")
ENDIF(USE_CORE)

IF(USE_RLIB)
  # handle the QUIETLY and REQUIRED arguments and set RLIBS_FOUND to TRUE if
  # all listed variables are TRUE
  INCLUDE(FindPackageHandleStandardArgs)
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(RLibs DEFAULT_MSG MAP_VERSION)
ENDIF(USE_RLIB)

IF(USE_GSL)
  SET(_LIBGSLNAME ${MAP_projectname}_gsl)
  SET(_LIBGSLPATH ${MAP_CLIBS_PATH}/${_LIBGSLNAME})
  SET(GSL_CONTRIB_PATH ${MAP_ROOT}/contrib/gsl)
  INCLUDE_DIRECTORIES(${GSL_CONTRIB_PATH})
  INCLUDE_DIRECTORIES(${_LIBGSLPATH}/src/gsl)
  if(NOT BUILD_LIBS)
    SET(_LIBNAME ${_LIBGSLNAME}-${MAP_VERSION})
    SET(_LINKLIB lib${_LIBNAME}.so)
    IF(CYGWIN)
      SET(_LINKLIB lib${_LIBNAME}.dll.a)
    ENDIF(CYGWIN)
    IF(APPLE)
      SET(_LINKLIB lib${_LIBNAME}.dylib)
    ENDIF(APPLE)
    message("Looking for ${_LINKLIB} in ${_LIBGSLPATH}")
    FIND_LIBRARY(GSL_LIBRARY NAMES ${_LINKLIB} HINTS ${_LIBGSLPATH}/build ${_LIBGSLPATH}/src)
    IF(NOT GSL_LIBRARY)
      FIND_LIBRARY(GSL_LIBRARY NAMES ${_LINKLIB} PATHS ${_LIBGSLPATH}/build ${_LIBGSLPATH}/src)
    ENDIF()
    message("Found ${GSL_LIBRARY}")
  else()
    SET(GSL_LIBRARY ${_LIBGSLNAME})
  endif()
  # UNSET(_LIBNAME)
  SET(_LIBGSLNAME 'unknown')
  message("GSL_LIBRARY=${GSL_LIBRARY}")
ENDIF(USE_GSL)

