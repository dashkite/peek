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

      assert.equal 2, ( compile program ).apply null

    test "numeric literals", [
      
      test "decimal with commas", ->
        assert.equal 1e6, ( compile "1,000,000" )()

      test "negative decimal", ->
        assert.equal -1500.5, ( compile "-1,500.50" )()

      test "hexadecimal", ->
        assert.equal 250, ( compile "0x0fA" )()

      test "negative binary", ->
        assert.equal -11, ( compile "-0b1011" )()

      test "octal", ->
        assert.equal 63, ( compile "0o77" )()

      test "scientific notation", ->
        assert.equal 120, ( compile "1.2e2" )()   

    ]

  ]

  process.exit if success then 0 else 1
