module Main exposing (..)

import Browser
import Html exposing (Html, a, button, div, h1, h2, input, label, p, section, text)
import Html.Attributes exposing (class, for, href, name, type_, value)
import Html.Events exposing (onClick, onInput)
import Round



-- MODEL


type Lifter
    = Male
    | Female


type alias Model =
    { bodyWeightValue : Float
    , bodyWeightFieldValue : String
    , bodyWeightFieldValid : Bool
    , totalLiftsValue : Float
    , totalLiftsFieldValue : String
    , totalLiftsFieldValid : Bool
    , lifter : Lifter
    , genderButtonText : String
    , useFormula : Formula
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
    , coeffF = -9.054 * 10 ^ -8
    }


initialModel : Model
initialModel =
    { bodyWeightValue = 0
    , bodyWeightFieldValue = ""
    , bodyWeightFieldValid = True
    , totalLiftsValue = 0
    , totalLiftsFieldValue = ""
    , totalLiftsFieldValid = True
    , lifter = Male
    , genderButtonText = "Male"
    , useFormula = formulaForMen
    }



-- VIEW


view : Model -> Html Msg
view model =
    section [ class "section has-background-white-bis" ]
        [ div [ class "container" ]
            [ div [ class "content" ]
                [ h1 [ class "title" ] [ text "Wilks score calculator" ]
                , div [ class "block" ]
                    [ p [ class "subtitle" ] [ text "Made by Kimmo Thai" ]
                    , a [ href "https://github.com/kimmothai/elm-wilks-calculator" ] [ text "Project home page" ]
                    ]
                , div [ class "block" ]
                    [ p [ class "content is-size-6-mobile has-text-justified" ]
                        [ text "The Wilks coefficient or Wilks formula is a mathematical coefficient that can be used to measure the relative strengths of powerlifters despite the different weight classes of the lifters. Robert Wilks, the former CEO of Powerlifting Australia, is the author of the formula. "
                        ]
                    ]
                , div [ class "block" ]
                    [ label [ for "gender", class "label" ] [ text "Toggle gender" ]
                    , button
                        ([ name "toggle"
                         , onClick (ToggleGender model.lifter)
                         ]
                            ++ (if model.genderButtonText == "Male" then
                                    [ class "button is-primary" ]

                                else
                                    [ class "button is-info" ]
                               )
                        )
                        [ text model.genderButtonText ]
                    ]
                , div [ class "block" ]
                    [ label [ for "bodyweight", class "label" ] [ text "Bodyweight (kg)" ]
                    , input
                        ([ name "bodyweight"
                         , type_ "text"
                         , onInput Bodyweight
                         , value model.bodyWeightFieldValue
                         ]
                            ++ addClass model.bodyWeightFieldValid
                        )
                        []
                    , label [ for "total", class "label" ] [ text "Powerlifting total (kg)" ]
                    , input
                        ([ name "total"
                         , type_ "text"
                         , onInput Total
                         , value model.totalLiftsFieldValue
                         ]
                            ++ addClass model.totalLiftsFieldValid
                        )
                        []
                    ]
                , div [ class "score box" ]
                    [ h2 [ class "score has-text-weight-bold" ] [ text "Your Wilks score is: " ]
                    , let
                        { bodyWeightValue, totalLiftsValue, useFormula } =
                            model
                      in
                      p [ class "score is-size-2" ]
                        [ text (Round.round 2 (calculateWilks bodyWeightValue totalLiftsValue useFormula))
                        ]
                    ]
                ]
            ]
        ]



-- OTHER FUNCTIONS


calculateWilks : Float -> Float -> Formula -> Float
calculateWilks bodyweight total formula =
    let
        { constantA, coeffB, coeffC, coeffD, coeffE, coeffF } =
            formula
    in
    500
        / (constantA
            + (coeffB * bodyweight)
            + (coeffC * (bodyweight ^ 2))
            + (coeffD * (bodyweight ^ 3))
            + (coeffE * (bodyweight ^ 4))
            + (coeffF * (bodyweight ^ 5))
          )
        * total


addClass : Bool -> List (Html.Attribute msg)
addClass fieldBoolean =
    if fieldBoolean == True then
        [ class "input" ]

    else
        [ class "input is-danger" ]



-- UPDATE


type Msg
    = Bodyweight String
    | Total String
    | ToggleGender Lifter


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
                        , totalLiftsFieldValid = False
                    }

                Just number ->
                    { model
                        | totalLiftsValue = number
                        , totalLiftsFieldValue = userInput
                        , totalLiftsFieldValid = True
                    }

        ToggleGender currentGender ->
            case currentGender of
                Male ->
                    { model
                        | lifter = Female
                        , genderButtonText = "Female"
                        , useFormula = formulaForWomen
                    }

                Female ->
                    { model
                        | lifter = Male
                        , genderButtonText = "Male"
                        , useFormula = formulaForMen
                    }



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
