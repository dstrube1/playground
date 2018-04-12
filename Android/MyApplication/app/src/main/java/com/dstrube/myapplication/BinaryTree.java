package com.dstrube.myapplication;

/**
 * An object of type BinaryTree represents one node in a binary tree of ints.
 */
public class BinaryTree {

    int item;      // The data in this node.
    BinaryTree left;    // Pointer to left subtree.
    BinaryTree right;   // Pointer to right subtree.

    BinaryTree(final int item) {
        // Constructor.  Make a node containing the specified int.
        // Note that left and right pointers are initially null.
        this.item = item;
    }

}
