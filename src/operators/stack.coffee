import { 
  copy
  down
  drop
  push
  swap
  up
} from "@dashkite/katana"

import { Operators } from "./registry"

Operators.set "stack.push", 
  ( stack ) -> push ( => @[ 0 ] ), stack
Operators.set "stack.swap", swap
Operators.set "stack.copy", copy
Operators.set "stack.drop", drop
Operators.set "stack.up", up
Operators.set "stack.down", down
