module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, h2, input, label, p, section, text)
import Html.Attributes exposing (class, for, name, type_, value)
import Html.Events exposing (onClick, onInput)



-- MODEL


type alias Model =
    { bodyWeightValue : Float
    , bodyWeightFieldValue : String
    , bodyWeightFieldValid : Bool
    , totalLiftsValue : Float
    , totalLiftsFieldValue : String
    , totalLiftsFieldValid : Bool
    , wilksScore : Float
    }


type alias Formula =
    { constantA : Float
    , coeffB : Float
    , coeffC : Float
    , coeffD : Float
    , coeffE : Float
    , coeffF : Float
    }


formulaForMen : Formula
formulaForMen =
    { constantA = -216.0475144
    , coeffB = 16.2606339
    , coeffC = -0.002388645
    , coeffD = -0.00113732
    , coeffE = 7.01863 * 10 ^ -6
    , coeffF = -1.291 * 10 ^ -8
    }


formulaForWomen : Formula
formulaForWomen =
    { constantA = 594.31747775582
    , coeffB = -27.23842536447
    , coeffC = 0.82112226871
    , coeffD = -0.00930733913
    , coeffE = 4.731582 * 10 ^ -5
    , coeffF = -1.291 * 10 ^ -8
    }


initialModel : Model
initialModel =
    { bodyWeightValue = 0
    , bodyWeightFieldValue = ""
    , bodyWeightFieldValid = True
    , totalLiftsValue = 0
    , totalLiftsFieldValue = ""
    , totalLiftsFieldValid = True
    , wilksScore = 0
    }



-- VIEW


view : Model -> Html Msg
view model =
    section [ class "section" ]
        [ div [ class "container" ]
            [ h1 [ class "title" ] [ text "Wilks score calculator" ]
            , h2 [ class "subtitle" ] [ text "The Wilks coefficient or Wilks formula is a mathematical coefficient that can be used to measure the relative strengths of powerlifters despite the different weight classes of the lifters. Robert Wilks, the former CEO of Powerlifting Australia, is the author of the formula. " ]
            , label [ for "bodyweight", class "label" ] [ text "Bodyweight (kg)" ]
            , input [ name "bodyweight", type_ "text", onInput Bodyweight, value model.bodyWeightFieldValue ] []
            , label [ for "total", class "label" ] [ text "Total weight lifted (kg)" ]
            , input [ name "total", type_ "text", onInput Total, value model.totalLiftsFieldValue ] []
            , p [] [ text ("Your Wilks score " ++ String.fromFloat model.bodyWeightValue) ]
            ]
        ]



-- OTHER FUNCTIONS


calculateWilks : Float -> Float -> Formula -> Float
calculateWilks bodyweight total formula =
    500
        / (formula.constantA
            + (formula.coeffB * bodyweight)
            + (formula.coeffC * (bodyweight ^ 2))
            + (formula.coeffD * (bodyweight ^ 3))
            + (formula.coeffE * (bodyweight ^ 4))
            + (formula.coeffF * (bodyweight ^ 5))
          )
        * total



-- UPDATE


type Msg
    = Bodyweight String
    | Total String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Bodyweight userInput ->
            case String.toFloat userInput of
                Nothing ->
                    { model | bodyWeightFieldValue = userInput, bodyWeightFieldValid = False }

                Just number ->
                    { model
                        | bodyWeightValue = number
                        , bodyWeightFieldValue = userInput
                        , bodyWeightFieldValid = True
                    }

        Total userInput ->
            case String.toFloat userInput of
                Nothing ->
                    { model
                        | totalLiftsFieldValue = userInput
                        , bodyWeightFieldValid = False
                    }

                Just number ->
                    { model
                        | totalLiftsValue = number
                        , totalLiftsFieldValue = userInput
                        , totalLiftsFieldValid = True
                    }



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
