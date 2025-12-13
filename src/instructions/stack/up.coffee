import { up } from "@dashkite/katana"
import { Instructions } from "../../registry"
import { Instruction } from "../instruction"

class Up extends Instruction

  apply: ( stack ) -> up stack

Instructions.set "stack.up", Up
