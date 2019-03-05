/*
Author: David Strube
Date: 2019-03-02

This defines a data structure to represent a node of a rooted tree like this one:

              C
            / | \
           /  |  \
          E   F   S
         / \     / \
        H   B   P   D

The data structure supports trees of any size.
*/

package com.dstrube.gtri;

import java.util.ArrayList;
import java.util.List;

public class Node
{

	public String name;
	public List<Node> children;

	public Node(final String name)
	{
		this.name = name;
		children = new ArrayList<>();
	}
	
}
