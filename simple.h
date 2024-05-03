#ifndef SIMPLE_H
#define SIMPLE_H

#ifdef __cplusplus
extern "C" {
#endif
    void* easy_init();
    int easy_estimate(void *ptr, char *str);
    int easy_search(void *ptr, char *str, int beg, int end, size_t (*f) (size_t, size_t), char* buf);
    

#ifdef __cplusplus
}
#endif

#endif
