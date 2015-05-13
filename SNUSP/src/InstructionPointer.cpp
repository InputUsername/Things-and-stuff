#include "InstructionPointer.h"
#include "Point.h"

InstructionPointer::InstructionPointer(int x, int y) {
	Point position(x, y);
}

void InstructionPointer::step() {
	switch (direction) {
	case Up:
		position.y--;
		break;
	case Down:
		position.y++;
		break;
	case Left:
		position.x--;
		break;
	case Right:
		position.x++;
		break;
	default:
		break;
	}
}

void InstructionPointer::turn(Direction newDirection) {
	direction = newDirection;
}