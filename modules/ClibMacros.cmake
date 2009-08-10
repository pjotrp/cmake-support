
message(STATUS "ClibMacros.cmake")

# Set up a test
MACRO(TEST_CLIB)
ENDMACRO(TEST_CLIB)

MACRO(BUILD_CLIB)
  SET(LIBNAME ${MAP_projectname}_${M_NAME}-${MAP_VERSION})
  message("LIBNAME=" ${LIBNAME})
  if(M_VERSION)
    SET (_directory ${MAP_CLIBS_PATH}/${M_NAME}-${M_VERSION}/build)
  else()
    SET (_directory ${MAP_CLIBS_PATH}/${M_NAME}/build)
  endif()
  message("BUILDDIR=" ${_directory})
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${_directory})
  SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${_directory})
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${_directory})
  SET (_directory undefined)
ENDMACRO(BUILD_CLIB)

# Installation location for the C libraries
MACRO(INSTALL_CLIB)
  INSTALL(TARGETS ${LIBNAME}
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin )
ENDMACRO(INSTALL_CLIB)
