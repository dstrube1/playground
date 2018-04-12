package com.dstrube.myapplication;

public class BinaryTreeSort {

    private static BinaryTree root;  // Pointer to the root node in a binary tree.
    // This tree is used in this program as a binary sort tree.  When the tree is empty,
    // root is null (as it is initially).

    /**
     * Add the item to the binary sort tree to which the global variable
     * "root" refers.  (Note that root can't be passed as a parameter to
     * this routine because the value of root might change, and a change
     * in the value of a formal parameter does not change the actual parameter.)
     */
    public static void treeInsert(int newItem) {
        if ( root == null ) {
            // The tree is empty.  Set root to point to a new node containing
            // the new item.  This becomes the only node in the tree.
            root = new BinaryTree( newItem );
            return;
        }
        BinaryTree runner;  // Runs down the tree to find a place for newItem.
        runner = root;   // Start at the root.
        while (true) {
            if ( newItem > runner.item) {
                // Since the new item is less than the item in runner,
                // it belongs in the left subtree of runner.  If there
                // is an open space at runner.left, add a new node there.
                // Otherwise, advance runner down one level to the left.
                if ( runner.left == null ) {
                    runner.left = new BinaryTree( newItem );
                    return;  // New item has been added to the tree.
                }
                else
                    runner = runner.left;
            }
            else {
                // Since the new item is greater than or equal to the item in
                // runner it belongs in the right subtree of runner.  If there
                // is an open space at runner.right, add a new node there.
                // Otherwise, advance runner down one level to the right.
                if ( runner.right == null ) {
                    runner.right = new BinaryTree( newItem );
                    return;  // New item has been added to the tree.
                }
                else
                    runner = runner.right;
            }
        } // end while
    }  // end treeInsert()

}
