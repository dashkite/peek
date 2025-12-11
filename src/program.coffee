import { metaclass } from "@dashkite/joy/metaclass"
import { pipe } from "@dashkite/joy/function"

class Program extends metaclass()

  @make: -> Object.assign ( new @ ), { instructions: [] }

  append: ( instruction ) ->
    @instructions.push instruction
    @

  apply: ->
    f = @toFunction()
    ( f [] )[ 0 ]

  toFunction: ->
    pipe @instructions.map ( instruction ) ->
      ( stack ) -> instruction.apply stack

export { Program }