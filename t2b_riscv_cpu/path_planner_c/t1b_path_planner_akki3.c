
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

// This function adds an edge to the adjacency matrix
void add_edge(bool **matrix, int u, int v) {
    // Update the value at matrix[u][v] and matrix[v][u] to 1
    matrix[u][v] = 1;
    matrix[v][u] = 1;
}


// Function to find the vertex with the minimum distance value
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

// Function to print the shortest path from start to end and store it in path_planned
void findShortestPath(uint8_t parent[], int end, uint8_t path_planned[], uint8_t* idx) {
    if (parent[end] == -1) {
        path_planned[(*idx)++] = end;
        return;
    }

    findShortestPath(parent, parent[end], path_planned, idx);
    path_planned[(*idx)++] = end;
}

// Function to find and print the shortest path using Dijkstra's algorithm
void dijkstra(bool **graph, int start, int end, uint8_t path_planned[], uint8_t* idx) {
    uint8_t dist[VERTICES];  // Array to store the shortest distances from src to i
    // bool visited[VERTICES];
    uint8_t parent[VERTICES];  // Array to store the parents in the shortest path


    // Initialize all distances as INFINITE and no parent
    for (int i = 0; i < VERTICES; i++) {
        dist[i] = INT_MAX;
        parent[i] = -1;
    }

    // Distance from source to itself is always 0
    dist[start] = 0;

    // Find the shortest path for all vertices
    for (int count = 0; count < VERTICES - 1; count++) {
        // Pick the minimum distance vertex from the set of vertices not yet processed.
        // u is always equal to src in the first iteration.
        int u, min_dist = INT_MAX;
        for (int v = 0; v < VERTICES; v++)
            if (dist[v] < min_dist && dist[v] != -1) {
                min_dist = dist[v];
                u = v;
            }

        // Mark the picked vertex as processed
        dist[u] = -1;

        // Update dist[v] if there is a shorter path through u
        for (int v = 0; v < VERTICES; v++) {
            // Update dist[v] only if it's not in the shortest path tree,
            // there is an edge from u to v, and the total weight of path from src to v through u is smaller
            if (dist[v] != -1 && graph[u][v] && dist[u] != INT_MAX && dist[u] + graph[u][v] < dist[v]) {
                dist[v] = dist[u] + graph[u][v];
                parent[v] = u;
            }
        }
    }

    (*idx) = 0; // Initialize the path length
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
    uint8_t idx = 0;

    // ############# Add your code here #############

    bool **graph = (bool**)calloc(VERTICES, sizeof(bool*));
    for (int i = 0; i < VERTICES; ++i) {
        graph[i] = (bool*)calloc(VERTICES, sizeof(bool));
    }

    // Copy values from the statically defined array to the dynamically allocated array
    // for (int i = 0; i < VERTICES; ++i) {
    //     for (int j = 0; j < VERTICES; ++j) {
    //         graph[i][j] = (bool)graph_data[i][j];
    //     }
    // }

    // Add edges to the adjacency matrix
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

    dijkstra(graph, START_POINT, END_POINT, path_planned, &idx);


    // for deallocating the memory
    for (int i = 0; i < VERTICES; ++i) {
        free(graph[i]);
    }
    free(graph);


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

