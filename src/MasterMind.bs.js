// Generated by BUCKLESCRIPT VERSION 5.0.6, PLEASE EDIT WITH CARE
'use strict';

var List = require("bs-platform/lib/js/list.js");
var Curry = require("bs-platform/lib/js/curry.js");
var Caml_obj = require("bs-platform/lib/js/caml_obj.js");
var Caml_array = require("bs-platform/lib/js/caml_array.js");

function countExactMatches(guess, secret) {
  var counter = function (count, guessPeg, secretPeg) {
    if (guessPeg === secretPeg) {
      return count + 1 | 0;
    } else {
      return count;
    }
  };
  return List.fold_left2(counter, 0, guess, secret);
}

function findi(predicate, l) {
  var _index = 0;
  var _l = l;
  while(true) {
    var l$1 = _l;
    var index = _index;
    if (l$1) {
      var a = l$1[0];
      if (Curry._2(predicate, index, a)) {
        return /* tuple */[
                index,
                a
              ];
      } else {
        _l = l$1[1];
        _index = index + 1 | 0;
        continue ;
      }
    } else {
      return undefined;
    }
  };
}

function countAllMatches(guess, secret) {
  var secretMatchTracker = Caml_array.caml_make_vect(List.length(secret), false);
  var counter = function (param, guessPeg) {
    var count = param[1];
    var found = findi((function (i, p) {
            if (Caml_obj.caml_equal(p, guessPeg)) {
              return !Caml_array.caml_array_get(secretMatchTracker, i);
            } else {
              return false;
            }
          }), secret);
    if (found !== undefined) {
      var index = found[0];
      Caml_array.caml_array_set(secretMatchTracker, index, true);
      return /* tuple */[
              index + 1 | 0,
              count + 1 | 0
            ];
    } else {
      return /* tuple */[
              param[0] + 1 | 0,
              count
            ];
    }
  };
  return List.fold_left(counter, /* tuple */[
                0,
                0
              ], guess)[1];
}

function getScore(guess, secret) {
  var exactMatches = countExactMatches(guess, secret);
  var colorMatches = countAllMatches(guess, secret) - exactMatches | 0;
  return /* record */[
          /* exactMatches */exactMatches,
          /* colorMatches */colorMatches
        ];
}

exports.countExactMatches = countExactMatches;
exports.findi = findi;
exports.countAllMatches = countAllMatches;
exports.getScore = getScore;
/* No side effect */
