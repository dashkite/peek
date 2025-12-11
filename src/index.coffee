import { parse } from "./parse"
import "./instructions"
import { Instructions } from "./registry"
import { Program } from "./program"

compile = ( program ) ->
  result = Program.make()
  for { instruction, parameters } from parse program
    if ( K = ( Instructions.get instruction ))?
      result.append ( K.make parameters... )
    else
      throw new Error "peek:
        unknown instruction [ #{ instruction } ]"
  result

export { compile }