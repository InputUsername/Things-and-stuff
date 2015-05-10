#ifndef _CODESPACE_H
#define _CODESPACE_H

#include <vector>

class CodeSpace
{
public:
	std::vector< std::vector<char> > space;
	
	CodeSpace(std::string fileName);

private:
	std::vector< std::vector<char> > readFile(std::string fileName);
};

#endif /* ifndef _CODESPACE_H */