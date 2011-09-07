# - Locate the fcitx4 library
# This module defines
#  FCITX4_FCITX_FOUND found libfcitx
#  FCITX4_FCITX_LIBRARIES the, library to link against
#  FCITX4_FCITX_LIBRARY_DIRS, where to find library
#  FCITX4_FCITX_INCLUDE_DIRS, where to find headers
#  FCITX4_FCITX_CONFIG_FOUND found libfcitx-config
#  FCITX4_FCITX_CONFIG_LIBRARIES, library to link against
#  FCITX4_FCITX_CONFIG_LIBRARY_DIRS, where to find library
#  FCITX4_FCITX_CONFIG_INCLUDE_DIRS, where to find headers
#  FCITX4_FCITX_UTILS_FOUND found libfcitx-utils
#  FCITX4_FCITX_UTILS_LIBRARIES, library to link against
#  FCITX4_FCITX_UTILS_LIBRARY_DIRS, where to find library
#  FCITX4_FCITX_UTILS_INCLUDE_DIRS, where to find headers
#  FCITX4_ADDON_INSTALL_DIR directory to install fcitx addon
#  FCITX4_CONFIGDESC_INSTALL_DIR directory to install fcitx configuration description file
#  FCITX4_ADDON_CONFIG_INSTALL_DIR directory to install fcitx addon config
#  FCITX4_PACKAGE_NAME package name of fcitx, normally is "fcitx"
#  FCITX4_VERSION version of fcitx
#
# Please look in FcitxMacro.cmake for more information.

#==============================================================================
# Copyright 2011 Xuetian Weng
#
# Distributed under the GPLv2 License
# see accompanying file COPYRIGHT for details
#==============================================================================
# (To distribute this file outside of Fcitx, substitute the full
#  License text for the above reference.)

# use pkg-config to get the directories and then use these values
# in the FIND_PATH() and FIND_LIBRARY() calls
FIND_PACKAGE(PkgConfig)
PKG_CHECK_MODULES(PC_FCITX fcitx)
PKG_CHECK_MODULES(PC_FCITX_CONFIG fcitx-config)
PKG_CHECK_MODULES(PC_FCITX_UTILS fcitx-utils)

SET(FCITX4_FCITX_FOUND ${PC_FCITX_FOUND})
SET(FCITX4_FCITX_LIBRARIES ${PC_FCITX_LIBRARIES})
SET(FCITX4_FCITX_LIBRARY_DIRS ${PC_FCITX_LIBRARY_DIRS})
SET(FCITX4_FCITX_LDFLAGS ${PC_FCITX_LDFLAGS})
SET(FCITX4_FCITX_LDFLAGS_OTHER ${PC_FCITX_LDFLAGS_OTHER})
SET(FCITX4_FCITX_INCLUDE_DIRS ${PC_FCITX_INCLUDE_DIRS})
SET(FCITX4_FCITX_CFLAGS ${PC_FCITX_CFLAGS})
SET(FCITX4_FCITX_CFLAGS_OTHER ${PC_FCITX_CFLAGS_OTHER})

SET(FCITX4_FCITX_CONFIG_FOUND ${PC_FCITX_FOUND})
SET(FCITX4_FCITX_CONFIG_LIBRARIES ${PC_FCITX_CONFIG_LIBRARIES})
SET(FCITX4_FCITX_CONFIG_LIBRARY_DIRS ${PC_FCITX_CONFIG_LIBRARY_DIRS})
SET(FCITX4_FCITX_CONFIG_LDFLAGS ${PC_FCITX_CONFIG_LDFLAGS})
SET(FCITX4_FCITX_CONFIG_LDFLAGS_OTHER ${PC_FCITX_CONFIG_LDFLAGS_OTHER})
SET(FCITX4_FCITX_CONFIG_INCLUDE_DIRS ${PC_FCITX_CONFIG_INCLUDE_DIRS})
SET(FCITX4_FCITX_CONFIG_CFLAGS ${PC_FCITX_CONFIG_CFLAGS})
SET(FCITX4_FCITX_CONFIG_CFLAGS_OTHER ${PC_FCITX_CONFIG_CFLAGS_OTHER})

SET(FCITX4_FCITX_UTILS_FOUND ${PC_FCITX_FOUND})
SET(FCITX4_FCITX_UTILS_LIBRARIES ${PC_FCITX_UTILS_LIBRARIES})
SET(FCITX4_FCITX_UTILS_LIBRARY_DIRS ${PC_FCITX_UTILS_LIBRARY_DIRS})
SET(FCITX4_FCITX_UTILS_LDFLAGS ${PC_FCITX_UTILS_LDFLAGS})
SET(FCITX4_FCITX_UTILS_LDFLAGS_OTHER ${PC_FCITX_UTILS_LDFLAGS_OTHER})
SET(FCITX4_FCITX_UTILS_INCLUDE_DIRS ${PC_FCITX_UTILS_INCLUDE_DIRS})
SET(FCITX4_FCITX_UTILS_CFLAGS ${PC_FCITX_UTILS_CFLAGS})
SET(FCITX4_FCITX_UTILS_CFLAGS_OTHER ${PC_FCITX_UTILS_CFLAGS_OTHER})

FIND_PROGRAM(FCITX4_FCITXCONFIG_EXECUTABLE NAMES fcitx4-config
   # the suffix must be used since KDEDIRS can be a list of directories which don't have bin/ appended
   PATH_SUFFIXES bin
   HINTS
   ${CMAKE_INSTALL_PREFIX}
   /opt/fcitx
   ONLY_CMAKE_FIND_ROOT_PATH
   )

IF(FCITX4_FCITXCONFIG_EXECUTABLE)
    message(STATUS "fcitx4-config found ${FCITX4_FCITXCONFIG_EXECUTABLE}")
    EXECUTE_PROCESS(COMMAND "${FCITX4_FCITXCONFIG_EXECUTABLE}" --addondir OUTPUT_VARIABLE FCITX4_ADDON_INSTALL_DIR ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND "${FCITX4_FCITXCONFIG_EXECUTABLE}" --configdescdir OUTPUT_VARIABLE FCITX4_CONFIGDESC_INSTALL_DIR ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND "${FCITX4_FCITXCONFIG_EXECUTABLE}" --addonconfigdir OUTPUT_VARIABLE FCITX4_ADDON_CONFIG_INSTALL_DIR ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND "${FCITX4_FCITXCONFIG_EXECUTABLE}" --package OUTPUT_VARIABLE FCITX4_PACKAGE_NAME ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND "${FCITX4_FCITXCONFIG_EXECUTABLE}" --version OUTPUT_VARIABLE FCITX4_VERSION ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND "${FCITX4_FCITXCONFIG_EXECUTABLE}" --prefix OUTPUT_VARIABLE FCITX4_PREFIX ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
else(FCITX4_FCITXCONFIG_EXECUTABLE)
    message(STATUS "fcitx4-config not found")
ENDIF(FCITX4_FCITXCONFIG_EXECUTABLE)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Fcitx DEFAULT_MSG FCITX4_VERSION)

INCLUDE(${FCITX4_PREFIX}/share/cmake/fcitx/FcitxMacro.cmake)
