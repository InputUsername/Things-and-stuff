#include <filesystem>

#include "CodeSpace.h"

CodeSpace::CodeSpace(std::string fileName)
{
	namespace fs = std::tr2::sys;

	fs::path pathName(fileName);
	if (!fs::exists(pathName))
	{
		throw std::exception("file not found");
	}

	std::ifstream inputFile(pathName);
	std::string line;
	while (std::getline(inputFile, line)) {
		
	}
}