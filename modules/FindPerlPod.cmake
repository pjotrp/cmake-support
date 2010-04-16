# Generate Perl POD and HTML
#
# Expects M_NAME, M_VERSION to be set!
#
# Special parameters are:
#

message(STATUS "FindPerlPod.cmake")
message("SWIG=" ${SWIG_EXECUTABLE})

ADD_CUSTOM_TARGET(perldoc
  COMMENT "Generating Perl documentation for ${M_NAME}"
  COMMAND ${CMAKE_COMMAND} -E make_directory build
  COMMAND ${SWIG_EXECUTABLE} -I${MAP_ROOT}/src/clibs/affyio/src/ -o build/${M_NAME}.xml -xml ${INTERFACE}
  COMMAND ${MAP_ROOT}/tools/swig2doc/bin/swig2doc build/${M_NAME}.xml ${MAP_ROOT}/build/doc/xml/apidoc/biolib__affyio_8h.xml  ${MAP_ROOT}/build/doc/xml/apidoc/biolib__affyio_8c.xml
  COMMAND pod2html output/perl/${M_NAME}.pod > build/${M_NAME}.html
  # Copy the files
  COMMAND ${CMAKE_COMMAND} -E make_directory ${MAP_ROOT}/build/pod
  COMMAND ${CMAKE_COMMAND} -E copy_if_different output/perl/${M_NAME}.pod ${MAP_ROOT}/build/pod
  COMMAND ${CMAKE_COMMAND} -E make_directory ${MAP_ROOT}/build/doc/html/perl
  COMMAND ${CMAKE_COMMAND} -E copy_if_different build/${M_NAME}.html ${MAP_ROOT}/build/doc/html/perl/
)


