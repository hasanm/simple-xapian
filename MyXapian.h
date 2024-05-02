#ifndef MY_XAPIAN_H
#define MY_XAPIAN_H

#include<vector>
#include <xapian.h>

using namespace std;

class MyXapian {
 public:
    MyXapian();
    ~MyXapian();

    Xapian::Database *db; 

};

#endif
