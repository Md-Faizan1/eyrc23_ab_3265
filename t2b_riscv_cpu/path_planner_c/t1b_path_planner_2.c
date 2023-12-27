
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
#include <limits.h>

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
int heuristic(int current, int end) {
    // You need to define a heuristic function here.
    // It should estimate the cost from the current node to the end node.
    // This function should be admissible, meaning it should never overestimate the cost.
    // The heuristic function can be Manhattan distance, Euclidean distance, etc.
    // For simplicity, let's use Euclidean distance here.
    return static_cast<int>(sqrt(pow((current % 5) - (end % 5), 2) + pow((current / 5) - (end / 5), 2)));
}

int minDistance(int dist[], bool visited[]) {
    int min = INT_MAX, min_index;

    for (int v = 0; v < VERTICES; v++) {
        if (!visited[v] && dist[v] < min) {
            min = dist[v];
            min_index = v;
        }
    }

    return min_index;
}

void findShortestPath(int parent[], int end, uint8_t path_planned[], uint8_t* idx) {
    if (parent[end] == -1) {
        path_planned[(*idx)++] = end;
        return;
    }

    findShortestPath(parent, parent[end], path_planned, idx);
    path_planned[(*idx)++] = end;
}

void astar(bool graph[][VERTICES], int start, int end, uint8_t path_planned[], uint8_t* idx) {
    int dist[VERTICES];
    bool visited[VERTICES];
    int parent[VERTICES];

    for (int i = 0; i < VERTICES; i++) {
        dist[i] = INT_MAX;
        visited[i] = false;
        parent[i] = -1;
    }

    dist[start] = 0;

    for (int count = 0; count < VERTICES - 1; count++) {
        int u = minDistance(dist, visited);
        visited[u] = true;

        for (int v = 0; v < VERTICES; v++) {
            if (!visited[v] && graph[u][v] && dist[u] != INT_MAX && dist[u] + graph[u][v] < dist[v]) {
                dist[v] = dist[u] + graph[u][v] + heuristic(v, end);
                parent[v] = u;
            }
        }
    }

    (*idx) = 0;
    findShortestPath(parent, end, path_planned, idx);
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

#endif

    // array to store the planned path
    uint8_t path_planned[32];
    // index to keep track of the path_planned array
    uint8_t idx = 5;

    // ############# Add your code here #############


  bool graph[VERTICES][VERTICES] = {

     //  0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29
        {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

        {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},


        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},

        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0},

        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
        {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0},

    };

    // _put_str("######### Chk 1 #########\n");

   astar(graph, START_POINT, END_POINT, path_planned, &idx);

    // _put_str("######### Chk last #########\n");

    // ##############################################

    // the node values are written into data memory sequentially.
    for (int i = 0; i < idx; ++i) {
        NODE_POINT = path_planned[i];
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

