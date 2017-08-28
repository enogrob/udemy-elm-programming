module ArchitectedHello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- This is what our model should look like


type alias Model =
    { text : String
    , size : Int
    }


model : Model
model =
    { text = "Hello world"
    , size = 1
    }


type Msg
    = Text
    | SizeUp
    | SizeDown
    | RemoveExcl



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text ->
            { model | text = model.text ++ "!" }

        SizeUp ->
            { model | size = model.size + 1 }

        SizeDown ->
            { model | size = sizeChecker model.size }

        RemoveExcl ->
            { model | text = exclChecker model.text }


exclChecker : String -> String
exclChecker txt =
    if String.endsWith "!" txt then
        String.dropRight 1 txt
    else
        txt


sizeChecker : Int -> Int
sizeChecker size =
    if size <= 1 then
        size
    else
        size - 1


myStyle : Int -> Attribute msg
myStyle size =
    style
        [ ( "fontSize", toString size ++ "em" )
        , ( "color", "teal" )
        ]



-- View


view : Model -> Html Msg
view model =
    div []
        [ div [ myStyle model.size ] [ text model.text ]
        , button [ onClick Text ] [ text "Add exclamation mark" ]
        , button [ onClick RemoveExcl ] [ text "Remove exclamation mark" ]
        , button [ onClick SizeUp ] [ text "+" ]
        , button [ onClick SizeDown ] [ text "-" ]
        ]
