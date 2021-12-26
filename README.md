simple local test runner for codingame code
===========================================

a small tool to run tests for your codingame code on your local machine.
main advantage of this tool is that all your test cases
are in one big file for easy editing.

codingame is a website where you can solve puzzles by writing code:
https://www.codingame.com

this tool only runs tests. it does not sync with codingame website.
you will have to copy your code and test cases yourself.

this tool only works for practice puzzles which read input once.
it does not work for puzzles that must read input per turn.

how to use
----------

1.  copy your code from codingame to a local file.
2.  copy the test cases from codingame or write your own test cases.
    see the example files for the format.
3.  run like this:

        ./cgrunner.sh runyourcode <testdata

with `runyourcode` being the command you would use to run your code.
for example: `node code.js` or `./code.py` (if `code.py` executable).

how this works
--------------

the tool extracts the individual test cases one by one.
for each test case
the input part is saved to a file named input.
the expected output part is saved to a file named expectedoutput.

then your code is called
with input piped in stdin
and output (stdout) redirected to a file named actualoutput.
(stderr is ignored).
the actual output is then compared to the expected output.

if diff then fail and abort. if same then continue with next test case.

afterwards the following files from the last run test are left over:
input, expectedoutput, actualoutput.
the files are overwritten on the next run.

----
Copyright Lesmana Zimmer lesmana@gmx.de

This program is free software.
It is licensed under the WTFPL version 2.
That means that you can do what the fuck
you want to with this program.
For details see http://www.wtfpl.net/about/
