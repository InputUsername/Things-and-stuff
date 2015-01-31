#include <stdlib.h>

typedef struct {
	int what_is_happening;
} thing;

int main(int argc, char* argv[])
{
	thing* Willy = malloc(sizeof(test));
	free(Willy); // I've always wanted to do this

	return 0;
}
