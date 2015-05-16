#include <list>

#include "Memory.h"

Memory::Memory(int size)
	: tape(size, 0),
	position(tape.begin()) {}

void Memory::left() {
	if (position != tape.begin()) {
		position--;
	}
	else {
		position = tape.end();
	}
}

void Memory::right() {
	if (position != tape.end()) {
		position++;
	}
	else {
		position = tape.begin();
	}
}

char Memory::get() {
	// dereference iterator to return value
	return *position;
}

void Memory::set(char value) {
	*position = value % 256;
}

void Memory::increment() {
	*position = (*position + 1) % 256;
}

void Memory::decrement() {
	*position = (*position - 1) % 256;
}