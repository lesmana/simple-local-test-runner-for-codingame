
// the following lines are for readline emulation
// because codingame javascript environment
// has a readline function defined
// which needs to be emulated
// for your local javascript environment
// just slap the following lines
// at the beginning of your javascript code

const fs = require('fs');
function* __readline() {
    let lines = fs.readFileSync(0).toString().split(/\n/);
    while(lines.length) yield lines.shift();
}
const _readline = __readline();
function readline() {
    return _readline.next().value;
}

// here be your codingame code

let input = readline();
console.error('got', input);
let output = input.replace('in', 'lol');
console.log(output);
