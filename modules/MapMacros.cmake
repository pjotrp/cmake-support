
message(STATUS "MapMacros.cmake")

MACRO(ASSERT_FOUNDMAP)
  IF(NOT FOUNDMAP)
	  message(FATAL_ERROR "You need to load MAP first with Find(MAP)")
  ENDIF()
ENDMACRO()


