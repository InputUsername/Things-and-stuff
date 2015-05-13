#include <iostream>
#include <string>

#include "Interpreter.h"

void usage(char *argv0) {
	std::cerr << "Usage: " << argv0 << "[-m] <file>" << std::endl;
	std::cerr << "-m enables Modular SNUSP, providing the @ and # instructions" << std::endl;
}

int main(int argc, char *argv[]) {
	if (argc < 2) {
		usage();
	}

	bool useModular = false;
	std::string

	if (argc == 3) {
		if (argv[1] == "-m") {
			useModular = true;
		}
	}

	Interpreter interpreter(fileName, useModular);
	
	try {
		interpreter.run();
	}
	catch (std::exception e) {
		std::cout << e.what() << std::endl;
	}

	return 0;
}