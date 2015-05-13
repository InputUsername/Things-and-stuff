#ifndef _CODESPACE_H
#define _CODESPACE_H

#include <vector>

#include "Point.h"

class CodeSpace {
	public:
		static const char START_CHAR = '$';

		std::vector< std::vector<char> > space;

		CodeSpace(std::string fileName);

		Point findStart();
	};

}

#endif /* ifndef _CODESPACE_H */