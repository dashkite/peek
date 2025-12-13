import { push } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Push extends Instruction

  @make: ( value ) -> Object.assign ( new @ ), { value }

  apply: ( stack ) ->
    push ( => @value ), stack

Instructions.set "stack.push", Push