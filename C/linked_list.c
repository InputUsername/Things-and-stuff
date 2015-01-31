#include <stddef.h>
#include <stdlib.h>

#define Node struct linkedlist_node

/*
 * The Node struct type
 */
struct linkedlist_node {
	int data;
	Node* next;
};

/*
 * creates a new node for a linked list.
 */
Node* linkedlist_new(int data)
{
	Node* root = (Node*)malloc(sizeof(Node));

	if (!root || root == NULL) return NULL;

	root->data = data;
	root->next = 0;

	return root;
}

/*
 * free()'s the entire linked list starting at the root node
 */
void linkedlist_free(Node* root)
{
	Node* current_node = root;
	Node* next_node = root->next;
	while (next_node && next_node != NULL) {
		free(current_node);
		current_node = next_node;
		next_node = current_node->next;
	}
}

/*
 * Inserts a new node after another node
 */
void linkedlist_insert(Node* after_node, int data)
{
	// create a new node
	Node* new_node = linkedlist_new(data);

	// error checking
	if (!new_node || new_node == NULL) return;

	// the node we are trying to insert an item after is the last in the chain
	if (after_node->next == 0) {
		// simply set its next pointer
		after_node->next = new_node;
	}
	// the node we are trying to insert an item after is not the last in the chain
	else {
		// store the node (before_node), before which we will insert an item
		// then insert the item and correctly set its next pointer to the before_node
		Node* before_node = after_node->next;
		after_node->next = new_node;
		new_node->next = before_node;
	}
}

/*
 * Removes the node that comes after 'node'
 */
void linkedlist_remove(Node* node)
{
	Node* to_be_removed = node->next;
	node->next = to_be_removed->next;
	free(to_be_removed);
}
