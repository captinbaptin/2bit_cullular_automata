# 2bit_cullular_automata
This code randomly generates a 2 bit per cell cellular automaton.
A 'ruleset' is generated consisting of 2^18 2 bit values (although they are stored as bytes).
Cells are iterated by reading the 3x3 pixel square around the cell as an 18 bit number and then setting the cell to that index of the ruleset.
Edge cells loop around so there are no differences at the edges.
Press space to generate a new ruleset.
Press r to randomly reinitialize the cells.


![cela1](https://user-images.githubusercontent.com/34765546/211407579-a319df7f-527d-4b5c-8c2e-e24aa793019b.png)
![cela2](https://user-images.githubusercontent.com/34765546/211407581-9bd91999-f541-4330-bf24-6baef1065f2b.png)
