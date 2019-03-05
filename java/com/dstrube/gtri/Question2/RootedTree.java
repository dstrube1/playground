/*
Author: David Strube
Date: 2019-03-02

This defines a data structure to represent a rooted tree like this one:

              C
            / | \
           /  |  \
          E   F   S
         / \     / \
        H   B   P   D

The data structure supports trees of any size.

*/

package com.dstrube.gtri;

public class RootedTree
{

	public Node root;

	public RootedTree()
	{
		root  = null;
	}
	
}
