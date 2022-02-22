class MockPlacesResponse {
  /// response from query of 'oua'
  static const cityData = [
    {
      "description": "Ouarzazate, Morocco",
      "matched_substrings": [
        {"length": 3, "offset": 0}
      ],
      "place_id": "ChIJVyBCd0AQuw0RAKs3m1LLsyY",
      "reference": "ChIJVyBCd0AQuw0RAKs3m1LLsyY",
      "structured_formatting": {
        "main_text": "Ouarzazate",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Morocco"
      },
      "terms": [
        {"offset": 0, "value": "Ouarzazate"},
        {"offset": 12, "value": "Morocco"}
      ],
      "types": ["locality", "political", "geocode"]
    },
    {
      "description": "Ouagadougou, Burkina Faso",
      "matched_substrings": [
        {"length": 3, "offset": 0}
      ],
      "place_id": "ChIJzUSqzuyVLg4Rizt0nHlnn3k",
      "reference": "ChIJzUSqzuyVLg4Rizt0nHlnn3k",
      "structured_formatting": {
        "main_text": "Ouagadougou",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Burkina Faso"
      },
      "terms": [
        {"offset": 0, "value": "Ouagadougou"},
        {"offset": 13, "value": "Burkina Faso"}
      ],
      "types": ["locality", "political", "geocode"]
    },
    {
      "description": "Ouargla, Algeria",
      "matched_substrings": [
        {"length": 3, "offset": 0}
      ],
      "place_id": "ChIJqbzEeIVrXRIRHafJ0oI-PAY",
      "reference": "ChIJqbzEeIVrXRIRHafJ0oI-PAY",
      "structured_formatting": {
        "main_text": "Ouargla",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Algeria"
      },
      "terms": [
        {"offset": 0, "value": "Ouargla"},
        {"offset": 9, "value": "Algeria"}
      ],
      "types": ["locality", "political", "geocode"]
    },
    {
      "description": "Ouazzane, Morocco",
      "matched_substrings": [
        {"length": 3, "offset": 0}
      ],
      "place_id": "ChIJR8KlqRTyCg0R8OqeVqa84Hg",
      "reference": "ChIJR8KlqRTyCg0R8OqeVqa84Hg",
      "structured_formatting": {
        "main_text": "Ouazzane",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Morocco"
      },
      "terms": [
        {"offset": 0, "value": "Ouazzane"},
        {"offset": 10, "value": "Morocco"}
      ],
      "types": ["locality", "political", "geocode"]
    },
    {
      "description": "Oualidia, Morocco",
      "matched_substrings": [
        {"length": 3, "offset": 0}
      ],
      "place_id": "ChIJNS2cykWtrg0RUtvS6nJPjBU",
      "reference": "ChIJNS2cykWtrg0RUtvS6nJPjBU",
      "structured_formatting": {
        "main_text": "Oualidia",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Morocco"
      },
      "terms": [
        {"offset": 0, "value": "Oualidia"},
        {"offset": 10, "value": "Morocco"}
      ],
      "types": ["locality", "political", "geocode"]
    }
  ];

  static const regionSearchBronx = [
    {
      "description": "Bronx, NY 10451, USA",
      "matched_substrings": [
        {"length": 3, "offset": 10}
      ],
      "place_id": "ChIJ4are_s31wokRPWIfx0e3ELw",
      "reference": "ChIJ4are_s31wokRPWIfx0e3ELw",
      "structured_formatting": {
        "main_text": "10451",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Bronx, NY, USA"
      },
      "terms": [
        {"offset": 0, "value": "Bronx"},
        {"offset": 7, "value": "NY"},
        {"offset": 10, "value": "10451"},
        {"offset": 17, "value": "USA"}
      ],
      "types": ["postal_code", "geocode"]
    },
  ];

  static const regionSearchVancouver = [
    {
      "description": "Vancouver, BC V6H, Canada",
      "matched_substrings": [
        {"length": 3, "offset": 14}
      ],
      "place_id": "ChIJK8OWF8BzhlQRgynmcwSejAM",
      "reference": "ChIJK8OWF8BzhlQRgynmcwSejAM",
      "structured_formatting": {
        "main_text": "V6H",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Vancouver, BC, Canada"
      },
      "terms": [
        {"offset": 0, "value": "Vancouver"},
        {"offset": 11, "value": "BC"},
        {"offset": 14, "value": "V6H"},
        {"offset": 19, "value": "Canada"}
      ],
      "types": ["postal_code_prefix", "postal_code", "geocode"]
    },
    {
      "description": "Vancouver, BC V6H 2X1, Canada",
      "matched_substrings": [
        {"length": 3, "offset": 14}
      ],
      "place_id": "ChIJicOVxpNzhlQR5QrKiJawSYo",
      "reference": "ChIJicOVxpNzhlQR5QrKiJawSYo",
      "structured_formatting": {
        "main_text": "V6H 2X1",
        "main_text_matched_substrings": [
          {"length": 3, "offset": 0}
        ],
        "secondary_text": "Vancouver, BC, Canada"
      },
      "terms": [
        {"offset": 0, "value": "Vancouver"},
        {"offset": 11, "value": "BC"},
        {"offset": 14, "value": "V6H 2X1"},
        {"offset": 23, "value": "Canada"}
      ],
      "types": ["postal_code", "geocode"]
    },
  ];

  static const longUKResponse = {
    "description":
        "Chester Road, Old Trafford, Stretford, Manchester M16 9EA, UK",
    "matched_substrings": [
      {"length": 7, "offset": 50}
    ],
    "place_id": "ChIJY5J3MgOue0gRsrOVSwNRFYc",
    "reference": "ChIJY5J3MgOue0gRsrOVSwNRFYc",
    "structured_formatting": {
      "main_text": "M16 9EA",
      "main_text_matched_substrings": [
        {"length": 7, "offset": 0}
      ],
      "secondary_text": "Chester Road, Old Trafford, Stretford, Manchester, UK"
    },
    "terms": [
      {"offset": 0, "value": "Chester Road"},
      {"offset": 14, "value": "Old Trafford"},
      {"offset": 28, "value": "Stretford"},
      {"offset": 39, "value": "Manchester"},
      {"offset": 50, "value": "M16 9EA"},
      {"offset": 59, "value": "UK"}
    ],
    "types": ["postal_code", "geocode"]
  };

  static const germanyResponse = {
    "description": "Kitzingen, Germany",
    "matched_substrings": [
      {"length": 4, "offset": 0}
    ],
    "place_id": "ChIJ0UKD569iokcREBJi8Ci3HQQ",
    "reference": "ChIJ0UKD569iokcREBJi8Ci3HQQ",
    "structured_formatting": {
      "main_text": "Kitzingen",
      "main_text_matched_substrings": [
        {"length": 4, "offset": 0}
      ],
      "secondary_text": "Germany"
    },
    "terms": [
      {"offset": 0, "value": "Kitzingen"},
      {"offset": 11, "value": "Germany"}
    ],
    "types": ["locality", "political", "geocode"]
  };

  static const turkeyResponse = {
    "description": "Kızıksa, Manyas/Balıkesir, Turkey",
    "matched_substrings": [
      {"length": 5, "offset": 0}
    ],
    "place_id": "ChIJsyFEnsJ8thQR0krXIRfRgMo",
    "reference": "ChIJsyFEnsJ8thQR0krXIRfRgMo",
    "structured_formatting": {
      "main_text": "Kızıksa",
      "main_text_matched_substrings": [
        {"length": 5, "offset": 0}
      ],
      "secondary_text": "Manyas/Balıkesir, Turkey"
    },
    "terms": [
      {"offset": 0, "value": "Kızıksa"},
      {"offset": 9, "value": "Manyas"},
      {"offset": 16, "value": "Balıkesir"},
      {"offset": 27, "value": "Turkey"}
    ],
    "types": ["locality", "political", "geocode"]
  };

  static const predictions = {
    "predictions": [
      {
        "description": "Los Angeles, CA, USA",
        "matched_substrings": [
          {"length": 11, "offset": 0}
        ],
        "place_id": "ChIJE9on3F3HwoAR9AhGJW_fL-I",
        "reference": "ChIJE9on3F3HwoAR9AhGJW_fL-I",
        "structured_formatting": {
          "main_text": "Los Angeles",
          "main_text_matched_substrings": [
            {"length": 11, "offset": 0}
          ],
          "secondary_text": "CA, USA"
        },
        "terms": [
          {"offset": 0, "value": "Los Angeles"},
          {"offset": 13, "value": "CA"},
          {"offset": 17, "value": "USA"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Los Ángeles, Chile",
        "matched_substrings": [
          {"length": 11, "offset": 0}
        ],
        "place_id": "ChIJVzZSaUbda5YRdwhonSL2GIM",
        "reference": "ChIJVzZSaUbda5YRdwhonSL2GIM",
        "structured_formatting": {
          "main_text": "Los Ángeles",
          "main_text_matched_substrings": [
            {"length": 11, "offset": 0}
          ],
          "secondary_text": "Chile"
        },
        "terms": [
          {"offset": 0, "value": "Los Ángeles"},
          {"offset": 13, "value": "Chile"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Los Angeles, TX, USA",
        "matched_substrings": [
          {"length": 11, "offset": 0}
        ],
        "place_id": "ChIJVZfDDk33XYYRo52xLqc4uWg",
        "reference": "ChIJVZfDDk33XYYRo52xLqc4uWg",
        "structured_formatting": {
          "main_text": "Los Angeles",
          "main_text_matched_substrings": [
            {"length": 11, "offset": 0}
          ],
          "secondary_text": "TX, USA"
        },
        "terms": [
          {"offset": 0, "value": "Los Angeles"},
          {"offset": 13, "value": "TX"},
          {"offset": 17, "value": "USA"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Los Ángeles de San Rafael, Spain",
        "matched_substrings": [
          {"length": 11, "offset": 0}
        ],
        "place_id": "ChIJs9LB-pUQQQ0RSAsFwL-VbN4",
        "reference": "ChIJs9LB-pUQQQ0RSAsFwL-VbN4",
        "structured_formatting": {
          "main_text": "Los Ángeles de San Rafael",
          "main_text_matched_substrings": [
            {"length": 11, "offset": 0}
          ],
          "secondary_text": "Spain"
        },
        "terms": [
          {"offset": 0, "value": "Los Ángeles de San Rafael"},
          {"offset": 27, "value": "Spain"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Los Ángeles, Qro., Mexico",
        "matched_substrings": [
          {"length": 11, "offset": 0}
        ],
        "place_id": "ChIJLV12fv9O04URpKhmcv884Is",
        "reference": "ChIJLV12fv9O04URpKhmcv884Is",
        "structured_formatting": {
          "main_text": "Los Ángeles",
          "main_text_matched_substrings": [
            {"length": 11, "offset": 0}
          ],
          "secondary_text": "Qro., Mexico"
        },
        "terms": [
          {"offset": 0, "value": "Los Ángeles"},
          {"offset": 13, "value": "Qro."},
          {"offset": 19, "value": "Mexico"}
        ],
        "types": ["locality", "political", "geocode"]
      }
    ],
    "status": "OK"
  };

  static const newOrleans = {
    "predictions": [
      {
        "description": "New Orleans, LA, USA",
        "matched_substrings": [
          {"length": 11, "offset": 0}
        ],
        "place_id": "ChIJZYIRslSkIIYRtNMiXuhbBts",
        "reference": "ChIJZYIRslSkIIYRtNMiXuhbBts",
        "structured_formatting": {
          "main_text": "New Orleans",
          "main_text_matched_substrings": [
            {"length": 11, "offset": 0}
          ],
          "secondary_text": "LA, USA"
        },
        "terms": [
          {"offset": 0, "value": "New Orleans"},
          {"offset": 13, "value": "LA"},
          {"offset": 17, "value": "USA"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "New Orleans, Campbeltown, UK",
        "matched_substrings": [
          {"length": 11, "offset": 0}
        ],
        "place_id": "ChIJofPvz9sAikgRq8siulDrZLM",
        "reference": "ChIJofPvz9sAikgRq8siulDrZLM",
        "structured_formatting": {
          "main_text": "New Orleans",
          "main_text_matched_substrings": [
            {"length": 11, "offset": 0}
          ],
          "secondary_text": "Campbeltown, UK"
        },
        "terms": [
          {"offset": 0, "value": "New Orleans"},
          {"offset": 13, "value": "Campbeltown"},
          {"offset": 26, "value": "UK"}
        ],
        "types": ["locality", "political", "geocode"]
      }
    ],
    "status": "OK"
  };


/// response from 'sera' query
  static const seraQuery = {
    "predictions": [
      {
        "description": "Serang, Serang City, Banten, Indonesia",
        "matched_substrings": [
          {"length": 4, "offset": 0}
        ],
        "place_id": "ChIJYUpTuw2LQS4R0Lgo_PHoAQM",
        "reference": "ChIJYUpTuw2LQS4R0Lgo_PHoAQM",
        "structured_formatting": {
          "main_text": "Serang",
          "main_text_matched_substrings": [
            {"length": 4, "offset": 0}
          ],
          "secondary_text": "Serang City, Banten, Indonesia"
        },
        "terms": [
          {"offset": 0, "value": "Serang"},
          {"offset": 8, "value": "Serang City"},
          {"offset": 21, "value": "Banten"},
          {"offset": 29, "value": "Indonesia"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Seraing, Belgium",
        "matched_substrings": [
          {"length": 4, "offset": 0}
        ],
        "place_id": "ChIJTZXe9_74wEcREHBNL6uZAAQ",
        "reference": "ChIJTZXe9_74wEcREHBNL6uZAAQ",
        "structured_formatting": {
          "main_text": "Seraing",
          "main_text_matched_substrings": [
            {"length": 4, "offset": 0}
          ],
          "secondary_text": "Belgium"
        },
        "terms": [
          {"offset": 0, "value": "Seraing"},
          {"offset": 9, "value": "Belgium"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Scranton, PA, USA",
        "matched_substrings": [
          {"length": 8, "offset": 0}
        ],
        "place_id": "ChIJu0tIdzrZxIkR6PqbqyB58v8",
        "reference": "ChIJu0tIdzrZxIkR6PqbqyB58v8",
        "structured_formatting": {
          "main_text": "Scranton",
          "main_text_matched_substrings": [
            {"length": 8, "offset": 0}
          ],
          "secondary_text": "PA, USA"
        },
        "terms": [
          {"offset": 0, "value": "Scranton"},
          {"offset": 10, "value": "PA"},
          {"offset": 14, "value": "USA"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Seravezza, Province of Lucca, Italy",
        "matched_substrings": [
          {"length": 4, "offset": 0}
        ],
        "place_id": "ChIJof6vYRIL1RIRH7fJc5sPvRE",
        "reference": "ChIJof6vYRIL1RIRH7fJc5sPvRE",
        "structured_formatting": {
          "main_text": "Seravezza",
          "main_text_matched_substrings": [
            {"length": 4, "offset": 0}
          ],
          "secondary_text": "Province of Lucca, Italy"
        },
        "terms": [
          {"offset": 0, "value": "Seravezza"},
          {"offset": 11, "value": "Province of Lucca"},
          {"offset": 30, "value": "Italy"}
        ],
        "types": ["locality", "political", "geocode"]
      },
      {
        "description": "Saranac Lake, NY, USA",
        "matched_substrings": [
          {"length": 12, "offset": 0}
        ],
        "place_id": "ChIJQR9DETIQy0wRjBai5VZB6fw",
        "reference": "ChIJQR9DETIQy0wRjBai5VZB6fw",
        "structured_formatting": {
          "main_text": "Saranac Lake",
          "main_text_matched_substrings": [
            {"length": 12, "offset": 0}
          ],
          "secondary_text": "NY, USA"
        },
        "terms": [
          {"offset": 0, "value": "Saranac Lake"},
          {"offset": 14, "value": "NY"},
          {"offset": 18, "value": "USA"}
        ],
        "types": ["locality", "political", "geocode"]
      }
    ],
    "status": "OK"
  };

  static const noResults = {"predictions": [], "status": "ZERO_RESULTS"};
}
