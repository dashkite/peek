import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import { compile } from "../src"

do ->

  print await test "Peek", [

    test "nominal", ->

      program = """
        3                 ; 3
        5                 ; 5 3
        +                 ; 8      
        2
        -                 ; 6  
        3
        *                 ; 18
        9
        /                 ; 2
      """

      assert.equal 2, ( compile program ).apply []

  ]

  process.exit if success then 0 else 1
