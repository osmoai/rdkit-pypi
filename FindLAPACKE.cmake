# FindLAPACKE.cmake - Find LAPACKE library (C interface to LAPACK)
# This module sets the following variables:
#   LAPACKE_FOUND - TRUE if LAPACKE was found
#   LAPACKE_INCLUDE_DIRS - Include directories for LAPACKE
#   LAPACKE_LIBRARIES - Libraries to link
#
# Look for the header file - prioritize Cellar paths for Homebrew
find_path(LAPACKE_INCLUDE_DIR
    NAMES lapacke.h
    PATHS
        /opt/homebrew/Cellar/lapack/3.12.1/include
        ${LAPACKE_ROOT}/include
        /opt/homebrew/include
        /usr/local/include
        /usr/include
    PATH_SUFFIXES lapack lapacke
)

# Look for the library - prioritize Cellar paths for Homebrew
find_library(LAPACKE_LIBRARY
    NAMES lapacke
    PATHS
        /opt/homebrew/Cellar/lapack/3.12.1/lib
        ${LAPACKE_ROOT}/lib
        /opt/homebrew/lib
        /usr/local/lib
        /usr/lib
)

# Handle standard CMake arguments
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LAPACKE
    REQUIRED_VARS LAPACKE_LIBRARY LAPACKE_INCLUDE_DIR
)

if(LAPACKE_FOUND)
    set(LAPACKE_LIBRARIES ${LAPACKE_LIBRARY})
    set(LAPACKE_INCLUDE_DIRS ${LAPACKE_INCLUDE_DIR})
    
    # Create imported target
    if(NOT TARGET LAPACKE::LAPACKE)
        add_library(LAPACKE::LAPACKE UNKNOWN IMPORTED)
        set_target_properties(LAPACKE::LAPACKE PROPERTIES
            IMPORTED_LOCATION "${LAPACKE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LAPACKE_INCLUDE_DIR}"
        )
    endif()
endif()

mark_as_advanced(LAPACKE_INCLUDE_DIR LAPACKE_LIBRARY)
