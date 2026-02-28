module MakeMkvSelectionParserTests exposing (suite)

import Expect
import MakeMkvSelectionParser exposing (Conditional(..), parse)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "MakeMkvSelectionParser"
        [ parseTests
        ]


parseTests : Test
parseTests =
    describe "parse"
        [ test "parses -sel:all as unselect all tracks" <|
            \_ ->
                parse "-sel:all"
                    |> Expect.equal
                        (Ok [ ( "unselect", And [ Or [ Prim "all tracks" ] ] ) ])
        , test "parses +sel:all as select all tracks" <|
            \_ ->
                parse "+sel:all"
                    |> Expect.equal
                        (Ok [ ( "select", And [ Or [ Prim "all tracks" ] ] ) ])
        , test "parses +sel:video as select video track" <|
            \_ ->
                parse "+sel:video"
                    |> Expect.equal
                        (Ok [ ( "select", And [ Or [ Prim "video track" ] ] ) ])
        , test "parses +sel:(favlang|nolang) as select with Or condition" <|
            \_ ->
                parse "+sel:(favlang|nolang)"
                    |> Expect.equal
                        (Ok
                            [ ( "select"
                              , And
                                    [ Or
                                        [ And
                                            [ Or
                                                [ Prim "favourite language"
                                                , Prim "tracks without a language set"
                                                ]
                                            ]
                                        ]
                                    ]
                              )
                            ]
                        )
        , test "parses multiple rules" <|
            \_ ->
                parse "-sel:all,+sel:subtitle"
                    |> Expect.equal
                        (Ok
                            [ ( "unselect", And [ Or [ Prim "all tracks" ] ] )
                            , ( "select", And [ Or [ Prim "subtitle track" ] ] )
                            ]
                        )
        , test "rejects invalid input with Err" <|
            \_ ->
                parse "not a rule"
                    |> Expect.err
        , test "rejects empty string with Err" <|
            \_ ->
                parse ""
                    |> Expect.err
        ]
