package com.dstrube.random;

/*
commands to compile and run:
from ~/java
javac -cp bin:bin/gson-2.8.5.jar -d bin com/dstrube/random/RandomOrgTest.java 
java -cp bin:bin/gson-2.8.5.jar com.dstrube.random.RandomOrgTest
*/

import com.google.gson.Gson;

import org.random.api.RandomOrgClient;

public class RandomOrgTest {
	private static RandomOrgClient client;

	/////////////////////////////////////////////////////////////////////////////////////
	private static final String API_KEY_1 = "YOUR_API_KEY_HERE";//TODO Do not leave my key here
	/////////////////////////////////////////////////////////////////////////////////////
	
	public static void main(String[] args){

		client = RandomOrgClient.getRandomOrgClient(API_KEY_1, 3000, 120000, false);
//		client = RandomOrgClient.getRandomOrgClient(API_KEY_1);
		System.out.println("getBitsLeft: " + client.getBitsLeft());
		System.out.println("getRequestsLeft: " + client.getRequestsLeft());
		
		//https://github.com/RandomOrg/JSON-RPC-Java/blob/master/RandomJSONRPC/src/org/random/test/RandomOrgClientBasicTest.java
		//https://api.random.org/json-rpc/2
	}
}
