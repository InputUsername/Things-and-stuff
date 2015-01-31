#ifndef __DYNAMIC_ARRAY_H
#define __DYNAMIC_ARRAY_H 1

typedef struct _arr Array;

void initArray(Array* a, size_t initialSize);
void insertArray(Array *a, char element);
void freeArray(Array *a);

#endif
