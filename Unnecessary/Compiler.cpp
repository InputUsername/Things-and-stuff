#include <iostream>
#include <fstream>
#include <string>

// TR2
#include <filesystem>

int main(int argc, char *argv[]) {
	if (argc < 1) {
		std::cout << "Usage: " << argv[0] << " <file>" << std::endl;
		return 1;
	}

	namespace fs = std::tr2::sys;

	std::string pathName(argv[1]);
	std::string cppFilePath(pathName + ".cpp");
	std::string exeFilePath(pathName + ".exe");

	if (fs::exists(fs::path(pathName))) {
		std::cout << "Error: file exists." << std::endl;
		return 2;
	}

	std::string cppFileContent("int main() { return 0; }");
	std::ofstream cppFileStream(cppFilePath);
	cppFileStream << cppFileContent << std::endl;

	std::string command("g++ " + cppFilePath + "-o " + exeFilePath);

	system(command.c_str());

	return 0;
}
