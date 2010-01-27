
message(STATUS "ClibMacros.cmake")

# Set up a test
MACRO(TEST_CLIB)
ENDMACRO(TEST_CLIB)

MACRO(NAME_CLIB)
  SET(LIBNAME ${MAP_projectname}_${M_NAME}-${MAP_VERSION})
  if(M_VERSION)
    SET (_directory ${MAP_CLIBS_PATH}/${M_NAME}-${M_VERSION}/build)
  else()
    SET (_directory ${MAP_CLIBS_PATH}/${M_NAME}/build)
  endif()
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${_directory})
  SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${_directory})
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${_directory})
  SET (_directory undefined)
ENDMACRO(NAME_CLIB)

MACRO(BUILD_CLIB)
  if(NOT LIBNAME)
    NAME_CLIB()
  endif()
  message("LIBNAME="${LIBNAME})
  message("BUILDDIR="${_directory})

  # ---- The following is required for OSX
  if(USE_ZLIB)
    TARGET_LINK_LIBRARIES(${LIBNAME} ${ZLIB_NAME})
  endif()
  if(USE_RLIB)
    TARGET_LINK_LIBRARIES(${LIBNAME} ${R_LIBRARY})
  endif()
  if(USE_CORE)
    TARGET_LINK_LIBRARIES(${LIBNAME} ${CORE_LIBRARY})
  endif()

ENDMACRO(BUILD_CLIB)

# Installation location for the C libraries
MACRO(INSTALL_CLIB)
  INSTALL(TARGETS ${LIBNAME}
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin )
ENDMACRO(INSTALL_CLIB)
