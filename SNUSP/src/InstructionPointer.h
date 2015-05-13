#ifndef _INSTRUCTION_POINTER_H
#define _INSTRUCTION_POINTER_H

#include "Point.h"

class InstructionPointer {
public:
	enum Direction {
		Up,
		Down,
		Left,
		Right
	};

	Point position;
	Direction direction;

	InstructionPointer(int x, int y);

	void step();
	void turn(Direction newDirection);
};

#endif /* ifndef _INSTRUCTION_POINTER_H */