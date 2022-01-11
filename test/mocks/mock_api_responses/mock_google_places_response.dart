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
}
