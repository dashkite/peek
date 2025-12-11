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

literal = any [
  number
  # string
]

instruction = pipe [
  symbol
  map ({ symbol }) -> symbol
]

parameter = pipe [

  any [
    literal
    # symbol
  ]

  map ( token ) ->
    ( Object.values token )[ 0 ]

] 

parameters = many parameter

operand = pipe [
  all [
    instruction
    parameters
  ]
  map ([ instruction, parameters ]) ->
    { instruction, parameters }
]

program = list operator, operand

parse = Fn.pipe [
  scan
  ( tokens ) -> 
    tokens.filter ({ comment }) -> !comment?
  parser program
]

export { parse }