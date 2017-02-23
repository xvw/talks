module Base exposing (main)
import Html exposing (Html, p, div, text, input, button)
import Html.Events exposing (onClick)

type alias Model = TODO

main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = ..
        , update = update
        , view = view
        }

type Msg
    = TODO

update : Msg -> Model -> Model
update msg model =
    model

view : Model -> Html Msg
view model =
    p [] []
