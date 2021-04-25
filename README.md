codingame simple local test runner
==================================

a small tool to run tests for your codingame code on your local machine.
main advantage of this tool is that all your test cases
are in one big file for easy editing.

this tool only runs tests. it does not sync with codingame website.
you will have to copy your code yourself.

this tool only works for practice puzzles which read input once.
it does not work for puzzles that must read input per turn.

run like this:

    ./cgrunner.sh runyourcode <testdata

with `runyourcode` being the command you would use to run your code.
for example: `node code.js` or `./code.py` (when `code.py` executable).

and `testdata` looking like this:

    =====================
    ----------------------
    header
    ==========================
    test case 1
    ---------------------------
    input1
    -----------------------------
    lolput1
    ==========================
    test case 2
    ---------------------------
    input2
    -----------------------------
    lolput2
    =========================

the format is as follows:

    bigseparator
    smallseparator
    optional comment lines
    bigseparator
    test case title
    smallseparator
    input lines
    smallseparator
    expected output lines
    bigseparator
    next test case title
    ...

`bigseparator` and `smallseparator` can be anything.
the actual separators separating the test cases then need to be
at least as long as the first two separators.

this will run runyourcode with input taken from testdata

testdata is parsed to split individual test cases

compares output from your code with output taken from test data file

----
Copyright Lesmana Zimmer lesmana@gmx.de

This program is free software.
It is licensed under the WTFPL version 2.
That means that you can do what the fuck
you want to with this program.
For details see http://www.wtfpl.net/about/
