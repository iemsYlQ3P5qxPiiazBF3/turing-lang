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
 #,Comment_does_nothing. You can also write anything that isn't a command and it's a comment.

P: Print
 Print everything on the tape

T: Tape
 The tape/input. Split by 1s (001010 -> 0 0 1 0 1 0). Do not add spaces.
```

```
Syntax:

Commands are separated by the semicolon, space, or newline.
arguments are separated by a comma.

examples:

T,0101 puts 0 1 0 1 to the tape

B,A creates a new state called A

W,0 writes a 0 to the cell

S,A runs the state A

T,01
B,A
 Q,0
  W,1
  R
  S,A
 .Q
 Q,1
  _A
 .Q
.B

This is a small program. It isn't useful. 
```
