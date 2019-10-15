const fs = require('fs');
const luamin = require('luamin');

let code = '';

function minifiy(code) {
    console.log('Minifying script...');

    fs.writeFile("linegraph.min.lua", luamin.minify(code) + ";Series=a;LineChart=b\n", (err) => {
        if (err) error(err);
    });
}

console.log('Reading linegraph.lua...');

fs.readFile("linegraph.lua", "utf-8", (err, data) => {
    code = data;
    minifiy(code);
    console.log("Successfully Written to File.");
})
