#ifndef _INTERPRETER_H
#define _INTERPRETER_H

#include <string>
#include <utility>
#include <stack>

#include "Codespace.h"
#include "Memory.h"
#include "InstructionPointer.h"

class Interpreter
{
public:
	Interpreter(std::string fileName, int memorySize);

	void run();

private:
	CodeSpace code;
	Memory memory;
	Point ip;
	enum Direction { Up, Down, Left, Right } direction = Right;
	std::stack< std::pair<Point, Direction> > callStack;

	void step();

	void left();
	void right();
	void increment();
	void decrement();
	void read();
	void write();
	void lurd();
	void ruld();
	void skip();
	void skipz();
	void enter();
	void leave();
};

#endif /* ifndef _INTERPRETER_H */