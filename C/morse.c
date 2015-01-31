/*
 * MORSE ENCODER/DECODER
 * (c) 2015 InputUsername
 *
 * Have fun reading this terrible mess of comment-less,
 * standard-disobeying, memory-leaking, terribly-coded
 * program of doom.
 *
 * I am not responsible this code makes your eyes bleed.
 *
 */

#include <stdio.h>
#include <string.h>
#include <stddef.h>

#define CHAR_SIZE sizeof(char)
#define ALPHABET_SIZE 50

const char* ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,?!-/:');(=@&";
const char** MORSE = {
    ".-", "-...", "-.-.", "-..", ".", //A-E
    "..-.", "--.", "....", "..", ".---", //F-J
    "-.-", ".-..", "--", "-.", "---", //K-O
    ".--.", "--.-", ".-.", "...", "-", //P-T
    "..-", "...-", ".--", "-..-", "-.--", //U-Y
    "--..", "-----", ".----", "..---", "...--", //Z, 0-3
    "....-", ".....", "-....", "--...", "---..", //4-8
    "----.", ".-.-.-", "--..--", "..--..", "-.-.--", //9 . , ? !
    "-....-", "-..-.", "---...", ".----.", "-.--.-", //- / : ' )
    "-.-.-", "-.--.", "-...-", ".--.-.", ".–..." //; ( = @ &
}

int array_search(const char array[], int size, char elem);
int array_search_str(const char array[][], int size, const char[] str);

char* encode(char* text);
char* decode(char* text);

char main_menu(void);
void encode_menu(void);
void decode_menu(void);

int main(int argc, char *argv[])
{
    int running = 1;
    char input;

    while (running) {
        input = main_menu();

        switch (input) {
            case '1':
                encode_menu();
                break;
            case '2':
                decode_menu();
                break;
            case '3':
                running = 0;
                break;
        }
    }
}

int array_search(const char[] array, int size, char elem)
{
    int i;
    for (i = 0; i < size; ++i) {
        if (array[i] == elem) return i;
    }
    return -1;
}
int array_search_str(const char[][] array, int size, const char[] str)
{
    int i;
    for (i = 0; i < size; ++i) {
        if (strcmp(array[i], str) == 0) return i;
    }
    return -1;
}

// encode a string
char* encode(const char text[], int length)
{
    char* encoded = (char *) malloc((6 * length * CHAR_SIZE) + CHAR_SIZE);

    int i;
    int c_pos;
    for (i = 0; i < size; ++i) {
        c_pos = array_search(ALPHABET, ALPHABET_SIZE, tolower(text[i]));

        if (c_pos == -1) {
            strcat(encoded, "?");
        }
        else {
            strcat(encoded, MORSE[c_pos]);
        }
    }

    return encoded;
}

// decode a string
char* decode(const char text[][], int length)
{
    char* decoded = (char *) malloc((length * CHAR_SIZE) + CHAR_SIZE);

    int i;
    int c_pos;
    for (i = 0; i < length; ++i) {
        c_pos = array_search_string(MORSE, ALPHABET_SIZE, text[i]);

        if (c_pos == -1) {
            strcat(decoded, "?");
        }
        else {
            char[2] char_str = {ALPHABET[c_pos], '\0'};
            strcat(decoded, char_str);
        }
    }

    return decoded;
}

char main_menu(void)
{
    char input;

    printf(
        "MORSE ENCODER/DECODER v1.0\n"
        "     By InputUsername     \n"
        "--------------------------\n"
        "Select an option:\n"
        "1) encode\n"
        "2) decode\n"
        "3) exit\n"
        "\n"
    );

    while (input = getchar(); input != '1' && input != '2' && input != '3');
    return input;
}

void encode_menu(void)
{
    printf(
        "ENCODE TEXT\n"
        "-----------\n"
        "Insert text to encode:\n"
        "> "
    );

    // TODO finish this shit
}

void decode_menu(void)
{
    printf(
        "DECODE TEXT\n"
        "-----------\n"
        "Insert text to decode:\n"
        "> "
    );
    // TODO finish this shit too
}
