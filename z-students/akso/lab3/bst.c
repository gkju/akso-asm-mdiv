#include <stdlib.h>
#include <stdio.h>

struct Node;
typedef struct Node Node;
typedef Node* Tree;

struct Node {
  int value;
  Tree left, right;
};


void insert(Tree *treePtr, int x) {
  if(!(*treePtr)) {
    *treePtr = malloc(sizeof(Node));
    (*treePtr)->value = x;
    (*treePtr)->left = NULL;
    (*treePtr)->right = NULL;
    return;
  }

  Tree tree = *treePtr;

  if(tree->left && tree->left->value >= x) {
    insert(&(tree->left), x);
    return;
  } else if(tree->right && tree->right->value <= x) {
    insert(&(tree->right), x);
    return;
  }

  if(tree->value == x) {
    return;
  }

  Tree newNode = malloc(sizeof(Node));
  newNode->value = x;
  newNode->left = NULL;
  newNode->right = NULL;

  if(tree->value > x) {
    Tree oldLeft = tree->left;
    tree->left = newNode;
    newNode->left = oldLeft;
  } else if(tree->value < x) {
    Tree oldRight = tree->right;
    tree->right = newNode;
    newNode->right = oldRight;
  }
}

void printAll(Tree t) {
  if(!t) {
    return;
  }

  printAll(t->left);
  printf("%d\n", t->value);
  printAll(t->right);
}

void removeAll(Tree t) {
  if(!t) {
    return;
  }

  removeAll(t->left);
  removeAll(t->right);
  free(t);
}

int main() {
  int input;
  Tree tree;
  while(scanf("%d", &input) == 1) {
    insert(&tree, input);
  }

  printAll(tree);
  removeAll(tree);
}
