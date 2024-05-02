cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD_11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(simple VERSION 1.0 LANGUAGES CXX)

find_package(OpenCV REQUIRED )



add_library(simple SHARED MyContainer.cpp simple.cpp)

target_include_directories(simple PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           "${OpenCV_INCLUDE_DIRS}")


target_link_libraries(simple "${OpenCV_LIBS}")
