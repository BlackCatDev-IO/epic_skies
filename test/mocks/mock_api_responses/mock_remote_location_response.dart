// ignore_for_file: inference_failure_on_collection_literal
// ignore_for_file: prefer_single_quotes

class MockRemoteLocationResponse {
  static const Map<String, dynamic> ouagadougo = {
    "html_attributions": [],
    "result": {
      "address_components": [
        {
          "long_name": "Ouagadougou",
          "short_name": "Ouagadougou",
          "types": ["locality", "political"]
        },
        {
          "long_name": "Kadiogo",
          "short_name": "Kadiogo",
          "types": ["administrative_area_level_2", "political"]
        },
        {
          "long_name": "Centre Region",
          "short_name": "Centre Region",
          "types": ["administrative_area_level_1", "political"]
        },
        {
          "long_name": "Burkina Faso",
          "short_name": "BF",
          "types": ["country", "political"]
        }
      ],
      "geometry": {
        "location": {"lat": 12.3714277, "lng": -1.5196603},
        "viewport": {
          "northeast": {"lat": 12.44956786221823, "lng": -1.423609318889351},
          "southwest": {"lat": 12.26741622535668, "lng": -1.650077330979304}
        }
      }
    },
    "status": "OK"
  };
  static const Map<String, dynamic> newcastle = {
    "html_attributions": [],
    "result": {
      "address_components": [
        {
          "long_name": "Newcastle upon Tyne",
          "short_name": "Newcastle upon Tyne",
          "types": ["locality", "political"]
        },
        {
          "long_name": "Newcastle upon Tyne",
          "short_name": "Newcastle upon Tyne",
          "types": ["postal_town"]
        },
        {
          "long_name": "Tyne and Wear",
          "short_name": "Tyne and Wear",
          "types": ["administrative_area_level_2", "political"]
        },
        {
          "long_name": "England",
          "short_name": "England",
          "types": ["administrative_area_level_1", "political"]
        },
        {
          "long_name": "United Kingdom",
          "short_name": "GB",
          "types": ["country", "political"]
        }
      ],
      "geometry": {
        "location": {"lat": 54.978252, "lng": -1.61778},
        "viewport": {
          "northeast": {"lat": 55.0453044276655, "lng": -1.53260514152927},
          "southwest": {"lat": 54.95943993696575, "lng": -1.781081723754711}
        }
      }
    },
    "status": "OK"
  };
  static const Map<String, dynamic> newOrleans = {
    "html_attributions": [],
    "result": {
      "address_components": [
        {
          "long_name": "New Orleans",
          "short_name": "New Orleans",
          "types": ["locality", "political"]
        },
        {
          "long_name": "Orleans Parish",
          "short_name": "Orleans Parish",
          "types": ["administrative_area_level_2", "political"]
        },
        {
          "long_name": "Louisiana",
          "short_name": "LA",
          "types": ["administrative_area_level_1", "political"]
        },
        {
          "long_name": "United States",
          "short_name": "US",
          "types": ["country", "political"]
        }
      ],
      "geometry": {
        "location": {"lat": 29.95106579999999, "lng": -90.0715323},
        "viewport": {
          "northeast": {"lat": 30.1993320469461, "lng": -89.62505299904657},
          "southwest": {"lat": 29.86666092083858, "lng": -90.14007393117254}
        }
      }
    },
    "status": "OK"
  };

  static const Map<String, dynamic> ranchoSantaMargarita = {
    "html_attributions": [],
    "result": {
      "address_components": [
        {
          "long_name": "Rancho Santa Margarita",
          "short_name": "Rancho Santa Margarita",
          "types": ["locality", "political"]
        },
        {
          "long_name": "Orange County",
          "short_name": "Orange County",
          "types": ["administrative_area_level_2", "political"]
        },
        {
          "long_name": "California",
          "short_name": "CA",
          "types": ["administrative_area_level_1", "political"]
        },
        {
          "long_name": "United States",
          "short_name": "US",
          "types": ["country", "political"]
        }
      ],
      "geometry": {
        "location": {"lat": 33.640171, "lng": -117.602832},
        "viewport": {
          "northeast": {"lat": 33.66984217697392, "lng": -117.5520253561849},
          "southwest": {"lat": 33.58603436492783, "lng": -117.6382602589738}
        }
      }
    },
    "status": "OK"
  };

  static const Map<String, dynamic> calcutta = {
    "html_attributions": [],
    "result": {
      "address_components": [
        {
          "long_name": "Kolkata",
          "short_name": "Kolkata",
          "types": ["locality", "political"]
        },
        {
          "long_name": "West Bengal",
          "short_name": "WB",
          "types": ["administrative_area_level_1", "political"]
        },
        {
          "long_name": "India",
          "short_name": "IN",
          "types": ["country", "political"]
        }
      ],
      "geometry": {
        "location": {"lat": 22.572646, "lng": 88.36389500000001},
        "viewport": {
          "northeast": {"lat": 23.00836279115057, "lng": 88.54286962300792},
          "southwest": {"lat": 22.3436287990453, "lng": 88.11658787077842}
        }
      }
    },
    "status": "OK"
  };
}
