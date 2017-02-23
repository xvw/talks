module Base exposing (main)

import Html exposing (Html, p, div, text, input, button, ul, li)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)

type alias Model =
    { talk : Talk
    , speaker : Speaker
    , talks : List (Talk, Speaker)
    }

type alias Talk = String
type alias Speaker = String

main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = Model "" "" []
        , update = update
        , view = view
        }

type Msg
    = SetTalk Talk
    | SetSpeaker Speaker
    | SaveTalk

update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTalk talk ->
            { model | talk = talk }
        SetSpeaker speaker ->
            { model | speaker = speaker }
        SaveTalk ->
            { model | talks = (model.talk, model.speaker) :: model.talks }

view : Model -> Html Msg
view model =
    p []
        [ div []
            [ text "Talk"
            , input [onInput SetTalk, value model.talk] []
            ]
        , div []
            [ text "Speaker"
            , input [onInput SetSpeaker, value model.speaker] []
            ]
        , button [ onClick SaveTalk ] [ text "Save Talk" ]
        , ul [] (List.map showTalks model.talks)
        ]

showTalks : (Talk, Speaker) -> Html Msg
showTalks (talk, speaker) =
    li [] [ text (talk ++ " par " ++ speaker) ]
