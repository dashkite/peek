import * as Fn from "@dashkite/joy/function"

import {
  any
  all
  many
  optional
  pipe
  map
  list
  parser
} from "@dashkite/parse"

import { scan } from "./scan"

tagged = ( name ) ->
  ( state ) ->
    if state.rest[ 0 ][ name ]?
      {
        state...
        value: state.rest[ 0 ]
        rest: state.rest[ 1.. ]
      }
    else
      {
        state...
        error:
          expected: "tagged '#{ name }'"
          got: state.rest
      }

number = tagged "number"

symbol = tagged "symbol"

operator = tagged "operator"

literal = pipe [
  any [
    number
    # string
  ]
  map ( literal ) ->
    instruction: "stack.push"
    parameters: Object.values literal
]

instruction = pipe [
  symbol
  map ({ symbol }) -> 
    instruction: symbol
    parameters: []
]

program = many ( any [ literal, instruction, operator ]), 1

parse = Fn.pipe [
  scan
  ( tokens ) -> 
    tokens.filter ({ comment }) -> !comment?
  parser program
]

export { parse }