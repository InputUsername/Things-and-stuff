#include <iostream>
#include <string>
#include <exception>

#include "Interpreter.h"

#define MEMORY_SIZE 250

void usage(char *argv0) {
	std::cerr << "Usage: " << argv0 << " <file>" << std::endl;
}

int main(int argc, char *argv[]) {
	if (argc != 2) {
		usage(argv[0]);

		return 1;
	}

	std::string fileName(argv[1]);

	Interpreter interpreter(fileName, MEMORY_SIZE);
	
	try {
		interpreter.run();
	}
	catch (std::exception e) {
		std::cerr << e.what() << std::endl;

		return 1;
	}

	return 0;
}