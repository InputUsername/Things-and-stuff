#ifndef _MEMORY_H
#define _MEMORY_H

#include <list>

class Memory {
public:
	Memory(int size);

	void left();
	void right();
	char get();
	void set(char value);
	void increment();
	void decrement();

private:
	std::list<char> tape;
	std::list<char>::iterator position;
};

#endif /* ifndef _MEMORY_H */