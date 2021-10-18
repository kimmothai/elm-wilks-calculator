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
            , h2 [ class "subtitle" ] [ text "The Wilks coefficient or Wilks formula is a mathematical coefficient that can be used to measure the relative strengths of powerlifters despite the different weight classes of the lifters. Robert Wilks, CEO of Powerlifting Australia, is the author of the formula. " ]
            , label [ for "bodyweight", class "label" ] [ text "Bodyweight (kg)" ]
            , input [ name "bodyweight", type_ "text", onInput Bodyweight, value model.bodyWeightFieldValue ] []
            , label [ for "total", class "label" ] [ text "Total weight lifted (kg)" ]
            , input [ name "total", type_ "text", onInput Total, value model.totalLiftsFieldValue ] []
            , p [] [ text ("Your Wilks score " ++ String.fromFloat model.bodyWeightValue) ]
            ]
        ]



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
