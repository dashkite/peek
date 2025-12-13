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
    operator: "stack.push"
    parameters: Object.values literal
]

operator = pipe [
  symbol
  map ({ symbol }) -> 
    operator: symbol
    parameters: []
]

program = many ( any [ literal, operator, operator ]), 1

parse = Fn.pipe [
  scan
  ( tokens ) -> 
    tokens.filter ({ comment }) -> !comment?
  parser program
]

export { parse }