open Tea.App
open Tea.Html
open MasterMind

type msg =
  | SetPeg of int * string
  | Guess

type guess = {
  one: string;
  two: string;
  three: string;
  four: string;
}

type pastGuess = {
  guess: codePeg list;
  score: score
}

type gameState = {
  secret: codePeg list;
  currentGuess: guess;
  pastGuesses: pastGuess list
}

let pegToLetter = function
  | Red -> "R"
  | Green -> "G"
  | Blue -> "B"
  | Yellow -> "Y"
  | Orange -> "O"
  | Purple -> "P"

exception InvalidLetter

let letterToPeg = function
  | "R" -> Red
  | "G" -> Green
  | "B" -> Blue
  | "Y" -> Yellow
  | "O" -> Orange
  | "P" -> Purple
  | _ -> raise InvalidLetter
  
let emptyGuess = {one=""; two=""; three=""; four=""}

let init () = {
  secret = [Red; Red; Green; Green]; (* todo: generate! *)
  currentGuess = emptyGuess;
  pastGuesses = []
}

let setPeg currentGuess index peg_str = 
  match index with
  | 0 -> { currentGuess with one = peg_str }
  | 1 -> { currentGuess with two = peg_str }
  | 2 -> { currentGuess with three = peg_str }
  | 3 -> { currentGuess with four = peg_str }
  | _ -> raise InvalidLetter

let handleGuess model =
  let guess = [
    (letterToPeg model.currentGuess.one);
    (letterToPeg model.currentGuess.two);
    (letterToPeg model.currentGuess.three);
    (letterToPeg model.currentGuess.four)
  ] 
  in let score = getScore guess model.secret
  in { model with 
    currentGuess = emptyGuess; 
    pastGuesses = { guess; score } :: model.pastGuesses
  }

let update model = function
  | SetPeg (index, peg_str) -> 
    { model with 
      currentGuess = (setPeg model.currentGuess index peg_str)
    }
  | Guess -> handleGuess model

let view_peginput peg_str n =
  input'
    [ value peg_str
    ; onInput (fun str -> (SetPeg (n, str)))
    ; Vdom.attribute "" "maxlength" "1"
    ]
    []

let view_enterguess model = 
  div
    []
    [ view_peginput model.currentGuess.one 0
    ; view_peginput model.currentGuess.two 1
    ; view_peginput model.currentGuess.three 2
    ; view_peginput model.currentGuess.four 3
    ; button
      [ onClick (Guess) ]
      [ text "Guess" ]
    ]

let view_pastguess pastGuess =
  let guess = pastGuess.guess
  in div
    []
    [ text (pegToLetter (List.nth guess 0));
      text (pegToLetter (List.nth guess 1));
      text (pegToLetter (List.nth guess 2));
      text (pegToLetter (List.nth guess 3));
      text "SCORE: ";
      text ("exact: " ^ (string_of_int pastGuess.score.exactMatches));
      text ("partial: " ^ (string_of_int pastGuess.score.colorMatches))
    ]

let view_pastguesses model =
  div
    []
    (List.map view_pastguess model.pastGuesses)

let view model =
  div
    []
    [ header
      [ style "text-align" "center"]
      [ h1 [] [ text "MasterMind!" ] ]
    ; view_enterguess model
    ; div
      []
      [ text model.currentGuess.one
      ; text model.currentGuess.two
      ; text model.currentGuess.three
      ; text model.currentGuess.four
      ]
    ; view_pastguesses model
    ]

let main =
  beginnerProgram {
    model = init ();
    update;
    view;
  }