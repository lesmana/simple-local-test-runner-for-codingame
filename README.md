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

demonstration
-------------

using the example code and example tests

    $ ./cgrunner.sh node examplecode.js < exampletests
    =====================
    test case 1
    ----------------------
    got input1
    lolput1
    ----------------------
    PASS: test case 1
    =====================
    test case 2
    ----------------------
    got input2
    lolput2
    ----------------------
    PASS: test case 2
    =====================
    all pass

how to read: first title is printed.
then output of your code is printed.
then, if actual output matches expected output,
`PASS` with title is printed.
last, if all test pass, `all pass` is printed.

and again for a fail

    $ ./cgrunner.sh ./examplecode.py < exampletestsfail
    ##################
    test case 1
    ~~~~~~~~~~~~~~~~~~
    lolput1
    ~~~~~~~~~~~~~~~~~~
    1c1
    < failput1
    ---
    > lolput1
    ~~~~~~~~~~~~~~~~~~
    FAIL: test case 1

as above title and output of code is printed.
in this case actual output does not match expected output
so a diff is printed and `FAIL` is printed.
then the run is aborted. any following test cases are not run.

how this works
--------------

the tool extracts the individual test cases one by one.
for each test case
the input part is saved to a file named input.
the expected output part is saved to a file named expectedoutput.

then your code is called with input piped in stdin.
stdout redirected to a file named actualoutput.
stderr printed to screen.
this mimics the behaviour of codingame online code runner.

then actualoutput is compared to expectedoutput.
if both are same then continue with next test case.
if there is difference then report fail and abort the test run.

after the test run the following files are left over:
input, expectedoutput, actualoutput.
the files will be overwritten on the next run.

License
-------

Copyright Lesmana Zimmer lesmana@gmx.de

This program is free software.
It is licensed under the WTFPL version 2.
That means that you can do what the fuck
you want to with this program.
For details see http://www.wtfpl.net/about/
