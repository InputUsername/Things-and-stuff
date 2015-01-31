#ifndef __DYNAMIC_ARRAY_H
#define __DYNAMIC_ARRAY_H 1

// Dynamic integer array
void initArray(IntArray* a, size_t initialSize);
void insertArray(IntArray* a, int element);
void freeArray(IntArray* a);

// Dynamic char array
void initArray(CharArray* a, size_t initialSize);
void insertArray(CharArray* a, char element);
void freeArray(CharArray* a);

#endif
