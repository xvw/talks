import Html exposing (beginnerProgram, div, button, text)
import Html.Events exposing (onClick)

main =
    beginnerProgram { model = init, view = view, update = update }

type Msg = Increment | Decrement
type alias Model = Int

init = 0

view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]

update msg model =
  case msg of
    Increment -> model + 1
    Decrement -> model - 1
