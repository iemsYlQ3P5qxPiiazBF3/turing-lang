```
Turing-lang
A small language designed so I don't have to write Turing machines in bash anymore.

It has 13 instructions, only about 11 of which are useful.

B: Begin a new state
 B,a starts a new state called `a`

Q: Query the current cell
 Begin a new conditional statement; and run commands until a .Q (or .B) instruction

.B/.Q: End state/query
 Closes a B/Q statement

R: Right
 Move one cell to the right, add another cell if the current cell is unmarked

L: Left
 Move one cell to the left, add another cell if the current cell is unmarked

W: Write
 Writes 1 byte to the current cell

_A: Accept
 Accept, exit 0

_R: Reject
 Reject, exit 1

S: State
 Run the state S,x
 
#: Comment
 #,Comment_does_nothing

P: Print
 Print everything on the tape

```
