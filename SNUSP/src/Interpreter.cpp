#include <iostream>
#include <string>
#include <utility>

#include "Interpreter.h"
#include "CodeSpace.h"

Interpreter::Interpreter(std::string fileName, int memorySize)
	: code(fileName),
	memory(memorySize),
	ip(code.findStart()),
	direction(Right) {}

void Interpreter::run() {
	while (ip.x >= 0 && ip.x <= code.width && ip.y >= 0 && ip.y <= code.height) {
		char command = code.at(ip);

		switch (command) {
		case '<': left(); break;
		case '>': right(); break;
		case '+': increment(); break;
		case '-': decrement(); break;
		case ',': read(); break;
		case '.': write(); break;
		case '\\': lurd(); break;
		case '/': ruld(); break;
		case '!': skip(); break;
		case '?': skipz(); break;
		case '@': enter(); break;
		case '#': leave(); break;
		default: break;
		}

		step();
	}
}

void Interpreter::step() {
	switch (direction) {
	case Up:	--ip.y; break;
	case Down:	++ip.y; break;
	case Left:	--ip.x; break;
	case Right:	++ip.x; break;
	default: break;
	}
}

void Interpreter::left() {
	memory.left();
}
void Interpreter::right() {
	memory.right();
}
void Interpreter::increment() {
	memory.increment();
}
void Interpreter::decrement() {
	memory.decrement();
}
void Interpreter::read() {
	char input;
	std::cin.get(input);
	memory.set(input % 256);
}
void Interpreter::write() {
	char output = memory.get();
	std::cout << output;
}
void Interpreter::lurd() {
	switch (direction) {
	case Up:	direction = Left; break;
	case Down:	direction = Right; break;
	case Left:	direction = Up; break;
	case Right: direction = Down; break;
	default: break;
	}
}
void Interpreter::ruld() {
	switch (direction) {
	case Up:	direction = Right; break;
	case Down:	direction = Left; break;
	case Left:	direction = Down; break;
	case Right:	direction = Up; break;
	default: break;
	}
}
void Interpreter::skip() {
	step();
}
void Interpreter::skipz() {
	if (memory.get() == 0) {
		step();
	}
}
void Interpreter::enter() {
	//TODO: finish
}
void Interpreter::leave() {
	//TODO: finish
}