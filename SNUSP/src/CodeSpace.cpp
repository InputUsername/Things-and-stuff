#include <filesystem>
#include <string>
#include <ostream>

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
		int len = line.length();
		if (len > width) width = len;
		
		++height;
	}

	inputFile.clear();
	inputFile.seekg(0, std::ios::beg);

	while (std::getline(inputFile, line)) {
		//fill the line with spaces if it isn't as wide as the code space's width
		int amount = width - line.length();
		if (amount > 0) {
			line += std::string(amount, ' ');
		}

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
				return Point(col - row->begin(), row - space.begin());
			}
		}
	}

	return Point(0, 0);
}

char CodeSpace::at(int x, int y) {
	return space[y][x];
}
char CodeSpace::at(Point position) {
	return space[position.y][position.x];
}

void CodeSpace::show(std::ostream& stream) {
	for (int row = 0; row < height; ++row) {
		for (int col = 0; col < width; ++col) {
			stream << at(col, row);
		}
		stream << std::endl;
	}
}