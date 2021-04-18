
// readline emulation

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
console.log(input.replace('in', 'lol'));
