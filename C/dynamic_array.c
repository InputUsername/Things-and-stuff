#include "dynamic_array.h"

/**************************
 * Dynamic integer array
 **************************/
typedef struct {
	int *array;
	size_t used;
	size_t size;
} IntArray;

void initArray(CharArray *a, size_t initialSize)
{
	if (a == NULL || !a) return;

	a->array = (int *)malloc(initialSize * sizeof(int));

	if (a->array == NULL || !a->array) return;

	a->used = 0;
	a->size = initialSize;
}

void insertArray(CharArray *a, int element)
{
	if (a == NULL || !a) return;

	if (a->used == a->size) {
		a->size *= 2;
		a->array = (int *)realloc(a->array, a->size * sizeof(int));
	}
	a->array[a->used++] = element;
}

void freeArray(IntArray *a)
{
	if (a == NULL || !a) return;

	free(a->array);
	a->array = NULL;
	a->used = 0;
	a->size = 0;
}

/**************************
* Dynamic char array
**************************/

typedef struct {
	char *array;
	size_t used;
	size_t size;
} CharArray;

void initArray(CharArray *a, size_t initialSize)
{
	if (a == NULL || !a) return;

	a->array = (char *)malloc(initialSize * sizeof(char));

	if (a->array == NULL || !a->array) return;

	a->used = 0;
	a->size = initialSize;
}

void insertArray(CharArray *a, char element)
{
	if (a == NULL || !a) return;

	if (a->used == a->size) {
		a->size *= 2;
		a->array = (char *)realloc(a->array, a->size * sizeof(char));
	}
	a->array[a->used++] = element;
}

void freeArray(CharArray *a)
{
	if (a == NULL || !a) return;

	free(a->array);
	a->array = NULL;
	a->used = 0;
	a->size = 0;
}
