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
        math.integer 3       |      ; 3
          math.integer 5     |      ; 5 3
          math.add                  ; 8          
      """

      assert.equal 8, ( compile program ).apply()

  ]

  process.exit if success then 0 else 1
