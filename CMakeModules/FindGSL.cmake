#############################################################################
#
# $Id: FindGSL.cmake 4815 2014-07-31 14:00:05Z fspindle $
#
# This file is part of the ViSP software.
# Copyright (C) 2005 - 2014 by INRIA. All rights reserved.
# 
# This software is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# ("GPL") version 2 as published by the Free Software Foundation.
# See the file LICENSE.txt at the root directory of this source
# distribution for additional information about the GNU GPL.
#
# For using ViSP with software that can not be combined with the GNU
# GPL, please contact INRIA about acquiring a ViSP Professional 
# Edition License.
#
# See http://www.irisa.fr/lagadic/visp/visp.html for more information.
# 
# This software was developed at:
# INRIA Rennes - Bretagne Atlantique
# Campus Universitaire de Beaulieu
# 35042 Rennes Cedex
# France
# http://www.irisa.fr/lagadic
#
# If you have questions regarding the use of this file, please contact
# INRIA at visp@inria.fr
# 
# This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
# WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# Description:
# Try to find gnu scientific library GSL 
# (see http://www.gnu.org/software/gsl/)
# Once run this will define: 
# 
# GSL_FOUND        : system has GSL lib
# GSL_LIBRARIES    : full path to the libraries
# GSL_INCLUDE_DIRS : where to find headers
#
# Authors:
# Fabien Spindler
#
#############################################################################

