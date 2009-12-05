# - Find Ruby settings
#
# Expects M_NAME, M_VERSION to be set!
#
# Special parameters are:
#
#   USE_INCLUDEPATH - find module include files here
#   USE_SWIG_INCLUDEALL - tell SWIG to parse all include files for 
#     info (not recommended as all C headers are pulled in too)
#   USE_RLIB - link the R libraries
#   USE_ZLIB - link Zlib
#   USE_CORE - link the core liba
#   USE_GSL  - link GSL lib

SET (M_MODULE ${M_NAME})

message("Creating Ruby module ${M_MODULE} (${M_VERSION})")
FIND_PACKAGE(Map REQUIRED)
FIND_PACKAGE(Ruby REQUIRED)
INCLUDE( ${CMAKE_MODULE_PATH}/RubyMacros.cmake)

# ---- Setting the default Ruby include path
INCLUDE_DIRECTORIES(${RUBY_INCLUDE_PATH})
SET (RUBY_LIB_PATH ${RUBY_INCLUDE_PATH})

# ---- Always create the SWIG library in a subdirectory
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY biolib)

FIND_PACKAGE(MapModule REQUIRED)
FIND_PACKAGE(MapLibraries REQUIRED)

SET (USE_LANGUAGE "ruby")
SET (USE_LANGUAGE_LIBRARY ${RUBY_LIBRARY})
SET (USE_SWIG_FLAGS "-prefix;'${MAP_projectname}::';${USE_SWIG_FLAGS}")

FIND_PACKAGE(MapSWIG REQUIRED)

SET (RUBY_DOCTEST ${MAP_ROOT}/tools/rubydoctest/bin/rubydoctest)

MESSAGE( STATUS "RUBY_LIB_PATH=${RUBY_LIB_PATH}")

