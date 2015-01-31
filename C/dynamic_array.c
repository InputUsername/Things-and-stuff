#include "dynamic_array.h"

struct _arr {
	char *array;
	size_t used;
	size_t size;
};

void initArray(Array *a, size_t initialSize)
{
	if (a == NULL || !a) return;

	a->array = (char *)malloc(initialSize * sizeof(char));

	if (a->array == NULL || !a->array) return;

	a->used = 0;
	a->size = initialSize;
}

void insertArray(Array *a, char element)
{
	if (a == NULL || !a) return;

	if (a->used == a->size) {
		a->size *= 2;
		a->array = (char *)realloc(a->array, a->size * sizeof(char));
	}
	a->array[a->used++] = element;
}

void freeArray(Array *a)
{
	if (a == NULL || !a) return;

	free(a->array);
	a->array = NULL;
	a->used = 0;
	a->size = 0;
}
