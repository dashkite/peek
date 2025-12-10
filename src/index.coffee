import * as Fn from "@dashkite/joy/function"
import * as Parse from "@dashkite/parse"

nullspace = Parse.many Parse.any [
  Parse.ws
  Parse.eol
  Parse.eof
]

symbol = Parse.re /^[^\s\|]+/

integer = Parse.pipe [
  Parse.re /^\d+/
  Parse.map ( text ) ->
    Number.parseInt text
]

float = Parse.pipe [
  Parse.re /^\d+\.\d+/
  Parse.map ( text ) ->
    Number.parseFloat text
]

number = Parse.any [
  integer
  float
]

string = symbol

literal = Parse.any [
  number
  string
]

operator = symbol

operand = Parse.all [
  Parse.skip nullspace
  Parse.any [
    literal
    symbol
  ]
]

operands = Parse.many operand

expression = Parse.pipe [
  Parse.all [
    operator
    Parse.optional operands
    Parse.skip Parse.optional nullspace
  ]
  Parse.map ([ operator, operands ]) ->
    { operator, operands }
]

compose = Parse.all [
  Parse.optional nullspace
  Parse.text "|"
  Parse.optional nullspace
]

program = Parse.list compose, expression

# TODO write a proper lexer
# TODO reboot Scan and Parse to work together
# TODO Parse should operate on token arrays not strings

parse = Fn.pipe [
  ( text ) -> text.replaceAll /;[^\n$]*/g, ""
  Parse.parser program
]

export { parse }