#ifndef _CODESPACE_H
#define _CODESPACE_H

#include <ostream>
#include <vector>

#include "Point.h"

class CodeSpace {
public:
	static const char START_CHAR = '$';

	std::vector< std::vector<char> > space;
	int width, height;

	CodeSpace(std::string fileName);

	Point findStart();
	char at(int x, int y);
	char at(Point position);
	void show(std::ostream& stream);
};

#endif /* ifndef _CODESPACE_H */