# Global MAPPING settings
#

# ---- Get MAP source root directory
# get_filename_component(MAP_ROOT ${CMAKE_MODULE_PATH} PATH)
# SET(MAP_ROOT ${CMAKE_SOURCE_DIR})
SET(MAP_CLIBS_PATH ${MAP_ROOT}/src/clibs)

# ---- Get info from ./VERSION file
SET(cat_prog cat)
IF(WIN32)
  IF(NOT UNIX)
    SET(cat_prog type)
  ENDIF(NOT UNIX)
ENDIF(WIN32)

EXEC_PROGRAM(${cat_prog} ARGS ${MAP_ROOT}/VERSION OUTPUT_VARIABLE MAP_VERSION)
EXEC_PROGRAM(${cat_prog} ARGS ${MAP_ROOT}/PROJECTNAME OUTPUT_VARIABLE MAP_PROJECTNAME)

string(TOLOWER ${MAP_PROJECTNAME} MAP_projectname)
string(TOUPPER ${MAP_PROJECTNAME} MAP_PROJECTNAME_UPPER)

# ---- Add a predefined build variable
add_definitions(-DMAP_BUILD)

# ---- Set default installation prefix

IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  SET(CMAKE_INSTALL_PREFIX /usr)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

IF(NOT CMAKE_INSTALL_PREFIX)
  MESSAGE("Forcing install prefix to /usr")
  SET(CMAKE_INSTALL_PREFIX /usr)
ENDIF(NOT CMAKE_INSTALL_PREFIX)

message("PREFIX: ${CMAKE_INSTALL_PREFIX}")

# ---- RPATH handling

# use, i.e. don't skip the full RPATH for the build tree
SET(CMAKE_SKIP_BUILD_RPATH  FALSE)

# when building, don't use the install RPATH already
# (but later on when installing)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 

# the RPATH to be used when installing
SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")

# don't add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE)

MESSAGE("CMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}")
MESSAGE("MAP_ROOT=${MAP_ROOT}")
MESSAGE("MAP_CLIBS_PATH=${MAP_CLIBS_PATH}")
MESSAGE("MAP_PROJECTNAME=${MAP_projectname}")
MESSAGE("MAP_VERSION=${MAP_VERSION}")

# handle the QUIETLY and REQUIRED arguments and set RLIBS_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(xRLibs DEFAULT_MSG MAP_VERSION MAP_projectname)

MARK_AS_ADVANCED(
  MAP_ROOT
  MAP_CLIBS_PATH
  MAP_VERSION
  )
