open Jest;
open MasterMind;

describe("Expect", () => {
  open Expect;

  test("countExactMatches", () => {
    let guess: list(codePeg) = [Red, Green, Blue, Yellow]
    let secret: list(codePeg) = [Purple, Green, Blue, Purple]
    let count = countExactMatches(guess, secret)
    expect(count) |> toBe(2)
  })

  test("countAllMatches with exact matches only", () => {
    let guess: list(codePeg) = [Red, Green, Blue, Yellow]
    let secret: list(codePeg) = [Purple, Green, Blue, Purple]
    let count = countAllMatches(guess, secret)
    expect(count) |> toBe(2)
  })

  test("countAllMatches with partial matches only", () => {
    let guess: list(codePeg) = [Red, Green, Blue, Yellow]
    let secret: list(codePeg) = [Purple, Blue, Green, Purple]
    let count = countAllMatches(guess, secret)
    expect(count) |> toBe(2)
  })

  
  test("countAllMatches with partial matches and possible double match", () => {
    let guess: list(codePeg) = [Red, Green, Red, Yellow]
    let secret: list(codePeg) = [Purple, Red, Purple, Purple]
    let count = countAllMatches(guess, secret)
    expect(count) |> toBe(1)
  })

  test("countAllMatches with exact matches and partial matches and possible double match", () => {
    let guess: list(codePeg) = [Red, Green, Red, Yellow]
    let secret: list(codePeg) = [Purple, Red, Purple, Yellow]
    let count = countAllMatches(guess, secret)
    expect(count) |> toBe(2)
  })

  test("getScore with exact matches and partial matches and possible double match", () => {
    let guess: list(codePeg) = [Red, Green, Red, Yellow]
    let secret: list(codePeg) = [Purple, Red, Purple, Yellow]
    let score = getScore(guess, secret)
    expect(score) |> toEqual({exactMatches: 1, colorMatches: 1})
  })
});