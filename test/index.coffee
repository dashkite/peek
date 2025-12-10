import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import { parse } from "../src"

do ->

  print await test "Peek", [

    test "nominal", ->

      program = """
        feature.shapes       |      ; shapes
          feature.holes      |      ; holes
          feature.color 4    |      ; color holes
          update.fill
      """

      console.log JSON.stringify ( parse program ), null, 2

  ]

  process.exit if success then 0 else 1
