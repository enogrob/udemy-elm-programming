module SocketToMe exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import WebSocket


-- MODEL


type alias Model =
    { input : String
    , messages : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )


socketUrl : String
socketUrl =
    "ws://localhost:8080/connect"



-- UPDATE


type Msg
    = Input String
    | SendToSocket
    | NewMessageReceived String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input str ->
            ( { model | input = str }, Cmd.none )

        SendToSocket ->
            ( model, WebSocket.send socketUrl model.input )

        NewMessageReceived str ->
            ( { model | input = "", messages = str :: model.messages }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen socketUrl NewMessageReceived


view : Model -> Html Msg
view model =
    div []
        [ ul [] (List.reverse (List.map (\i -> li [] [ text i ]) model.messages))
        , input [ onInput Input ] []
        , button [ onClick SendToSocket ] [ text "Send" ]
        ]


main =
    Html.program
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
