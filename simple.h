#ifndef SYSTEM_INFO_H
#define SYSTEM_INFO_H

#ifdef __cplusplus
extern "C" {
#endif
    char* get_machine();
    int draw_rectangle(int x, int y, int p, int q);
    int copy_image(char *filename);
    int paste_image(char *filename);

    int my_merge();
    int make_gray();
    int grab_cut();
    int experiment();
    int canny_edge(int edgeThresh);
    int hough_lines(int edgeThresh, double minTheta, double maxTheta);
    int hough_lines_p(int edgeThresh, int voteThreshold, int minLineLength, int maxLineGap);
    int hough_circles(double dp, double param1, double param2, int minRadius, int maxRadius);

    int find_contours(int mSize, int edgeThresh);
    int find_inside();

    void* easy_init();
    void* cut_image(void* container, int x, int y, int p, int q);
    int save_image(void* container, char *filename);
    int load_image(void* container, char *filename, int color_mode);
    int new_lines(void* container);
    int push_line(void* container, int x1, int x2, int y1, int y2, int r, int g, int b);
    int draw_lines(void* container);
    void* adaptive_threshold(void* container);
    void* gaussian_blur(void* container, int mSize);    
    


#ifdef __cplusplus
}
#endif

#endif
