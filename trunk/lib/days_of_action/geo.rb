module DaysOfAction
  module Geo
    STATE_CENTERS = {
      :AK => [62.9952,-149.59],
      :AL => [32.8242,-86.7041],
      :AR => [34.597,-92.3291],
      :AZ => [34.3797,-111.709],
      :CA => [37.3702,-120.234],
      :CO => [38.8568,-105.557],
      :CT => [41.5661,-72.7405],
      :DC => [38.8985,-77.0251],
      :DE => [39.0106,-75.4541],
      :FL => [28.3044,-82.0459],
      :GA => [32.8427,-83.4521],
      :HI => [21.313,-157.856],
      :IA => [42.0982,-93.4937],
      :ID => [45.7062,-114.565],
      :IL => [39.8929,-89.3188],
      :IN => [40.1117,-86.1328],
      :KS => [38.6512,-98.3496],
      :KY => [37.3876,-85.7153],
      :LA => [31.2598,-92.439],
      :MA => [42.2285,-71.6968],
      :MD => [39.1301,-76.5527],
      :ME => [45.383,-69.1919],
      :MI => [43.7711,-84.9243],
      :MN => [46.0427,-93.999],
      :MO => [38.5482,-92.4829],
      :MS => [32.6764,-89.5605],
      :MT => [46.8602,-109.731],
      :NC => [35.6216,-79.2993],
      :ND => [47.4578,-100.371],
      :NE => [41.5744,-99.4482],
      :NH => [43.9928,-71.6638],
      :NJ => [40.246,-74.6521],
      :NM => [34.5247,-106.172],
      :NV => [39.741,-117.158],
      :NY => [42.7309,-75.9595],
      :OH => [40.3298,-82.6831],
      :OK => [35.389,-97.4268],
      :OR => [43.8979,-120.762],
      :PA => [40.9965,-77.6074],
      :RI => [41.7713,-71.5704],
      :SC => [33.7974,-80.8154],
      :SD => [44.4652,-100.283],
      :TN => [35.8178,-86.4844],
      :TX => [31.8029,-99.5361],
      :UT => [39.6395,-111.643],
      :VA => [37.4574,-79.3872],
      :VT => [43.9533,-72.4878],
      :WA => [47.3537,-120.674],
      :WI => [44.8247,-89.8462],
      :WV => [38.7883,-80.6177],
      :WY => [42.876,-107.798],
      
      :BC => [54.115749,-126.550710],
      :MB => [55.279115,-68.466797],
      :NF => [65.910623,-132.363281], 
      :NB => [55.229023,-95.493164], 
      :NS => [46.7248,-66.247559], 
      :NT => [46.634351,-64.775391],  
      :NU => [71.074056,-119.179687], 
      :ON => [50.903033,-84.726562],
      :PE => [67.135829,-91.054687],      
      :QC => [47.032695,-71.224365],
      :SK => [46.743625,-63.050537], 
      :YT => [55.229023,-105.688477]
   

    }

    OLD_STATE_CENTERS = {
      :AL => [34.7356758024691,-86.5923922224596],
      :AK => [53.3308100550838,-168.187470829389],
      :AZ => [36.2463773395062,-111.615135530525],
      :AR => [36.3745018333333,-92.2404553521374],
      :CA => [34.034180345679,-120.386475658584],
      :CO => [40.1123906851852,-105.837605375902],
      :CT => [41.7653157407408,-72.7500704191033],
      :DE => [39.5919031111111,-75.5734057276619],
      :DC => [38.9432264290123,-77.014843331318],
      :FL => [24.8239841227306,-80.8128505589159],
      :GA => [34.8044546604938,-83.4848125832388],
      :HI => [23.7284171581896,-166.171539079549],
      :ID => [46.0109290123457,-115.25942158465],
      :IL => [42.3841872530864,-89.4736534897358],
      :IN => [41.637323308642,-86.1259739940181],
      :IA => [43.3672035185185,-93.5547624934191],
      :KS => [39.8555297623457,-98.3303635104984],
      :KY => [38.859923462963,-84.6841789112593],
      :LA => [29.8796603709091,-88.8255873459908],
      :ME => [43.6900192271536,-70.1578640420269],
      :MD => [38.1788128833971,-76.0527088760855],
      :MA => [42.5447558209877,-71.9165613329627],
      :MI => [45.6625052222222,-85.5537117162697],
      :MN => [48.7185493950617,-94.5945829561728],
      :MS => [34.6460881388889,-89.4242207167089],
      :MO => [40.403672037037,-92.5918042214141],
      :MT => [48.4396797777778,-109.192907672176],
      :NE => [42.2346756358025,-99.9053783224672],
      :NV => [39.6569722716049,-117.034131681386],
      :NH => [43.6958601450617,-71.5101267326957],
      :NJ => [40.9233455308642,-74.638104312308],
      :NM => [36.5294757469136,-105.857244341589],
      :NY => [40.8539188888889,-73.7699673858154],
      :NC => [36.4464627530864,-79.6107260441304],
      :ND => [48.6260139475309,-99.6237594623845],
      :OH => [41.6527994699955,-82.8207385186695],
      :OK => [36.6829932839506,-97.5522601607084],
      :OR => [45.3428610617284,-121.378793620387],
      :PA => [41.9217809814815,-78.0204010573646],
      :PR => [18.3231539012346,-65.2732113512323],
      :RI => [41.5234845535524,-71.3834372851514],
      :SC => [34.888059808642,-81.0260661357534],
      :SD => [45.6913540185185,-99.9036100826851],
      :TN => [36.4820787993827,-86.5863271120342],
      :TX => [27.6294930593335,-97.1996143438316],
      :UT => [41.3986721296296,-111.260921682652],
      :VT => [44.5024862469136,-72.7303999097772],
      :VA => [37.9466637839506,-76.0240703187518],
      :WA => [48.6648342044502,-123.174473648561],
      :WV => [39.5697930246914,-80.627783600124],
      :WI => [45.3700939324083,-86.9017926206626],
      :WY => [43.8752936296296,-107.365810650813]
    }
    STATE_ZOOM_LEVELS = {
      :AL => 6,
      :AK => 3,
      :AZ => 5,
      :AR => 6,
      :CA => 5,
      :CO => 5,
      :CT => 7,
      :DE => 7,
      :FL => 5,
      :GA => 6,
      :HI => 6,
      :ID => 5,
      :IL => 6,
      :IN => 6,
      :IA => 6,
      :KS => 5,
      :KY => 6,
      :LA => 6,
      :ME => 6,
      :MD => 6,
      :MA => 7,
      :MI => 6,
      :MN => 5,
      :MS => 6,
      :MO => 6,
      :MT => 5,
      :NE => 5,
      :NV => 5,
      :NH => 7,
      :NJ => 7,
      :NM => 5,
      :NY => 6,
      :NC => 6,
      :ND => 5,
      :OH => 6,
      :OK => 5,
      :OR => 5,
      :PA => 6,
      :RI => 8,
      :SC => 6,
      :SD => 5,
      :TN => 6,
      :TX => 5,
      :UT => 6,
      :VT => 7,
      :VA => 6,
      :WA => 5,
      :WV => 6,
      :WI => 6,
      :WY => 5,
      
      :BC => 3,
      :MB => 3,
      :NF => 6, 
      :NB => 6,
      :NS => 6, 
      :NT => 3,
      :NU => 3, 
      :ON => 5,
      :PE => 5,     
      :QC => 4,
      :SK => 3, 
      :YT => 3
      
    }
  end
end
