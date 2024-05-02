#include "MyContainer.h"
using namespace std;
using namespace cv;


MyContainer::MyContainer() {
    
}

MyContainer::MyContainer(Mat m)
    :mat (m)
{
} 

MyContainer::~MyContainer() {
}

int MyContainer::load_image(char *filename, int color_mode) {
    mat = imread(filename, color_mode);
    return 0; 
}

int MyContainer::new_lines() {
    lines.clear();
    return 0;
}

int MyContainer::push_line(int x1, int x2, int y1, int y2, int r, int g, int b) {
    Vec8i v(x1, x2, y1, y2, r, g, b, 0);
    lines.push_back(v);
    return 0;
}

vector<Vec8i> MyContainer::get_lines() {
    return lines;
}
