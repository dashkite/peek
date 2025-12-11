import { metaclass } from "@dashkite/joy/metaclass"

class Instruction extends metaclass()
  @make: -> new @

export { Instruction }