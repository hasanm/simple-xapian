#ifndef SIMPLE_H
#define SIMPLE_H

#ifdef __cplusplus
extern "C" {
#endif
    void* easy_init();
    int easy_estimate(void *ptr, char *str);
    int easy_search(void *ptr, char *str, int beg, int end);
    int easy_perform(void *ptr, char *str, int beg, int end, size_t (*f) (int));
    

#ifdef __cplusplus
}
#endif

#endif
