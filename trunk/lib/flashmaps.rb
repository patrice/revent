module Flashmaps
  #[:stateID, :districtID, :district]
  DISTRICTS = [
    ['us_ak', 'one', '00'],
    ['us_al', '1', '01'],
    ['us_al', '2', '02'],
    ['us_al', '3', '03'],
    ['us_al', '4', '04'],
    ['us_al', '5', '05'],
    ['us_al', '6', '06'],
    ['us_al', '7', '07'],
    ['us_ar', '1', '01'],
    ['us_ar', '2', '02'],
    ['us_ar', '3', '03'],
    ['us_ar', '4', '04'],
    ['us_az', '1', '01'],
    ['us_az', '2', '02'],
    ['us_az', '3', '03'],
    ['us_az', '4', '04'],
    ['us_az', '5', '05'],
    ['us_az', '6', '06'],
    ['us_az', '7', '07'],
    ['us_az', '8', '08'],
    ['us_ca', '1', '01'],
    ['us_ca', '10', '10'],
    ['us_ca', '11', '11'],
    ['us_ca', '12', '12'],
    ['us_ca', '13', '13'],
    ['us_ca', '14', '14'],
    ['us_ca', '15', '15'],
    ['us_ca', '16', '16'],
    ['us_ca', '17', '17'],
    ['us_ca', '18', '18'],
    ['us_ca', '19', '19'],
    ['us_ca', '2', '02'],
    ['us_ca', '20', '20'],
    ['us_ca', '21', '21'],
    ['us_ca', '22', '22'],
    ['us_ca', '23', '23'],
    ['us_ca', '24', '24'],
    ['us_ca', '25', '25'],
    ['us_ca', '26', '26'],
    ['us_ca', '27', '27'],
    ['us_ca', '28', '28'],
    ['us_ca', '29', '29'],
    ['us_ca', '3', '03'],
    ['us_ca', '30', '30'],
    ['us_ca', '31', '31'],
    ['us_ca', '32', '32'],
    ['us_ca', '33', '33'],
    ['us_ca', '34', '34'],
    ['us_ca', '35', '35'],
    ['us_ca', '36', '36'],
    ['us_ca', '37', '37'],
    ['us_ca', '38', '38'],
    ['us_ca', '39', '39'],
    ['us_ca', '4', '04'],
    ['us_ca', '40', '40'],
    ['us_ca', '41', '41'],
    ['us_ca', '42', '42'],
    ['us_ca', '43', '43'],
    ['us_ca', '44', '44'],
    ['us_ca', '45', '45'],
    ['us_ca', '46', '46'],
    ['us_ca', '47', '47'],
    ['us_ca', '48', '48'],
    ['us_ca', '49', '49'],
    ['us_ca', '5', '05'],
    ['us_ca', '50', '50'],
    ['us_ca', '51', '51'],
    ['us_ca', '52', '52'],
    ['us_ca', '53', '53'],
    ['us_ca', '6', '06'],
    ['us_ca', '7', '07'],
    ['us_ca', '8', '08'],
    ['us_ca', '9', '09'],
    ['us_co', '1', '01'],
    ['us_co', '2', '02'],
    ['us_co', '3', '03'],
    ['us_co', '4', '04'],
    ['us_co', '5', '05'],
    ['us_co', '6', '06'],
    ['us_co', '7', '07'],
    ['us_ct', '1', '01'],
    ['us_ct', '2', '02'],
    ['us_ct', '3', '03'],
    ['us_ct', '4', '04'],
    ['us_ct', '5', '05'],
    ['us_dc', '98', '98'],
    ['us_de', 'one', '00'],
    ['us_fl', '1', '01'],
    ['us_fl', '10', '10'],
    ['us_fl', '11', '11'],
    ['us_fl', '12', '12'],
    ['us_fl', '13', '13'],
    ['us_fl', '14', '14'],
    ['us_fl', '15', '15'],
    ['us_fl', '16', '16'],
    ['us_fl', '17', '17'],
    ['us_fl', '18', '18'],
    ['us_fl', '19', '19'],
    ['us_fl', '2', '02'],
    ['us_fl', '20', '20'],
    ['us_fl', '21', '21'],
    ['us_fl', '22', '22'],
    ['us_fl', '23', '23'],
    ['us_fl', '24', '24'],
    ['us_fl', '25', '25'],
    ['us_fl', '3', '03'],
    ['us_fl', '4', '04'],
    ['us_fl', '5', '05'],
    ['us_fl', '6', '06'],
    ['us_fl', '7', '07'],
    ['us_fl', '8', '08'],
    ['us_fl', '9', '09'],
    ['us_ga', '1', '01'],
    ['us_ga', '10', '10'],
    ['us_ga', '11', '11'],
    ['us_ga', '12', '12'],
    ['us_ga', '13', '13'],
    ['us_ga', '2', '02'],
    ['us_ga', '3', '03'],
    ['us_ga', '4', '04'],
    ['us_ga', '5', '05'],
    ['us_ga', '6', '06'],
    ['us_ga', '7', '07'],
    ['us_ga', '8', '08'],
    ['us_ga', '9', '09'],
    ['us_hi', '1', '01'],
    ['us_hi', '2', '02'],
    ['us_ia', '1', '01'],
    ['us_ia', '2', '02'],
    ['us_ia', '3', '03'],
    ['us_ia', '4', '04'],
    ['us_ia', '5', '05'],
    ['us_id', '1', '01'],
    ['us_id', '2', '02'],
    ['us_il', '1', '01'],
    ['us_il', '10', '10'],
    ['us_il', '11', '11'],
    ['us_il', '12', '12'],
    ['us_il', '13', '13'],
    ['us_il', '14', '14'],
    ['us_il', '15', '15'],
    ['us_il', '16', '16'],
    ['us_il', '17', '17'],
    ['us_il', '18', '18'],
    ['us_il', '19', '19'],
    ['us_il', '2', '02'],
    ['us_il', '3', '03'],
    ['us_il', '4', '04'],
    ['us_il', '5', '05'],
    ['us_il', '6', '06'],
    ['us_il', '7', '07'],
    ['us_il', '8', '08'],
    ['us_il', '9', '09'],
    ['us_in', '1', '01'],
    ['us_in', '2', '02'],
    ['us_in', '3', '03'],
    ['us_in', '4', '04'],
    ['us_in', '5', '05'],
    ['us_in', '6', '06'],
    ['us_in', '7', '07'],
    ['us_in', '8', '08'],
    ['us_in', '9', '09'],
    ['us_ks', '1', '01'],
    ['us_ks', '2', '02'],
    ['us_ks', '3', '03'],
    ['us_ks', '4', '04'],
    ['us_ky', '1', '01'],
    ['us_ky', '2', '02'],
    ['us_ky', '3', '03'],
    ['us_ky', '4', '04'],
    ['us_ky', '5', '05'],
    ['us_ky', '6', '06'],
    ['us_la', '1', '01'],
    ['us_la', '2', '02'],
    ['us_la', '3', '03'],
    ['us_la', '4', '04'],
    ['us_la', '5', '05'],
    ['us_la', '6', '06'],
    ['us_la', '7', '07'],
    ['us_ma', '1', '01'],
    ['us_ma', '10', '10'],
    ['us_ma', '2', '02'],
    ['us_ma', '3', '03'],
    ['us_ma', '4', '04'],
    ['us_ma', '5', '05'],
    ['us_ma', '6', '06'],
    ['us_ma', '7', '07'],
    ['us_ma', '8', '08'],
    ['us_ma', '9', '09'],
    ['us_md', '1', '01'],
    ['us_md', '2', '02'],
    ['us_md', '3', '03'],
    ['us_md', '4', '04'],
    ['us_md', '5', '05'],
    ['us_md', '6', '06'],
    ['us_md', '7', '07'],
    ['us_md', '8', '08'],
    ['us_me', '1', '01'],
    ['us_me', '2', '02'],
    ['us_mi', '1', '01'],
    ['us_mi', '10', '10'],
    ['us_mi', '11', '11'],
    ['us_mi', '12', '12'],
    ['us_mi', '13', '13'],
    ['us_mi', '14', '14'],
    ['us_mi', '15', '15'],
    ['us_mi', '2', '02'],
    ['us_mi', '3', '03'],
    ['us_mi', '4', '04'],
    ['us_mi', '5', '05'],
    ['us_mi', '6', '06'],
    ['us_mi', '7', '07'],
    ['us_mi', '8', '08'],
    ['us_mi', '9', '09'],
    ['us_mn', '1', '01'],
    ['us_mn', '2', '02'],
    ['us_mn', '3', '03'],
    ['us_mn', '4', '04'],
    ['us_mn', '5', '05'],
    ['us_mn', '6', '06'],
    ['us_mn', '7', '07'],
    ['us_mn', '8', '08'],
    ['us_mo', '1', '01'],
    ['us_mo', '2', '02'],
    ['us_mo', '3', '03'],
    ['us_mo', '4', '04'],
    ['us_mo', '5', '05'],
    ['us_mo', '6', '06'],
    ['us_mo', '7', '07'],
    ['us_mo', '8', '08'],
    ['us_mo', '9', '09'],
    ['us_ms', '1', '01'],
    ['us_ms', '2', '02'],
    ['us_ms', '3', '03'],
    ['us_ms', '4', '04'],
    ['us_mt', 'one', '00'],
    ['us_nc', '1', '01'],
    ['us_nc', '10', '10'],
    ['us_nc', '11', '11'],
    ['us_nc', '12', '12'],
    ['us_nc', '13', '13'],
    ['us_nc', '2', '02'],
    ['us_nc', '3', '03'],
    ['us_nc', '4', '04'],
    ['us_nc', '5', '05'],
    ['us_nc', '6', '06'],
    ['us_nc', '7', '07'],
    ['us_nc', '8', '08'],
    ['us_nc', '9', '09'],
    ['us_nd', 'one', '00'],
    ['us_ne', '1', '01'],
    ['us_ne', '2', '02'],
    ['us_ne', '3', '03'],
    ['us_nh', '1', '01'],
    ['us_nh', '2', '02'],
    ['us_nj', '1', '01'],
    ['us_nj', '10', '10'],
    ['us_nj', '11', '11'],
    ['us_nj', '12', '12'],
    ['us_nj', '13', '13'],
    ['us_nj', '2', '02'],
    ['us_nj', '3', '03'],
    ['us_nj', '4', '04'],
    ['us_nj', '5', '05'],
    ['us_nj', '6', '06'],
    ['us_nj', '7', '07'],
    ['us_nj', '8', '08'],
    ['us_nj', '9', '09'],
    ['us_nm', '1', '01'],
    ['us_nm', '2', '02'],
    ['us_nm', '3', '03'],
    ['us_nv', '1', '01'],
    ['us_nv', '2', '02'],
    ['us_nv', '3', '03'],
    ['us_ny', '1', '01'],
    ['us_ny', '10', '10'],
    ['us_ny', '11', '11'],
    ['us_ny', '12', '12'],
    ['us_ny', '13', '13'],
    ['us_ny', '14', '14'],
    ['us_ny', '15', '15'],
    ['us_ny', '16', '16'],
    ['us_ny', '17', '17'],
    ['us_ny', '18', '18'],
    ['us_ny', '19', '19'],
    ['us_ny', '2', '02'],
    ['us_ny', '20', '20'],
    ['us_ny', '21', '21'],
    ['us_ny', '22', '22'],
    ['us_ny', '23', '23'],
    ['us_ny', '24', '24'],
    ['us_ny', '25', '25'],
    ['us_ny', '26', '26'],
    ['us_ny', '27', '27'],
    ['us_ny', '28', '28'],
    ['us_ny', '29', '29'],
    ['us_ny', '3', '03'],
    ['us_ny', '4', '04'],
    ['us_ny', '5', '05'],
    ['us_ny', '6', '06'],
    ['us_ny', '7', '07'],
    ['us_ny', '8', '08'],
    ['us_ny', '9', '09'],
    ['us_oh', '1', '01'],
    ['us_oh', '10', '10'],
    ['us_oh', '11', '11'],
    ['us_oh', '12', '12'],
    ['us_oh', '13', '13'],
    ['us_oh', '14', '14'],
    ['us_oh', '15', '15'],
    ['us_oh', '16', '16'],
    ['us_oh', '17', '17'],
    ['us_oh', '18', '18'],
    ['us_oh', '2', '02'],
    ['us_oh', '3', '03'],
    ['us_oh', '4', '04'],
    ['us_oh', '5', '05'],
    ['us_oh', '6', '06'],
    ['us_oh', '7', '07'],
    ['us_oh', '8', '08'],
    ['us_oh', '9', '09'],
    ['us_ok', '1', '01'],
    ['us_ok', '2', '02'],
    ['us_ok', '3', '03'],
    ['us_ok', '4', '04'],
    ['us_ok', '5', '05'],
    ['us_or', '1', '01'],
    ['us_or', '2', '02'],
    ['us_or', '3', '03'],
    ['us_or', '4', '04'],
    ['us_or', '5', '05'],
    ['us_pa', '1', '01'],
    ['us_pa', '10', '10'],
    ['us_pa', '11', '11'],
    ['us_pa', '12', '12'],
    ['us_pa', '13', '13'],
    ['us_pa', '14', '14'],
    ['us_pa', '15', '15'],
    ['us_pa', '16', '16'],
    ['us_pa', '17', '17'],
    ['us_pa', '18', '18'],
    ['us_pa', '19', '19'],
    ['us_pa', '2', '02'],
    ['us_pa', '3', '03'],
    ['us_pa', '4', '04'],
    ['us_pa', '5', '05'],
    ['us_pa', '6', '06'],
    ['us_pa', '7', '07'],
    ['us_pa', '8', '08'],
    ['us_pa', '9', '09'],
    ['us_pr', '98', '98'],
    ['us_ri', '1', '01'],
    ['us_ri', '2', '02'],
    ['us_sc', '1', '01'],
    ['us_sc', '2', '02'],
    ['us_sc', '3', '03'],
    ['us_sc', '4', '04'],
    ['us_sc', '5', '05'],
    ['us_sc', '6', '06'],
    ['us_sd', 'one', '00'],
    ['us_tn', '1', '01'],
    ['us_tn', '2', '02'],
    ['us_tn', '3', '03'],
    ['us_tn', '4', '04'],
    ['us_tn', '5', '05'],
    ['us_tn', '6', '06'],
    ['us_tn', '7', '07'],
    ['us_tn', '8', '08'],
    ['us_tn', '9', '09'],
    ['us_tx', '1', '01'],
    ['us_tx', '10', '10'],
    ['us_tx', '11', '11'],
    ['us_tx', '12', '12'],
    ['us_tx', '13', '13'],
    ['us_tx', '14', '14'],
    ['us_tx', '15', '15'],
    ['us_tx', '16', '16'],
    ['us_tx', '17', '17'],
    ['us_tx', '18', '18'],
    ['us_tx', '19', '19'],
    ['us_tx', '2', '02'],
    ['us_tx', '20', '20'],
    ['us_tx', '21', '21'],
    ['us_tx', '22', '22'],
    ['us_tx', '23', '23'],
    ['us_tx', '24', '24'],
    ['us_tx', '25', '25'],
    ['us_tx', '26', '26'],
    ['us_tx', '27', '27'],
    ['us_tx', '28', '28'],
    ['us_tx', '29', '29'],
    ['us_tx', '3', '03'],
    ['us_tx', '30', '30'],
    ['us_tx', '31', '31'],
    ['us_tx', '32', '32'],
    ['us_tx', '4', '04'],
    ['us_tx', '5', '05'],
    ['us_tx', '6', '06'],
    ['us_tx', '7', '07'],
    ['us_tx', '8', '08'],
    ['us_tx', '9', '09'],
    ['us_ut', '1', '01'],
    ['us_ut', '2', '02'],
    ['us_ut', '3', '03'],
    ['us_va', '1', '01'],
    ['us_va', '10', '10'],
    ['us_va', '11', '11'],
    ['us_va', '2', '02'],
    ['us_va', '3', '03'],
    ['us_va', '4', '04'],
    ['us_va', '5', '05'],
    ['us_va', '6', '06'],
    ['us_va', '7', '07'],
    ['us_va', '8', '08'],
    ['us_va', '9', '09'],
    ['us_vt', 'one', '00'],
    ['us_wa', '1', '01'],
    ['us_wa', '2', '02'],
    ['us_wa', '3', '03'],
    ['us_wa', '4', '04'],
    ['us_wa', '5', '05'],
    ['us_wa', '6', '06'],
    ['us_wa', '7', '07'],
    ['us_wa', '8', '08'],
    ['us_wa', '9', '09'],
    ['us_wi', '1', '01'],
    ['us_wi', '2', '02'],
    ['us_wi', '3', '03'],
    ['us_wi', '4', '04'],
    ['us_wi', '5', '05'],
    ['us_wi', '6', '06'],
    ['us_wi', '7', '07'],
    ['us_wi', '8', '08'],
    ['us_wv', '1', '01'],
    ['us_wv', '2', '02'],
    ['us_wv', '3', '03'],
    ['us_wy', 'one', '00']
  ]

  #[:stateID, :state, :state_abrv]
  STATES = [
    ['us_ak', 'Alaska', 'AK'],
    ['us_al', 'Alabama', 'AL'],
    ['us_ar', 'Arkansas', 'AR'],
    ['us_az', 'Arizona', 'AZ'],
    ['us_ca', 'California', 'CA'],
    ['us_co', 'Colorado', 'CO'],
    ['us_ct', 'Connecticut', 'CT'],
    ['us_dc', 'D. Columbia', 'DC'],
    ['us_de', 'Delaware', 'DE'],
    ['us_fl', 'Florida', 'FL'],
    ['us_ga', 'Georgia', 'GA'],
    ['us_hi', 'Hawaii', 'HI'],
    ['us_ia', 'Iowa', 'IA'],
    ['us_id', 'Idaho', 'ID'],
    ['us_il', 'Illinois', 'IL'],
    ['us_in', 'Indiana', 'IN'],
    ['us_ks', 'Kansas', 'KS'],
    ['us_ky', 'Kentucky', 'KY'],
    ['us_la', 'Louisiana', 'LA'],
    ['us_ma', 'Massachusetts', 'MA'],
    ['us_md', 'Maryland', 'MD'],
    ['us_me', 'Maine', 'ME'],
    ['us_mi', 'Michigan', 'MI'],
    ['us_mn', 'Minnesota', 'MN'],
    ['us_mo', 'Missouri', 'MO'],
    ['us_ms', 'Mississippi', 'MS'],
    ['us_mt', 'Montana', 'MT'],
    ['us_nc', 'North Carolina', 'NC'],
    ['us_nd', 'North Dakota', 'ND'],
    ['us_ne', 'Nebraska', 'NE'],
    ['us_nh', 'New Hampshire', 'NH'],
    ['us_nj', 'New Jersey', 'NJ'],
    ['us_nm', 'New Mexico', 'NM'],
    ['us_nv', 'Nevada', 'NV'],
    ['us_ny', 'New York', 'NY'],
    ['us_oh', 'Ohio', 'OH'],
    ['us_ok', 'Oklahoma', 'OK'],
    ['us_or', 'Oregon', 'OR'],
    ['us_pa', 'Pennsylvania', 'PA'],
    ['us_pr', 'Puerto Rico', 'PR'],
    ['us_ri', 'Rhode Island', 'RI'],
    ['us_sc', 'South Carolina', 'SC'],
    ['us_sd', 'South Dakota', 'SD'],
    ['us_tn', 'Tennessee', 'TN'],
    ['us_tx', 'Texas', 'TX'],
    ['us_ut', 'Utah', 'UT'],
    ['us_va', 'Virginia', 'VA'],
    ['us_vt', 'Vermont', 'VT'],
    ['us_wa', 'Washington', 'WA'],
    ['us_wi', 'Wisconsin', 'WI'],
    ['us_wv', 'West Virginia', 'WV'],
    ['us_wy', 'Wyoming', 'WY']
  ]
end
