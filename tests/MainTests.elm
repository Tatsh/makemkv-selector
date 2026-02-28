module MainTests exposing (suite)

import Expect
import Main exposing (capitalize, conditionRendersAsListing)
import MakeMkvSelectionParser exposing (Conditional(..))
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Main"
        [ capitalizeTests
        , conditionRendersAsListingTests
        ]


capitalizeTests : Test
capitalizeTests =
    describe "capitalize"
        [ test "uppercases first character of non-empty string" <|
            \_ ->
                capitalize "select"
                    |> Expect.equal "Select"
        , test "returns empty string unchanged" <|
            \_ ->
                capitalize ""
                    |> Expect.equal ""
        , test "handles single character" <|
            \_ ->
                capitalize "a"
                    |> Expect.equal "A"
        ]


conditionRendersAsListingTests : Test
conditionRendersAsListingTests =
    describe "conditionRendersAsListing"
        [ test "Prim is not a listing" <|
            \_ ->
                conditionRendersAsListing (Prim "all tracks")
                    |> Expect.equal False
        , test "Or with multiple items is a listing" <|
            \_ ->
                conditionRendersAsListing
                    (Or [ Prim "favourite language", Prim "tracks without a language set" ])
                    |> Expect.equal True
        , test "And with multiple items is a listing" <|
            \_ ->
                conditionRendersAsListing
                    (And [ Prim "video track", Prim "audio track" ])
                    |> Expect.equal True
        , test "Or with single item is not a listing when inner is Prim" <|
            \_ ->
                conditionRendersAsListing (Or [ Prim "all tracks" ])
                    |> Expect.equal False
        , test "Not of Prim is not a listing" <|
            \_ ->
                conditionRendersAsListing (Not (Prim "forced subtitle"))
                    |> Expect.equal False
        , test "Not of Or with multiple items is a listing" <|
            \_ ->
                conditionRendersAsListing
                    (Not (Or [ Prim "favlang", Prim "nolang" ]))
                    |> Expect.equal True
        ]
