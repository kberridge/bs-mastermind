// Generated by BUCKLESCRIPT VERSION 5.0.6, PLEASE EDIT WITH CARE
'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.js");
var MasterMind$ReactHooksTemplate = require("../src/MasterMind.bs.js");

Jest.describe("Expect", (function (param) {
        Jest.test("countExactMatches", (function (param) {
                var count = MasterMind$ReactHooksTemplate.countExactMatches(/* :: */[
                      /* Red */0,
                      /* :: */[
                        /* Green */1,
                        /* :: */[
                          /* Blue */2,
                          /* :: */[
                            /* Yellow */3,
                            /* [] */0
                          ]
                        ]
                      ]
                    ], /* :: */[
                      /* Purple */5,
                      /* :: */[
                        /* Green */1,
                        /* :: */[
                          /* Blue */2,
                          /* :: */[
                            /* Purple */5,
                            /* [] */0
                          ]
                        ]
                      ]
                    ]);
                return Jest.Expect[/* toBe */2](2, Jest.Expect[/* expect */0](count));
              }));
        Jest.test("countAllMatches with exact matches only", (function (param) {
                var count = MasterMind$ReactHooksTemplate.countAllMatches(/* :: */[
                      /* Red */0,
                      /* :: */[
                        /* Green */1,
                        /* :: */[
                          /* Blue */2,
                          /* :: */[
                            /* Yellow */3,
                            /* [] */0
                          ]
                        ]
                      ]
                    ], /* :: */[
                      /* Purple */5,
                      /* :: */[
                        /* Green */1,
                        /* :: */[
                          /* Blue */2,
                          /* :: */[
                            /* Purple */5,
                            /* [] */0
                          ]
                        ]
                      ]
                    ]);
                return Jest.Expect[/* toBe */2](2, Jest.Expect[/* expect */0](count));
              }));
        Jest.test("countAllMatches with partial matches only", (function (param) {
                var count = MasterMind$ReactHooksTemplate.countAllMatches(/* :: */[
                      /* Red */0,
                      /* :: */[
                        /* Green */1,
                        /* :: */[
                          /* Blue */2,
                          /* :: */[
                            /* Yellow */3,
                            /* [] */0
                          ]
                        ]
                      ]
                    ], /* :: */[
                      /* Purple */5,
                      /* :: */[
                        /* Blue */2,
                        /* :: */[
                          /* Green */1,
                          /* :: */[
                            /* Purple */5,
                            /* [] */0
                          ]
                        ]
                      ]
                    ]);
                return Jest.Expect[/* toBe */2](2, Jest.Expect[/* expect */0](count));
              }));
        Jest.test("countAllMatches with partial matches and possible double match", (function (param) {
                var count = MasterMind$ReactHooksTemplate.countAllMatches(/* :: */[
                      /* Red */0,
                      /* :: */[
                        /* Green */1,
                        /* :: */[
                          /* Red */0,
                          /* :: */[
                            /* Yellow */3,
                            /* [] */0
                          ]
                        ]
                      ]
                    ], /* :: */[
                      /* Purple */5,
                      /* :: */[
                        /* Red */0,
                        /* :: */[
                          /* Purple */5,
                          /* :: */[
                            /* Purple */5,
                            /* [] */0
                          ]
                        ]
                      ]
                    ]);
                return Jest.Expect[/* toBe */2](1, Jest.Expect[/* expect */0](count));
              }));
        Jest.test("countAllMatches with exact matches and partial matches and possible double match", (function (param) {
                var count = MasterMind$ReactHooksTemplate.countAllMatches(/* :: */[
                      /* Red */0,
                      /* :: */[
                        /* Green */1,
                        /* :: */[
                          /* Red */0,
                          /* :: */[
                            /* Yellow */3,
                            /* [] */0
                          ]
                        ]
                      ]
                    ], /* :: */[
                      /* Purple */5,
                      /* :: */[
                        /* Red */0,
                        /* :: */[
                          /* Purple */5,
                          /* :: */[
                            /* Yellow */3,
                            /* [] */0
                          ]
                        ]
                      ]
                    ]);
                return Jest.Expect[/* toBe */2](2, Jest.Expect[/* expect */0](count));
              }));
        return Jest.test("getScore with exact matches and partial matches and possible double match", (function (param) {
                      var score = MasterMind$ReactHooksTemplate.getScore(/* :: */[
                            /* Red */0,
                            /* :: */[
                              /* Green */1,
                              /* :: */[
                                /* Red */0,
                                /* :: */[
                                  /* Yellow */3,
                                  /* [] */0
                                ]
                              ]
                            ]
                          ], /* :: */[
                            /* Purple */5,
                            /* :: */[
                              /* Red */0,
                              /* :: */[
                                /* Purple */5,
                                /* :: */[
                                  /* Yellow */3,
                                  /* [] */0
                                ]
                              ]
                            ]
                          ]);
                      return Jest.Expect[/* toEqual */12](/* record */[
                                  /* exactMatches */1,
                                  /* colorMatches */1
                                ], Jest.Expect[/* expect */0](score));
                    }));
      }));

/*  Not a pure module */
