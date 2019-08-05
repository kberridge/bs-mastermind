type codePeg =
  | Red
  | Green
  | Blue
  | Yellow
  | Orange
  | Purple;

type score = {
  exactMatches: int,
  colorMatches: int,
};

let countExactMatches = (guess: list(codePeg), secret: list(codePeg)) => {
  let counter = (count: int, guessPeg: codePeg, secretPeg: codePeg) => {
    guessPeg === secretPeg ? count + 1 : count;
  };
  List.fold_left2(counter, 0, guess, secret);
};

let find = (predicate: (int, 'a) => bool, l: list('a)): option((int, 'a)) => {
  let rec findRec = (index: int, l: list('a)) => {
    switch (l) {
    | [] => None
    | [a, ...rest] =>
      predicate(index, a) ? Some((index, a)) : findRec(index + 1, rest)
    };
  };
  findRec(0, l);
};

let countAllMatches = (guess: list(codePeg), secret: list(codePeg)) => {
  // TODO: It would be fun to find a more pure solution that doesn't involve mutating this array
  let secretMatchTracker = Array.make(List.length(secret), false);

  let counter = (agg: (int, int), guessPeg: codePeg) => {
    let (index, count) = agg;
    let found =
      find((i, p) => p === guessPeg && !secretMatchTracker[i], secret);
    switch (found) {
    | None => (index + 1, count)
    | Some((index, _)) =>
      secretMatchTracker[index] = true;
      (index + 1, count + 1);
    };
  };
  let (_, count) = List.fold_left(counter, (0, 0), guess);
  count;
};

let getScore = (guess, secret) => {
  let exactMatches = countExactMatches(guess, secret);
  let colorMatches = countAllMatches(guess, secret) - exactMatches;
  {exactMatches, colorMatches};
};
