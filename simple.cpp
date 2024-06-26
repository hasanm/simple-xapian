// C program to display hostname
// and IP address
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <sstream>
#include <fstream>
#include <map>
#include <vector>
#include "simple.h"
#include "MyXapian.h"
#include <xapian.h>
#include <string.h>

#define QUERY "upass"
#define F_DOCID 1
#define INDEX_PATH "/home/p-hasan/work/qt/my-xapian/build/index_data"

using namespace std;

void* easy_init() {
    MyXapian *g = new MyXapian;
    
    try {
        string query_str(QUERY);
        g->db = new Xapian::Database(string(INDEX_PATH));
        Xapian::Enquire enquire(*g->db);
        
    } catch (const Xapian::Error e) {
        cout << e.get_description() << endl; 
    }
    
    return g; 
}

int easy_estimate(void *ptr, char *str) {

    MyXapian *g = static_cast<MyXapian*> (ptr);
    
    try {
        string query_str(str);
        Xapian::Enquire enquire(*g->db);
        
        Xapian::QueryParser qp;
        Xapian::Query query = qp.parse_query(query_str);
        
        
        enquire.set_query(query);
        Xapian::MSet result = enquire.get_mset(0,10);

        return result.get_matches_estimated();
        
    } catch (const Xapian::Error e) {
        cout << e.get_description() << endl; 
    }
    
    return 0;    
    
}


int easy_search(void *ptr, char *str, int beg, int end, size_t (*f)(size_t, size_t), char *buf) {
    MyXapian *g = static_cast<MyXapian*> (ptr);
    
    try {
        string query_str(str);
        Xapian::Enquire enquire(*g->db);
        
        Xapian::QueryParser qp;
        Xapian::Query query = qp.parse_query(query_str);
        
        
        enquire.set_query(query);
        Xapian::MSet result = enquire.get_mset(beg,end);
        
        
        
        for(Xapian::MSetIterator iter = result.begin(); iter != result.end(); iter++){
            Xapian::Document doc = iter.get_document();
            // cout<<iter.get_rank()<<", data"<<doc.get_data()<<endl;
            strcpy(buf, doc.get_data().c_str());
            (*f)(strlen(buf), iter.get_rank());
        }        
        
    } catch (const Xapian::Error e) {
        cout << e.get_description() << endl; 
    }
    
    return 0;
}