# it seems that a macro() can't accept a list as input. That's why we have
# MY_LIBRARY1 and MY_LIBRARY2
macro(CheckCompilation_gsl2 MY_INCLUDE_DIR MY_LIBRARY1 MY_LIBRARY2 MY_BUILD_SUCCEED2)
    # The material is found. Check if it works on the requested architecture
    include(CheckCXXSourceCompiles)
    #message("Test compilation: ${MY_INCLUDE_DIR} + ${MY_LIBRARY1} + ${MY_LIBRARY2}")

    set(CMAKE_REQUIRED_LIBRARIES ${MY_LIBRARY1} ${MY_LIBRARY2})
    set(CMAKE_REQUIRED_INCLUDES ${MY_INCLUDE_DIR})
    check_cxx_source_compiles("
      #include <gsl/gsl_linalg.h> // Contrib for GSL library
      #include <gsl/gsl_math.h>
      #include <gsl/gsl_eigen.h>
      int main()
      {
        gsl_matrix *A2 = gsl_matrix_alloc(6, 6) ;
      }
      " BUILD_SUCCEED2)
    #message("BUILD_SUCCEED: ${BUILD_SUCCEED}")
    set(${MY_BUILD_SUCCEED2} ${BUILD_SUCCEED2})
endmacro()

macro(CheckCompilation_gsl1 MY_INCLUDE_DIR MY_LIBRARY MY_BUILD_SUCCEED)
    # The material is found. Check if it works on the requested architecture
    include(CheckCXXSourceCompiles)
    #message("Test compilation: ${MY_INCLUDE_DIR} + ${MY_LIBRARY}")

    set(CMAKE_REQUIRED_LIBRARIES ${MY_LIBRARY})
    set(CMAKE_REQUIRED_INCLUDES ${MY_INCLUDE_DIR})
    check_cxx_source_compiles("
      #include <gsl/gsl_linalg.h> // Contrib for GSL library
      #include <gsl/gsl_math.h>
      #include <gsl/gsl_eigen.h>
      int main()
      {
        gsl_matrix *A1 = gsl_matrix_alloc(6, 6) ;
      }
      " BUILD_SUCCEED)
    #message("BUILD_SUCCEED: ${BUILD_SUCCEED}")
    set(${MY_BUILD_SUCCEED} ${BUILD_SUCCEED})
endmacro()

find_path(GSL_INCLUDE_DIR gsl/gsl_linalg.h
  $ENV{GSL_HOME}/include
  $ENV{GSL_DIR}/include
  /usr/include
  /usr/local/include
)

find_library(GSL_gsl_LIBRARY
  NAMES gsl
  PATHS
    "$ENV{GSL_HOME}/lib"
    "$ENV{GSL_DIR}/lib"
    /usr/lib
    /usr/local/lib
)

if(WIN32)
  find_library(GSL_cblas_LIBRARY
    NAMES cblas
    PATHS
      "$ENV{GSL_HOME}/lib"
      "$ENV{GSL_DIR}/lib"
      /usr/lib
      /usr/local/lib
  )

  find_library(GSL_gsl_LIBRARY_DEBUG
    NAMES gsl_d
    PATHS
      "$ENV{GSL_HOME}/lib"
      "$ENV{GSL_DIR}/lib"
      /usr/lib
      /usr/local/lib
  )
  find_library(GSL_cblas_LIBRARY_DEBUG
    NAMES cblas_d
    PATHS
      "$ENV{GSL_HOME}/lib"
      "$ENV{GSL_DIR}/lib"
      /usr/lib
      /usr/local/lib
  )

  if(GSL_INCLUDE_DIR AND GSL_gsl_LIBRARY AND GSL_cblas_LIBRARY
      AND GSL_gsl_LIBRARY_DEBUG AND GSL_cblas_LIBRARY_DEBUG)
    set(GSL_LIBRARIES "optimized" ${GSL_cblas_LIBRARY}
                      "optimized" ${GSL_gsl_LIBRARY}
                      "debug" ${GSL_cblas_LIBRARY_DEBUG}
                      "debug" ${GSL_gsl_LIBRARY_DEBUG})
    set(GSL_INCLUDE_DIRS ${GSL_INCLUDE_DIR})
    set(GSL_FOUND TRUE)
  else()
    set(GSL_FOUND FALSE)
  endif()

  mark_as_advanced(
    GSL_gsl_LIBRARY_DEBUG
    GSL_cblas_LIBRARY_DEBUG
  )
else()
  if(GSL_INCLUDE_DIR AND GSL_gsl_LIBRARY)
    # Check if gsl library is sufficient
    set(GSL_INCLUDE_DIRS ${GSL_INCLUDE_DIR})
    set(GSL_LIBRARIES ${GSL_gsl_LIBRARY})

    CheckCompilation_gsl1(${GSL_INCLUDE_DIRS} ${GSL_gsl_LIBRARY} BUILD_SUCCEED1)
    #message("BUILD_STATUS 1: ${BUILD_SUCCEED1}")
    if(BUILD_SUCCEED1)
      set(GSL_FOUND TRUE)
    else()
      # Try to add gslcblas library if requested

      find_library(GSL_cblas_LIBRARY
        NAMES gslcblas
        PATHS
          "$ENV{GSL_HOME}/lib"
          "$ENV{GSL_DIR}/lib"
          /usr/lib
          /usr/local/lib
      )
      if(GSL_cblas_LIBRARY)
        list(APPEND GSL_LIBRARIES ${GSL_cblas_LIBRARY})
        #message("add cblas to GSL_LIBRARIES: ${GSL_LIBRARIES}")
        CheckCompilation_gsl2(${GSL_INCLUDE_DIRS} ${GSL_gsl_LIBRARY} ${GSL_cblas_LIBRARY} BUILD_SUCCEED2)
        #message("BUILD_STATUS 2: ${BUILD_SUCCEED2}")
        if(BUILD_SUCCEED2)
          set(GSL_FOUND TRUE)
        else()
          set(GSL_FOUND FALSE)
        endif()
      else()
        set(GSL_FOUND FALSE)
      endif()
    endif()
  else()
    set(GSL_FOUND FALSE)
  endif()
endif()

mark_as_advanced(
  GSL_gsl_LIBRARY
  GSL_cblas_LIBRARY
  GSL_INCLUDE_DIR
)

