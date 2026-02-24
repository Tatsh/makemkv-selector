const Parser = require('jison').Parser;
const fs = require('fs');
const bnf = fs.readFileSync('./sel.jison', 'utf8');
const parser = new Parser(bnf);
module.exports = parser;
