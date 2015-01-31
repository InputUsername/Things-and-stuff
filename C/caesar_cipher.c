#include <stdio.h>
#include <ctype.h>
#include <string.h>

int get_rotation();
int is_upper(char c);
void cipher(char str[], int length, int amount);

int main(int argc, char* argv[])
{
	if (argc == 0) {
		printf("Whoops! Something went wrong.");
	}
	if (argc == 1) {
		printf(
			"Caesar Cipher Program\n"
			"Insert the text to encode/decode (at most 100 characters):\n"
			"> "
		);

		char input[101];
		int input_length = 0;
		char c;

		while ((input_length++) < 100) {
			c = getchar();
			if (c == EOF) {
				printf("Error: STDIN end-of-file");
				return 0;
			}
			else if (c == '\n') {
				break;
			}
			input[input_length] = c;
		}
		input[input_length] = '\0';

		int cipher_amount = get_rotation();

		cipher(input, input_length, cipher_amount);
		printf("Result: %s\n", input);
	}
	else {
		int cipher_amount = get_rotation();

		int i;
		for (i = 1; i < argc; ++i) {
			cipher(argv[i], strlen(argv[i]), cipher_amount);
			printf("%s\n", argv[i]);
		}
	}

	return 0;
}

int get_rotation()
{
	printf(
		"Insert the rotation amount:\n"
		"> "
	);

	int cipher_amount;
	int result = scanf("%d", &cipher_amount);

	if (result == EOF) {
		printf("Error: STDIN end-of-file");
		return 0;
	}
	else if (result == 0) {
		printf("Error: invalid input");
		return 0;
	}

	return cipher_amount;
}

int is_upper(char c) {
	return (c >= 'A' && c <= 'Z');
}

char* cipher(char str[], int length, int amount)
{
	char result = ;//bleh TODO shit kl;jasfdasdfkaskl;dfjal;skdjfkl;adfjkjklasdfjklsdfjkl I hate C

	// amount must always be between 0 and 26
	if (amount < 0 || amount > 26) amount %= 27;

	int i;
	char c;
	for (i = 0; i < length; ++i) {
		c = str[i];

		if (isalpha(c)) {
			c += amount;

			if (is_upper(c)) {
				c -= 'A';
				c %= 26;
				c += 'A';
			}
			else {
				c -= 'a';
				c %= 26;
				c += 'a';
			}

			result[i] = c;
		}
	}

	result[length + 1] = '\0';
	return result;
}
