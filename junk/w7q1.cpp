#include <bits/stdc++.h>

#define SIZE 10

using namespace std;

map<char, bool> visited;
class Node
{
	public:
	char tname;
	string nxt, prev;

	Node(char tn='\0', string n="", string p="") {
		this->tname = tn;
		this->nxt = n;
		this->prev = p;
	}
};


int main() {
	char R[] = {'E','F','G','H','I','J','K','L','M','N'};
	map<char, Node> stuff;

	for (int i = 0; i < SIZE; i++)
	{
		stuff[R[i]].tname = R[i];
		visited[R[i]] = false;
	}

	//** <Relations> */
	// E,F -> G
	stuff['E'].nxt.push_back('G');
	stuff['F'].nxt.push_back('G');
	stuff['G'].prev.push_back('E');
	stuff['G'].prev.push_back('F');
	// F -> I,J
	stuff['F'].nxt.push_back('I');
	stuff['F'].nxt.push_back('J');
	stuff['I'].prev.push_back('F');
	stuff['J'].prev.push_back('F');
	// E,H -> K,L
	stuff['E'].nxt.push_back('K');
	stuff['E'].nxt.push_back('L');
	stuff['H'].nxt.push_back('K');
	stuff['H'].nxt.push_back('L');
	stuff['K'].prev.push_back('E');
	stuff['K'].prev.push_back('H');
	stuff['L'].prev.push_back('E');
	stuff['L'].prev.push_back('H');
	// K -> M
	stuff['K'].nxt.push_back('M');
	stuff['M'].prev.push_back('K');
	// L -> N
	stuff['L'].nxt.push_back('N');
	stuff['N'].nxt.push_back('L');
	//** </Relations> */

	//** Find Key(s) */

	/**
	 * To find keys, we just have to traverse `prev` for each letter
	 * in char array `R`, DFS and mark visited nodes along the way.
	 * 
	 * Whichever unvisited nodes do not have any prev is to be
	 * appended with answer.
	 * 
	 * e.g this question should return 'EFH', since none have any `prev` nodes.
	 */


	return 0;
}