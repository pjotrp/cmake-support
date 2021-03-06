# CMake file for SWIG configuration
#
# Using
#
#   USE_LANGUAGE=ruby|perl
#   USE_LANGUAGE_LIBRARY=(RUBY|PERL|PYTHON)_LIBRARY
#   USE_SWIG_FLAGS="-prefix;'prefix::'"
#   USE_SWIG_INCLUDEPATH="path"
#   USE_C_LINKAGE=FALSE

# ---- SWIG

message(STATUS "USE_LANGUAGE=${USE_LANGUAGE}")
message(STATUS "USE_LANGUAGE_LIBRARY=${USE_LANGUAGE_LIBRARY}")
message(STATUS "USE_SWIG_FLAGS=${USE_SWIG_FLAGS}")
message(STATUS "USE_SWIG_INCLUDEPATH=${USE_SWIG_INCLUDEPATH}")

FIND_PACKAGE(SWIG REQUIRED)

message(STATUS "SWIG_VERSION=${SWIG_VERSION}")

INCLUDE(${SWIG_USE_FILE})

# Make sure BIOLIB_BUILD or ASCILIB_BUILD is set at compile time
SET(BUILD_FLAG "-D${MAP_PROJECTNAME_UPPER}_BUILD")

IF(NOT USE_C_LINKAGE)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES CPLUSPLUS ON)
ENDIF()

if (USE_SWIG_INCLUDEALL) # really, don't use this flag
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "-includeall;${USE_SWIG_FLAGS};${BUILD_FLAG}")
else ()
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "${USE_SWIG_FLAGS};${BUILD_FLAG}")
endif ()

if (USE_SWIG_INCLUDEPATH)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "-I${USE_SWIG_INCLUDEPATH};${USE_SWIG_FLAGS};${BUILD_FLAG}")
endif ()

SET(M_LIBS ${MODULE_LIBRARY} ${USE_LANGUAGE_LIBRARY} ${CORE_LIBRARY} ${R_LIBRARY} ${ZLIB_LIBRARY} ${BIOLIB_R_LIBRARY} ${GSL_LIBRARY})

message(STATUS "SWIG M_MODULE=${M_MODULE}")
message(STATUS "SWIG M_LIBS=${M_LIBS}")

SWIG_ADD_MODULE(${M_MODULE} ${USE_LANGUAGE} ${INTERFACE} ${SOURCES} )
SWIG_LINK_LIBRARIES(${M_MODULE} ${M_LIBS})

# this is used when searching for include files e.g. using the FIND_PATH() command.
MESSAGE( STATUS "CMAKE_INCLUDE_PATH=" ${CMAKE_INCLUDE_PATH} )
# this is used when searching for libraries e.g. using the FIND_LIBRARY() command.
MESSAGE( STATUS "CMAKE_LIBRARY_PATH=" ${CMAKE_LIBRARY_PATH} )

SET(CMAKE_SHARED_MODULE_CREATE_CXX_FLAGS "${CMAKE_SHARED_MODULE_CREATE_CXX_FLAGS} -DHAVE_INLINE")

IF(APPLE)
  # Hack!
  SET(CMAKE_SHARED_MODULE_CREATE_CXX_FLAGS
   "${CMAKE_SHARED_MODULE_CREATE_CXX_FLAGS} -Wl,-flat_namespace -Wl,-undefined -Wl,warning")
ENDIF(APPLE)

IF(CYGWIN)
  IF(USE_LANGUAGE STREQUAL "perl")
    TARGET_LINK_LIBRARIES(${M_MODULE} crypt)
  ENDIF(USE_LANGUAGE STREQUAL "perl")
ENDIF(CYGWIN)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS("all SWIG prerequisites for ${USE_LANGUAGE}" DEFAULT_MSG USE_LANGUAGE USE_LANGUAGE_LIBRARY)


