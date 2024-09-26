class USStates {
  static final states = {
    'AK': 'Alaska',
    'AL': 'Alabama',
    'AR': 'Arkansas',
    'AS': 'American Samoa',
    'AZ': 'Arizona',
    'CA': 'California',
    'CO': 'Colorado',
    'CT': 'Connecticut',
    'DC': 'District of Columbia',
    'DE': 'Delaware',
    'FL': 'Florida',
    'GA': 'Georgia',
    'GU': 'Guam',
    'HI': 'Hawaii',
    'IA': 'Iowa',
    'ID': 'Idaho',
    'IL': 'Illinois',
    'IN': 'Indiana',
    'KS': 'Kansas',
    'KY': 'Kentucky',
    'LA': 'Louisiana',
    'MA': 'Massachusetts',
    'MD': 'Maryland',
    'ME': 'Maine',
    'MI': 'Michigan',
    'MN': 'Minnesota',
    'MO': 'Missouri',
    'MS': 'Mississippi',
    'MT': 'Montana',
    'NC': 'North Carolina',
    'ND': 'North Dakota',
    'NE': 'Nebraska',
    'NH': 'New Hampshire',
    'NJ': 'New Jersey',
    'NM': 'New Mexico',
    'NV': 'Nevada',
    'NY': 'New York',
    'OH': 'Ohio',
    'OK': 'Oklahoma',
    'OR': 'Oregon',
    'PA': 'Pennsylvania',
    'PR': 'Puerto Rico',
    'RI': 'Rhode Island',
    'SC': 'South Carolina',
    'SD': 'South Dakota',
    'TN': 'Tennessee',
    'TX': 'Texas',
    'UT': 'Utah',
    'VA': 'Virginia',
    'VI': 'Virgin Islands',
    'VT': 'Vermont',
    'WA': 'Washington',
    'WI': 'Wisconsin',
    'WV': 'West Virginia',
    'WY': 'Wyoming',
  };

  /// Takes case-insensitive name of state and returns abbreviation.
  ///
  /// If abbreviation is not found, empty string is returned.
  static String getAbbreviation(String stateName) {
    final name = stateName.trim().toLowerCase();

    return states.keys.firstWhere(
      (key) => states[key]!.toLowerCase() == name,
      orElse: () => '',
    );
  }

  /// Takes case-insensitive abbreviation of state and returns name.
  ///
  /// If name is not found, unchanged argument is returned
  static String getName(String stateAbbreviation) {
    final abbrev = stateAbbreviation.toUpperCase();

    if (states.containsKey(abbrev)) {
      return states[abbrev]!;
    }

    return stateAbbreviation;
  }

  /// Returns list of all abbreviations.
  static List<String> getAllAbbreviations() {
    return states.keys.toList();
  }

  /// Returns list of all names.
  static List<String> getAllNames() {
    return states.values.toList();
  }

  /// Returns map of Abbreviations as Keys and Names as Values.
  static Map<String, String> getAbbreviationMap() {
    return states;
  }

  /// Returns map of Names as Keys and Abbreviations as Values.
  static Map<String, String> getNameMap() {
    final nameMap = <String, String>{};

    states.forEach((key, value) {
      nameMap[value] = key;
    });

    return nameMap;
  }
}
