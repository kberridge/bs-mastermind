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

type gameStatus = 
  | Playing
  | Won
  | Lost

type gameState = {
  secret: codePeg list;
  currentGuess: guess;
  pastGuesses: pastGuess list;
  gameStatus: gameStatus;
}

let pegToLetter = function
  | Red -> "R"
  | Green -> "G"
  | Blue -> "B"
  | Yellow -> "Y"
  | Orange -> "O"
  | Purple -> "P"

exception InvalidLetter

let letterToPeg letter =
  let upperLetter = String.uppercase letter in
  match upperLetter with
  | "R" -> Red
  | "G" -> Green
  | "B" -> Blue
  | "Y" -> Yellow
  | "O" -> Orange
  | "P" -> Purple
  | _ -> raise InvalidLetter
  
let emptyGuess = {one=""; two=""; three=""; four=""}

let init () = {
  secret = generateSecret();
  currentGuess = emptyGuess;
  pastGuesses = [];
  gameStatus = Playing;
}

let maxGuesses = 12

let setPeg currentGuess index peg_str = 
  match index with
  | 0 -> { currentGuess with one = peg_str }
  | 1 -> { currentGuess with two = peg_str }
  | 2 -> { currentGuess with three = peg_str }
  | 3 -> { currentGuess with four = peg_str }
  | _ -> raise InvalidLetter

let calculateGameState model score =
  if List.length model.pastGuesses - 1 >= maxGuesses then Lost
  else if score.exactMatches = 4 then Won
  else Playing

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
    pastGuesses = { guess; score } :: model.pastGuesses;
    gameStatus = calculateGameState model score;
  }

let update model = function
  | SetPeg (index, peg_str) -> 
    { model with 
      currentGuess = (setPeg model.currentGuess index peg_str)
    }
  | Guess -> handleGuess model

let blankOption () = option' [ value "" ] [ text "" ]

let view_peginput peg_str n =
  select
    [ onChange (fun value -> (SetPeg (n, value)))
    ; value peg_str
    ]
    (blankOption() :: (codePegs |> List.map pegToLetter |> List.map (fun l -> option' [ value l ] [ text l ])))

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

let view_won model =
  let numGuesses = List.length model.pastGuesses in
  div
    []
    [ h2 [] [ text "You won!" ]
    ; div [] [ text {j|It took you $numGuesses guesses|j} ]
    ]

let view_lost _ =
  div
    []
    [ h2 [] [ text "Sorry, you lost :(" ]
    ]

let view_enterguess_or_winlose model =
  match model.gameStatus with
  | Playing -> view_enterguess model
  | Won -> view_won model
  | Lost -> view_lost model

let view_pastguess pastGuess =
  let guess = pastGuess.guess
  in div
    []
    [ text (pegToLetter (List.nth guess 0));
      text (pegToLetter (List.nth guess 1));
      text (pegToLetter (List.nth guess 2));
      text (pegToLetter (List.nth guess 3));
      text " SCORE: ";
      text ("exact: " ^ (string_of_int pastGuess.score.exactMatches));
      text (" partial: " ^ (string_of_int pastGuess.score.colorMatches))
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
    ; view_enterguess_or_winlose model
    ; view_pastguesses model
    ]

let main =
  beginnerProgram {
    model = init ();
    update;
    view;
  }