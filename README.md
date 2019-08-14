# bs-mastermind
Learning ReasonML/BuckleScript/OCaml with the mastermind game.

[Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)) is an old code-breaking board game.  This implements the game loop rules, a super ugly UI, and the scoring algorithm.

The scoring rules are:
1. Each peg in the guess which is the same color and in the same position as a peg in the secret is given a black marker
2. Each peg in the guess which is the same color but not in the same position as a peg in the secret is given a white marker
3. Black markers are placed before white markers
4. Each peg can only result in one marker (no double matches), and if it is an exact match the exatch match marker must be given (not the white marker)

## Run Project

```sh
npm install
npm start # builds bucklescript in watch mode

# in another tab
npm run webpack # builds JS bundle

# in yet another tab
npm run server # runs hot-reloading dev server

# open http://localhost:8000/ in a web browser
# play mastermind!
```

## Run Tests
```sh
npm run test
```

The vscode jest extension also works.