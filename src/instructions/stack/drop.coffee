import { drop } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Drop extends Instruction

  apply: ( stack ) -> drop stack

Instructions.set "stack.drop", Drop