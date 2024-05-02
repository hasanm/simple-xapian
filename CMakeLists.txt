cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD_11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(simple-xapian VERSION 1.0 LANGUAGES CXX)

find_package(Xapian REQUIRED)

add_library(${CMAKE_PROJECT_NAME} SHARED MyContainer.cpp simple.cpp)

target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC
                           "${PROJECT_BINARY_DIR}")

target_link_libraries(${CMAKE_PROJECT_NAME} "${OpenCV_LIBS}" "${XAPIAN_LIBRARIES}")
