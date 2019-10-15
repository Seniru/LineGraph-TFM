const fs = require('fs');
const luamin = require('luamin');

let code = '';
const green = '\033[92m';
const end = '\033[0m';

function minifiy(code) {
    console.log('\nMinifying script...');

    fs.writeFile("linegraph.min.lua", luamin.minify(code) + ";Series=a;LineChart=b\n", (err) => {
        if (err) error(err);
    });
}

console.log('\nReading linegraph.lua...');

fs.readFile("linegraph.lua", "utf-8", (err, data) => {
    code = data;
    minifiy(code);
    console.log(green + "\nSuccessfully Written to File." + end);
})
