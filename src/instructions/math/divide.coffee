import { poke } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Divide extends Instruction

  apply: ( stack ) ->
    poke (( a, b ) -> a / b), stack

Instructions.set "math.divide", Divide
Instructions.set "/", Divide