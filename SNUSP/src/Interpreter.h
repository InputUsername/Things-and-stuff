#ifndef _INTERPRETER_H
#define _INTERPRETER_H

#include <string>

#include "Codespace.h"
#include "InstructionPointer.h"

class Interpreter
{
public:
	Interpreter(std::string fileName, bool useModular);

	void run();

private:
	CodeSpace code;
	Point ip;
	enum { Up, Down, Left, Right } direction;
	bool useModular;
};

#endif /* ifndef _INTERPRETER_H */