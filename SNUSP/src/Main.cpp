#include <iostream>
#include <string>

#include "Interpreter.h"

void usage(char *argv0) {
	std::cerr << "Usage: " << argv0 << "[-m] <file>" << std::endl;
	std::cerr << "-m enables Modular SNUSP, providing the @ and # instructions" << std::endl;
}

void parseArgs(int argc, char* argv[], bool& useModular, std::string& fileName) {
	if (argc == 2) {
		fileName = argv[1];
	}
	else if (argc >= 3) {
		if (argv[1] == "-m") {
			useModular = true;
			fileName = argv[2];
		}
		else if (argv[2] == "-m") {
			useModular = true;
			fileName = argv[1];
		}
	}
}

int main(int argc, char *argv[]) {
	if (argc < 2) {
		usage(argv[0]);
	}

	bool useModular = false;
	std::string fileName;

	// useModular and fileName are passed by reference
	parseArgs(argc, argv, useModular, fileName);

	Interpreter interpreter(fileName, useModular);
	
	try {
		interpreter.run();
	}
	catch (std::exception e) {
		std::cout << e.what() << std::endl;
	}

	return 0;
}