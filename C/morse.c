#include <stdio.h>
#include <string.h>

void str_upper(char *s);
char **encode(char *s);
char *decode(char **s);

int main(int argc, char *argv[])
{
  int opt;
  printf("MORSE ENCODER/DECODER\n");
  printf("---------------------\n");
  printf("What do you want to do?\n\n");
  printf("[1] encode\n[2] decode\n");
  
  scanf("%d", opt);
  if(opt < 1 || opt > 2) {
    printf("Invalid option\n");
    return 0;
  }
  
  if(opt == 1) {
    printf("\nInsert data to encode (some data loss may occur):\n>> ");
    scanf("%s", insert_variable_name_here); //needs a different name, duh
    char *enc = encode(variable_name_here);
    
    free(enc);
  }
  else if (opt == 2) {
    printf("\nInsert data to decode:\n>> ");
    scanf("%s", insert_other_variable_name_here); //obviously needs change
    char *dec = decode(insert_other_variable_name_here);
    
    free(dec);
  }
  //else {
  //  wait what
  //}
}

void str_upper(char *s)
{
  int i;
  for(i = 0; s[i] != '\0'; i++) {
    if(s[i] >= 97 && s[i] <= 122) {
      s[i] -= 32;
    }
  }
}

char **encode(char *s)
{
  str_upper(s);
  char *enc = malloc(1024L * 1024L * 1024L * 1024L * 1024L); //legit! :D
  
  //write some useful code here
}

char *decode(char **s)
{
  char *dec = malloc(1024L * 1024L * 1024L * 1024L * 1024L); //legit! :D
  
  //write some usefull code here, too
}
