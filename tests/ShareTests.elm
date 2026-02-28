module ShareTests exposing (suite)

import Expect
import Share exposing (decodeSelection, encodeSelection)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Share"
        [ encodeSelectionTests
        , decodeSelectionTests
        , roundTripTests
        ]


encodeSelectionTests : Test
encodeSelectionTests =
    describe "encodeSelection"
        [ test "encodes -sel:all as M:((a))" <|
            \_ ->
                encodeSelection "-sel:all"
                    |> Expect.equal (Just "M:((a))")
        , test "encodes +sel:all as P:((a))" <|
            \_ ->
                encodeSelection "+sel:all"
                    |> Expect.equal (Just "P:((a))")
        , test "encodes +sel:(favlang|nolang) as P:((((f|n))))" <|
            \_ ->
                encodeSelection "+sel:(favlang|nolang)"
                    |> Expect.equal (Just "P:((((f|n))))")
        , test "returns Nothing for invalid input" <|
            \_ ->
                encodeSelection "not valid"
                    |> Expect.equal Nothing
        , test "returns Nothing for empty string" <|
            \_ ->
                encodeSelection ""
                    |> Expect.equal Nothing
        ]


decodeSelectionTests : Test
decodeSelectionTests =
    describe "decodeSelection"
        [ test "decodes M:((a)) to -sel:((all))" <|
            \_ ->
                decodeSelection "M:((a))"
                    |> Expect.equal (Ok "-sel:((all))")
        , test "decodes P:((a)) to +sel:((all))" <|
            \_ ->
                decodeSelection "P:((a))"
                    |> Expect.equal (Ok "+sel:((all))")
        , test "decodes P:(f|n) to +sel:(favlang|nolang)" <|
            \_ ->
                decodeSelection "P:(f|n)"
                    |> Expect.equal (Ok "+sel:(favlang|nolang)")
        , test "decodes multiple rules" <|
            \_ ->
                decodeSelection "M:((a)),P:(f|n)"
                    |> Expect.equal (Ok "-sel:((all)),+sel:(favlang|nolang)")
        , test "returns Err for invalid rule format" <|
            \_ ->
                decodeSelection "no-colon"
                    |> Expect.err
        ]


roundTripTests : Test
roundTripTests =
    describe "encodeSelection round-trip with decodeSelection"
        [ test "encode then decode yields parseable selection string" <|
            \_ ->
                encodeSelection "-sel:all"
                    |> Maybe.andThen (decodeSelection >> Result.toMaybe)
                    |> Expect.notEqual Nothing
        , test "encode then decode for +sel:(favlang|nolang) yields parseable string" <|
            \_ ->
                encodeSelection "+sel:(favlang|nolang)"
                    |> Maybe.andThen (decodeSelection >> Result.toMaybe)
                    |> Expect.notEqual Nothing
        ]
