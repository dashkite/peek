import { copy } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Copy extends Instruction

  apply: ( stack ) -> copy stack

Instructions.set "stack.copy", Copy
