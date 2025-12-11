import { poke } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Add extends Instruction

  apply: ( stack ) ->
    poke (( a, b ) -> a + b), stack

Instructions.set "math.add", Add