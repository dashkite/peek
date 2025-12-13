import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import { compile } from "../src"
# import { parse } from "../src/parse"
# import { scan } from "../src/scan"
import { Instructions } from "../src/registry"

do ->

  print await test "Peek", [

    test "nominal", ->

      program = """
        3                 ; 3
        5                 ; 5 3
        +                 ; 8      
        2
        -                 ; 6  
        2
        *                 ; 12
        3
        /                 ; 4
      """

      assert.equal 4, ( compile program ).apply()

  ]

  process.exit if success then 0 else 1
