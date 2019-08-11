open Tea.App
open Tea.Html
open MasterMind

type msg =
  | SetPeg of int * codePeg
  | Guess

type gameState = {
  secret: codePeg list;
  guesses: codePeg list list
}

let init () = {
  secret = [Red; Red; Green; Green]; (* generate! *)
  guesses = []
}

let update model = function
  | SetPeg (index, pegColor) -> model
  | Guess -> model

let view model =
  div
    []
    [ text "Welcome to MasterMind!"
    ]

let main =
  beginnerProgram { (* The beginnerProgram just takes a set model state and the update and view functions *)
    model = init (); (* Since model is a set value here, we call our init function to generate that value *)
    update;
    view;
  }