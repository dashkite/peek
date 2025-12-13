import { poke } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Multiply extends Instruction

  apply: ( stack ) ->
    poke (( a, b ) -> a * b), stack

Instructions.set "math.multiply", Multiply
Instructions.set "*", Multiply