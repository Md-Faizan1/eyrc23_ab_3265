
/*
* AstroTinker Bot (AB): Task 1B Path Planner
*
* This program computes the valid path from the start point to the end point.
* Make sure you don't change anything outside the "Add your code here" section.
* Updated memory addresses for Task 2B
*/

#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define VERTICES 30 // Number of vertices in the graph

#ifdef __linux__ // for host pc

#include <stdio.h>

void _put_byte(char c) { putchar(c); }

void _put_str(char *str) {
    while (*str) {
        _put_byte(*str++);
    }
}

void print_output(uint8_t num) {
    if (num == 0) {
        putchar('0'); // if the number is 0, directly print '0'
        _put_byte('\n');
        return;
    }

    if (num < 0) {
        putchar('-'); // print the negative sign for negative numbers
        num = -num;   // make the number positive for easier processing
    }

    // convert the integer to a string
    char buffer[20]; // assuming a 32-bit integer, the maximum number of digits is 10 (plus sign and null terminator)
    uint8_t index = 0;

    while (num > 0) {
        buffer[index++] = '0' + num % 10; // convert the last digit to its character representation
        num /= 10;                        // move to the next digit
    }

    // print the characters in reverse order (from right to left)
    while (index > 0) { putchar(buffer[--index]); }
    _put_byte('\n');
}

void _put_value(uint8_t val) { print_output(val); }

#else  // for the test device

void _put_value(uint8_t val) { }
void _put_str(char *str) { }

#endif

/*
Functions Usage

instead of using printf() function for debugging,
use the below function calls to print a number, string or a newline

for newline: _put_byte('\n');
for string:  _put_str("your string here");
for number:  _put_value(your_number_here);

Examples:
        _put_value(START_POINT);
        _put_value(END_POINT);
        _put_str("Hello World!");
        _put_byte('\n');

*/



//*************************************************************************************************************

// This function adds an edge to the adjacency matrix
void add_edge(int* graph, int u, int v) {
    graph[u]  |= (volatile int)(1 << v);
    graph[v] |= (volatile int)(1 << u);
}


// Function to find and print the shortest path using Dijkstra's algorithm
void dijkstra(int* i, int* j , int* k, int* graph, uint8_t* dist, uint8_t* parent,  uint8_t* current,uint8_t* edgeExist, uint8_t* temp, int start, int end, uint8_t* path_planned, uint8_t* idx) {
 
    // Initialize all distances as INFINITE and no parent
    for (*i = 0; *i < VERTICES; *i = *(i)+1) {
        dist[*i] = 40;
        parent[*i] = 255;
    }

    // Distance from source to itself is always 0
    dist[start] = 0;
    // _put_str("######### Chk 2 #########\n");

    for (*k = 0; *k < VERTICES - 1; ++(*k)) {
      for (*i = 0; *i < VERTICES; ++(*i)) {
        for (*j = 0; *j < VERTICES; ++(*j)) {
                    if((graph[*i] & (1 << *j)) == (uint8_t)0){
                      *edgeExist = 0;  
                      }
                      else{
                       *edgeExist = 1; 
                      }
              if(*edgeExist){
                    if(dist[*i] != (uint8_t)40){
                            if( dist[*i] +(uint8_t)(*edgeExist) < dist[*j] ){
                                 dist[*j] = dist[*i] + (uint8_t)(*edgeExist);
                                 parent[*j] = *i;
                            }
                    }
              }

        }
          
}
}
         


//     for (*k = 0; *k < VERTICES - 1; ++(*k)) {
//       for (*i = 0; *i < VERTICES; ++(*i)) {
//         for (*j = 0; *j < VERTICES; ++(*j)) {
//                     if((graph[*i] & (1 << *j)) == (uint8_t)0){
//                       *edgeExist = 0;  
//                       }
//                       else{
//                        *edgeExist = 1; 
//                       }
//               if(*edgeExist){
//                     if(dist[*i] != (uint8_t)40){
//                             if( dist[*i] +(uint8_t)(*edgeExist) < dist[*j] ){
//                                  dist[*j] = dist[*i] + (uint8_t)(*edgeExist);
//                                  parent[*j] = *i;
//                             }
//                     }
//               }

//         }
          
// }
// }
                                                     
    
//  for ( *k = 0; *k < VERTICES - 1; ++(*k)) {
//         for (*i = 0; *i < VERTICES; ++(*i)) {
//             for (*j = 0; *j < VERTICES; ++(*j)) {
//                 if ((((graph[*i] & (1 << *j)) != 0)  && (dist[*i] != 40) &&  (dist[*i] + ((graph[*i] & (1 << *j)) != 0) < dist[*j]))) {
//                     dist[*j] = dist[*i] + (((graph[*i] & (1 << *j))) != 0);
//                     parent[*j] = *i;
//                 }
//             }
//         }
//    }


    (*idx) = 0; // Initialize the path length
    *current = end;

while (*current != 255) {
        path_planned[(*idx)++] = *current;
        *current = parent[*current];
    }

// for (; *current != 255;  *current = parent[*current]){
//      path_planned[(*idx)++] = *current;
// }
    // Reverse the path_planned array to get the correct order
    for (*i = 0, *j = *(idx) - 1; *i < *j; ++(*i), --(*j)) {
        *temp = path_planned[*i];
        path_planned[*i] = path_planned[*j];
        path_planned[*j] = *temp;
    }
}
  


