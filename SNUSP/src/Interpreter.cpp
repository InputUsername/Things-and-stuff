#include "Interpreter.h"
#include "CodeSpace.h"

Interpreter::Interpreter(std::string fileName, bool modular)
	: code(fileName),
	ip(code.findStart()),
	direction(Right),
	useModular(useModular) {}