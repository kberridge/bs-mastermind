type codePeg =
  | Red
  | Green
  | Blue
  | Yellow
  | Orange
  | Purple

let codePegs = [
  Red;
  Green;
  Blue;
  Yellow;
  Orange;
  Purple;
]

type score = {
  exactMatches: int;
  colorMatches: int
}

let countExactMatches guess secret =
  let counter (count: int) (guessPeg: codePeg) (secretPeg: codePeg) =
    if guessPeg = secretPeg then count + 1 else count 
  in
  
  List.fold_left2 counter 0 guess secret

let findi predicate l =
  let rec findRec index l =
    match l with
    | [] -> None
    | a :: rest -> if predicate index a then Some(index, a) else findRec (index + 1) rest
  in

  findRec 0 l
 
let countAllMatches guess secret =
  (* TODO: It would be fun to find a more pure solution that doesn't involve mutating this array *)
  let secretMatchTracker = Array.make (List.length secret) false in

  let counter (index, count) guessPeg =
    let found = findi (fun i p -> p = guessPeg && not (Array.get secretMatchTracker i)) secret in
    match found with
    | None -> (index + 1, count)
    | Some((index, _)) ->
      Array.set secretMatchTracker index true;
      (index + 1, count + 1)
  in

  let (_, count) = List.fold_left counter (0, 0) guess in
  count

let getScore guess secret =
  let exactMatches = countExactMatches guess secret in
  let colorMatches = (countAllMatches guess secret) - exactMatches in
  {exactMatches = exactMatches; colorMatches = colorMatches}