//*************************************************************************************************************




// main function
int main(int argc, char const * argv[]) {

#ifdef __linux__

    const uint8_t START_POINT   = atoi(argv[1]);
    const uint8_t END_POINT     = atoi(argv[2]);
    uint8_t NODE_POINT          = 0;
    uint8_t CPU_DONE            = 0;

#else
    // Address value of variables are updated for RISC-V Implementation
#define START_POINT         (* (volatile uint8_t * ) 0x02000000)
#define END_POINT           (* (volatile uint8_t * ) 0x02000004)
#define NODE_POINT          (* (volatile uint8_t * ) 0x02000008)
#define CPU_DONE            (* (volatile uint8_t * ) 0x0200000c)
#define INTEGER_I           ( (volatile uint8_t * ) 0x02000010)
#define INTEGER_J           ( (volatile uint8_t * ) 0x02000014)
#define INTEGER_K           ( (volatile uint8_t * ) 0x02000018)
#define GRAPH_ADDRESS       ( (volatile uint8_t * ) 0x0200001c)
#define DIST_ADDRESS        ( (volatile uint8_t * ) 0x02000094)
#define PAR_ADDRESS         ( (volatile uint8_t * ) 0x020000b2)
#define PATH_ADDRESS        ( (volatile uint8_t * ) 0x020000d0)
#define IDX_ADDRESS         ( (volatile uint8_t * ) 0x020000ee)
// #define INTEGER_U           ( (volatile uint8_t * ) 0x020000f0)
// #define INTEGER_V           ( (volatile uint8_t * ) 0x020000f4)
#define CURRENT_ADDRESS     ( (volatile uint8_t * ) 0x020000f8)
#define TEMP_ADDRESS        ( (volatile uint8_t * ) 0x020000f2)
#define EDGE_EXIST          ( (volatile uint8_t * ) 0x020000f3)

            int *i   =  (int *)(uintptr_t)INTEGER_I;
            int *j   =  (int *)(uintptr_t)INTEGER_J;
            int *k   =  (int *)(uintptr_t)INTEGER_K;
            int *graph = (int *)(uintptr_t)GRAPH_ADDRESS;
            uint8_t *dist = (uint8_t *)(uintptr_t)DIST_ADDRESS;
            uint8_t *parent = (uint8_t *)(uintptr_t)PAR_ADDRESS;
            uint8_t *path_planned = (uint8_t *)(uintptr_t)PATH_ADDRESS;
            uint8_t *idx = (uint8_t *)(uintptr_t)IDX_ADDRESS;
            // uint8_t *u   =  (uint8_t *)(uintptr_t)INTEGER_U;
            // uint8_t *v   =  (uint8_t *)(uintptr_t)INTEGER_V;
            uint8_t *current   =  (uint8_t *)(uintptr_t)CURRENT_ADDRESS;
            uint8_t *temp   =  (uint8_t *)(uintptr_t)TEMP_ADDRESS;
            uint8_t *edgeExist   =  (uint8_t *)(uintptr_t)EDGE_EXIST;
#endif


    // ############# Add your code here #############
         for ( *i = 0; *i < VERTICES; ++(*i)) {
            graph[*i] = 0;
    }
    

//     // Add edges to the adjacency matrix
// *u = 0, *v = 1;
//  add_edge(graph, u, v);
// *u = 1, *v = 2; 
// add_edge(graph, u, v);
// *u = 1, *v = 29;
//  add_edge(graph, u, v);
// *u = 2, *v = 3;
//  add_edge(graph, u, v);
// *u = 2, *v = 8;
//  add_edge(graph, u, v);
// *u = 3, *v = 4;
//  add_edge(graph,  u,  v);
// *u = 3, *v = 28;
//  add_edge(graph,  u,  v);
// *u = 4, *v = 5;
//  add_edge(graph,  u, v);
// *u = 4, *v = 6;
//  add_edge(graph,  u,  v);
// *u = 6, *v = 7;
//  add_edge(graph,  u, v);
// *u = 7, *v = 8;
//  add_edge(graph,  u,  v);
// *u = 8, *v = 9;
// add_edge(graph,  u,  v);
// *u = 8, *v = 12;
//  add_edge(graph, u, v);
// *u = 9, *v = 10;
// add_edge(graph, u, v);
// *u = 9, *v = 11;
//  add_edge(graph, u, v);
// *u = 12, *v = 13; 
// add_edge(graph, u, v);
// *u = 12, *v = 19;
//  add_edge(graph, u, v);
// *u = 13, *v = 14;
//  add_edge(graph, u, v);
// *u = 14, *v = 15;
//  add_edge(graph, u, v);
// *u = 14, *v = 16;
//  add_edge(graph, u, v);
// *u = 16, *v = 17;
//  add_edge(graph, u, v);
// *u = 16, *v = 18;
//  add_edge(graph, u, v);
// *u = 18, *v = 19;
//  add_edge(graph, u, v);
// *u = 19, *v = 20;
//  add_edge(graph, u, v);
// *u = 20, *v = 21;
//  add_edge(graph, u, v);
// *u = 20, *v = 24;
//  add_edge(graph, u, v);
// *u = 20, *v = 29;
//  add_edge(graph, u, v);
// *u = 21, *v = 22;
//  add_edge(graph, u, v);
// *u = 21, *v = 23;
//  add_edge(graph, u, v);
// *u = 24, *v = 25;
//  add_edge(graph, u, v);
// *u = 25, *v = 26;
//  add_edge(graph, u, v);
// *u = 26, *v = 27;
//  add_edge(graph, u, v);
// *u = 26, *v = 28;
//  add_edge(graph, u, v);
// *u = 28, *v = 29;
//  add_edge(graph, u, v);
 add_edge(graph, 0, 1);
    add_edge(graph, 1, 2);
    add_edge(graph, 1, 29);
    add_edge(graph, 2, 3);
    add_edge(graph, 2, 8);
    add_edge(graph, 3, 4);
    add_edge(graph, 3, 28);
    add_edge(graph, 4, 5);
    add_edge(graph, 4, 6);
    add_edge(graph, 6, 7);
    add_edge(graph, 7, 8);
    add_edge(graph, 8, 9);
    add_edge(graph, 8, 12);
    add_edge(graph, 9, 10);
    add_edge(graph, 9, 11);
    add_edge(graph, 12, 13);
    add_edge(graph, 12, 19);
    add_edge(graph, 13, 14);
    add_edge(graph, 14, 15);
    add_edge(graph, 14, 16);
    add_edge(graph, 16, 17);
    add_edge(graph, 16, 18);
    add_edge(graph, 18, 19);
    add_edge(graph, 19, 20);
    add_edge(graph, 20, 21);
    add_edge(graph, 20, 24);
    add_edge(graph, 20, 29);
    add_edge(graph, 21, 22);
    add_edge(graph, 21, 23);
    add_edge(graph, 24, 25);
    add_edge(graph, 25, 26);
    add_edge(graph, 26, 27);
    add_edge(graph, 26, 28);
    add_edge(graph, 28, 29);


    // _put_str("######### Chk 1 #########\n");

    dijkstra(i,j,k,graph,dist,parent,current,temp,edgeExist, START_POINT, END_POINT, path_planned,idx);
    // _put_str("######### Chk last #########\n");

    // ##############################################

    // the node values are written into data memory sequentially.
    for (*i = 0; *i < *idx;  ++(*i)) {
        NODE_POINT = path_planned[*i];
    }
    // Path Planning Computation Done Flag
    CPU_DONE = 1;

#ifdef __linux__    // for host pc

    _put_str("######### Planned Path #########\n");
    for (int i = 0; i < idx; ++i) {
        _put_value(path_planned[i]);
    }
    _put_str("################################\n");

#endif

    return 0;
}

