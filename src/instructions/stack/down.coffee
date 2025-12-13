import { down } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Down extends Instruction

  apply: ( stack ) -> down stack

Instructions.set "stack.down", Down
