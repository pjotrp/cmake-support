# - Find Perl settings
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
#   USE_CORE - link the core lib

SET (M_MODULE ${M_NAME})

message("Creating Perl module ${M_MODULE} (${M_VERSION})")
FIND_PACKAGE(Map REQUIRED)
FIND_PACKAGE(PerlLibs REQUIRED)

# ---- Setting the default Perl include path
INCLUDE_DIRECTORIES(${PERL_INCLUDE_PATH})

FIND_PACKAGE(MapModule REQUIRED)
FIND_PACKAGE(MapLibraries REQUIRED)

SET (USE_LANGUAGE "perl")
SET (USE_LANGUAGE_LIBRARY ${PERL_LIBRARY})

FIND_PACKAGE(MapSWIG REQUIRED)

MARK_AS_ADVANCED (
  USE_LANGUAGE_LIBRARY
	)
