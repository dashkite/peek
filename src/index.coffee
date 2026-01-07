import { pipe } from "@dashkite/joy/function"
import { parse } from "./parse"
import { Operators } from "./operators"

lookup = ( operator ) ->
  if ( f = Operators.get operator )?
    f
  else
    throw new Error "peek:
      unknown operator [ #{ operator } ]"

compile = ( program ) ->
  operators =
    for { operator, parameters } from parse program
      ( lookup operator )
        .bind parameters
  pipe [ operators..., ([ _..., top ]) -> top ]

export { compile }