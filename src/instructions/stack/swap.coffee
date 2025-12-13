import { swap } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Swap extends Instruction

  apply: ( stack ) -> swap stack

Instructions.set "stack.swap", Swap