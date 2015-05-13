#include <filesystem>

#include "CodeSpace.h"
#include "Point.h"

CodeSpace::CodeSpace(std::string fileName) {
	namespace fs = std::tr2::sys;

	fs::path pathName(fileName);
	if (!fs::exists(pathName)) {
		throw std::exception("file not found");
	}

	std::ifstream inputFile(pathName);
	std::string line;
	while (std::getline(inputFile, line)) {
		//NOTE: maybe dynamically allocate?

		std::vector<char> lineChars(line.begin(), line.end());
		space.push_back(lineChars);
	}
}

Point CodeSpace::findStart() {
	std::vector< std::vector<char> >::iterator row;
	std::vector<char>::iterator col;
	
	for (row = space.begin(); row != space.end(); ++row) {
		for (col = row->begin(); col < row->end(); ++col) {
			if (*col == START_CHAR) {
				
			}
		}
	}
}