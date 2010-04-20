# Generate Perl POD and HTML
#
# Expects M_NAME, M_VERSION to be set!
#
# Special parameters are:
#

message(STATUS "FindPerlPod.cmake")
message(STATUS "SWIG=" ${SWIG_EXECUTABLE})
message(STATUS "USE_SWIG_INCLUDEPATH=" ${USE_SWIG_INCLUDEPATH})
message(STATUS "CMAKE_SWIG_FLAGS=" ${CMAKE_SWIG_FLAGS})

GET_DIRECTORY_PROPERTY(cmake_include_directories INCLUDE_DIRECTORIES)
SET(swig_include_dirs)
FOREACH(it ${cmake_include_directories})
  SET(swig_include_dirs ${swig_include_dirs} "-I${it}")
ENDFOREACH(it)

ADD_CUSTOM_TARGET(perldoc
  COMMENT "Generating Perl documentation for ${M_NAME}"
  COMMAND ${CMAKE_COMMAND} -E make_directory build
  COMMAND ${SWIG_EXECUTABLE} ${swig_include_dirs} -o build/${M_NAME}.xml -xml ${INTERFACE}
  COMMAND ${MAP_ROOT}/tools/swig2doc/bin/swig2doc build/${M_NAME}.xml ${DOXY_XML_FILES}
  COMMAND pod2html output/perl/${M_NAME}.pod > build/${M_NAME}.html
  # Copy the files
  COMMAND ${CMAKE_COMMAND} -E make_directory ${MAP_ROOT}/build/pod
  COMMAND ${CMAKE_COMMAND} -E copy_if_different output/perl/${M_NAME}.pod ${MAP_ROOT}/build/pod
  COMMAND ${CMAKE_COMMAND} -E make_directory ${MAP_ROOT}/build/doc/html/perl
  COMMAND ${CMAKE_COMMAND} -E copy_if_different build/${M_NAME}.html ${MAP_ROOT}/build/doc/html/perl/
)


