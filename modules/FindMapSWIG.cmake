# CMake file for SWIG configuration
#
# Using
#
#   USE_LANGUAGE=ruby|perl
#   USE_LANGUAGE_LIBRARY=(RUBY|PERL|PYTHON)_LIBRARY
#   USE_SWIG_FLAGS="-prefix;'prefix::'"
#   USE_SWIG_INCLUDEPATH="path"

# ---- SWIG 

message(STATUS "USE_LANGUAGE=${USE_LANGUAGE}")
message(STATUS "USE_LANGUAGE_LIBRARY=${USE_LANGUAGE_LIBRARY}")
message(STATUS "USE_SWIG_FLAGS=${USE_SWIG_FLAGS}")
message(STATUS "USE_SWIG_INCLUDEPATH=${USE_SWIG_INCLUDEPATH}")

FIND_PACKAGE(SWIG REQUIRED)
INCLUDE(${SWIG_USE_FILE})

SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES CPLUSPLUS ON)

if (USE_C_LINKAGE)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES CPLUSPLUS OFF)
endif (USE_C_LINKAGE)

if (USE_SWIG_INCLUDEALL)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "-includeall;${USE_SWIG_FLAGS}'")
else (USE_SWIG_INCLUDEALL)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "${USE_SWIG_FLAGS}")
endif (USE_SWIG_INCLUDEALL)
if (USE_SWIG_INCLUDEPATH)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "-I${USE_SWIG_INCLUDEPATH};${USE_SWIG_FLAGS}")
endif (USE_SWIG_INCLUDEPATH)

message(STATUS "SWIG M_MODULE=${M_MODULE}")

SWIG_ADD_MODULE(${M_MODULE} ${USE_LANGUAGE} ${INTERFACE} ${SOURCES} )
SWIG_LINK_LIBRARIES(${M_MODULE} ${MODULE_LIBRARY} ${USE_LANGUAGE_LIBRARY} ${CORE_LIBRARY} ${R_LIBRARY} ${ZLIB_LIBRARY})

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


