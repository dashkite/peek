import { poke } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Subtract extends Instruction

  apply: ( stack ) ->
    poke (( a, b ) -> a - b), stack

Instructions.set "math.subtract", Subtract
Instructions.set "-", Subtract