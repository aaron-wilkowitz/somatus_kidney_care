view: zipcode_census {
  sql_table_name: `bigquery-public-data.census_bureau_acs.zip_codes_2018_5yr`
    ;;

#################
### Derived Dimensions
#################

  measure: total_population {
    type: sum
    sql: ${total_pop} ;;
  }

  measure: total_population_in_poverty {
    group_label: "Poverty"
    type: sum
    sql: ${income_less_10000} + ${income_10000_14999} + ${income_15000_19999} + ${income_20000_24999} ;;
  }

  measure: total_population_on_food_stamps_or_public_housing {
    group_label: "Food Stamps / Public Housing"
    type: sum
    sql: ${households_public_asst_or_food_stamps} ;;
  }

  measure: total_population_over_70 {
    group_label: "Elderly Population"
    type: sum
    sql:
        ${female_70_to_74} + ${female_75_to_79} + ${female_80_to_84} + ${female_85_and_over}
      + ${male_70_to_74} + ${male_75_to_79} + ${male_80_to_84} + ${male_85_and_over}
      ;;
  }

  measure: percent_in_poverty {
    group_label: "Poverty"
    type: number
    sql: ${total_population_in_poverty} / nullif(${total_population},0) ;;
    value_format_name: percent_1
  }

  measure: percent_on_food_stamps_or_public_housing {
    group_label: "Food Stamps / Public Housing"
    type: number
    sql: ${total_population_on_food_stamps_or_public_housing} / nullif(${total_population},0) ;;
    value_format_name: percent_1
  }

  measure: percent_over_70 {
    group_label: "Elderly Population"
    type: number
    sql: ${total_population_over_70} / nullif(${total_population},0) ;;
    value_format_name: percent_1
  }

### Risk Factors
  parameter: weight_poverty {
    type:  number
    default_value: "4"
  }

  parameter: weight_food_stamps {
    type:  number
    default_value: "1"
  }

  parameter: weight_elderly {
    type:  number
    default_value: "2"
  }

  measure: risk_score {
    type: number
    value_format_name: percent_1
    sql:
          (
            ${percent_in_poverty} * {% parameter weight_poverty %}
        +   ${percent_on_food_stamps_or_public_housing} * {% parameter weight_food_stamps %}
        +   ${percent_over_70} *  {% parameter weight_elderly %}
      ) /
      nullif(({% parameter weight_poverty %} + {% parameter weight_food_stamps %} + {% parameter weight_elderly %}),0)
    ;;
  }

#################
### Original Dimensions
#################

  dimension: pk {
    primary_key: yes
    group_label: "Z"
    type: string
    sql: ${geo_id} ;;
  }

  dimension: aggregate_travel_time_to_work {
    group_label: "Z"
    type: number
    sql: ${TABLE}.aggregate_travel_time_to_work ;;
  }

  dimension: amerindian_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.amerindian_pop ;;
  }

  dimension: armed_forces {
    group_label: "Z"
    type: number
    sql: ${TABLE}.armed_forces ;;
  }

  dimension: asian_male_45_54 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.asian_male_45_54 ;;
  }

  dimension: asian_male_55_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.asian_male_55_64 ;;
  }

  dimension: asian_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.asian_pop ;;
  }

  dimension: associates_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.associates_degree ;;
  }

  dimension: bachelors_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.bachelors_degree ;;
  }

  dimension: bachelors_degree_2 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.bachelors_degree_2 ;;
  }

  dimension: bachelors_degree_or_higher_25_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.bachelors_degree_or_higher_25_64 ;;
  }

  dimension: black_male_45_54 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.black_male_45_54 ;;
  }

  dimension: black_male_55_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.black_male_55_64 ;;
  }

  dimension: black_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.black_pop ;;
  }

  dimension: children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.children ;;
  }

  dimension: children_in_single_female_hh {
    group_label: "Z"
    type: number
    sql: ${TABLE}.children_in_single_female_hh ;;
  }

  dimension: civilian_labor_force {
    group_label: "Z"
    type: number
    sql: ${TABLE}.civilian_labor_force ;;
  }

  dimension: commute_10_14_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_10_14_mins ;;
  }

  dimension: commute_15_19_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_15_19_mins ;;
  }

  dimension: commute_20_24_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_20_24_mins ;;
  }

  dimension: commute_25_29_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_25_29_mins ;;
  }

  dimension: commute_30_34_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_30_34_mins ;;
  }

  dimension: commute_35_44_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_35_44_mins ;;
  }

  dimension: commute_45_59_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_45_59_mins ;;
  }

  dimension: commute_60_more_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_60_more_mins ;;
  }

  dimension: commute_less_10_mins {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commute_less_10_mins ;;
  }

  dimension: commuters_16_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commuters_16_over ;;
  }

  dimension: commuters_by_bus {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commuters_by_bus ;;
  }

  dimension: commuters_by_car_truck_van {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commuters_by_car_truck_van ;;
  }

  dimension: commuters_by_carpool {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commuters_by_carpool ;;
  }

  dimension: commuters_by_public_transportation {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commuters_by_public_transportation ;;
  }

  dimension: commuters_by_subway_or_elevated {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commuters_by_subway_or_elevated ;;
  }

  dimension: commuters_drove_alone {
    group_label: "Z"
    type: number
    sql: ${TABLE}.commuters_drove_alone ;;
  }

  dimension: different_house_year_ago_different_city {
    group_label: "Z"
    type: number
    sql: ${TABLE}.different_house_year_ago_different_city ;;
  }

  dimension: different_house_year_ago_same_city {
    group_label: "Z"
    type: number
    sql: ${TABLE}.different_house_year_ago_same_city ;;
  }

  dimension_group: do {
    group_label: "Z"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.do_date ;;
  }

  dimension: dwellings_10_to_19_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_10_to_19_units ;;
  }

  dimension: dwellings_1_units_attached {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_1_units_attached ;;
  }

  dimension: dwellings_1_units_detached {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_1_units_detached ;;
  }

  dimension: dwellings_20_to_49_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_20_to_49_units ;;
  }

  dimension: dwellings_2_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_2_units ;;
  }

  dimension: dwellings_3_to_4_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_3_to_4_units ;;
  }

  dimension: dwellings_50_or_more_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_50_or_more_units ;;
  }

  dimension: dwellings_5_to_9_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.dwellings_5_to_9_units ;;
  }

  dimension: employed_agriculture_forestry_fishing_hunting_mining {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_agriculture_forestry_fishing_hunting_mining ;;
  }

  dimension: employed_arts_entertainment_recreation_accommodation_food {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_arts_entertainment_recreation_accommodation_food ;;
  }

  dimension: employed_construction {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_construction ;;
  }

  dimension: employed_education_health_social {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_education_health_social ;;
  }

  dimension: employed_finance_insurance_real_estate {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_finance_insurance_real_estate ;;
  }

  dimension: employed_information {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_information ;;
  }

  dimension: employed_manufacturing {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_manufacturing ;;
  }

  dimension: employed_other_services_not_public_admin {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_other_services_not_public_admin ;;
  }

  dimension: employed_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_pop ;;
  }

  dimension: employed_public_administration {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_public_administration ;;
  }

  dimension: employed_retail_trade {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_retail_trade ;;
  }

  dimension: employed_science_management_admin_waste {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_science_management_admin_waste ;;
  }

  dimension: employed_transportation_warehousing_utilities {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_transportation_warehousing_utilities ;;
  }

  dimension: employed_wholesale_trade {
    group_label: "Z"
    type: number
    sql: ${TABLE}.employed_wholesale_trade ;;
  }

  dimension: families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.families_with_young_children ;;
  }

  dimension: family_households {
    group_label: "Z"
    type: number
    sql: ${TABLE}.family_households ;;
  }

  dimension: father_in_labor_force_one_parent_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.father_in_labor_force_one_parent_families_with_young_children ;;
  }

  dimension: father_one_parent_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.father_one_parent_families_with_young_children ;;
  }

  dimension: female_10_to_14 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_10_to_14 ;;
  }

  dimension: female_15_to_17 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_15_to_17 ;;
  }

  dimension: female_18_to_19 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_18_to_19 ;;
  }

  dimension: female_20 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_20 ;;
  }

  dimension: female_21 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_21 ;;
  }

  dimension: female_22_to_24 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_22_to_24 ;;
  }

  dimension: female_25_to_29 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_25_to_29 ;;
  }

  dimension: female_30_to_34 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_30_to_34 ;;
  }

  dimension: female_35_to_39 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_35_to_39 ;;
  }

  dimension: female_40_to_44 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_40_to_44 ;;
  }

  dimension: female_45_to_49 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_45_to_49 ;;
  }

  dimension: female_50_to_54 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_50_to_54 ;;
  }

  dimension: female_55_to_59 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_55_to_59 ;;
  }

  dimension: female_5_to_9 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_5_to_9 ;;
  }

  dimension: female_60_to_61 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_60_to_61 ;;
  }

  dimension: female_62_to_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_62_to_64 ;;
  }

  dimension: female_65_to_66 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_65_to_66 ;;
  }

  dimension: female_67_to_69 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_67_to_69 ;;
  }

  dimension: female_70_to_74 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_70_to_74 ;;
  }

  dimension: female_75_to_79 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_75_to_79 ;;
  }

  dimension: female_80_to_84 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_80_to_84 ;;
  }

  dimension: female_85_and_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_85_and_over ;;
  }

  dimension: female_female_households {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_female_households ;;
  }

  dimension: female_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_pop ;;
  }

  dimension: female_under_5 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.female_under_5 ;;
  }

  dimension: four_more_cars {
    group_label: "Z"
    type: number
    sql: ${TABLE}.four_more_cars ;;
  }

  dimension: geo_id {
    group_label: "Z"
    type: zipcode
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.geo_id ;;
  }

  dimension: gini_index {
    group_label: "Z"
    type: number
    sql: ${TABLE}.gini_index ;;
  }

  dimension: graduate_professional_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.graduate_professional_degree ;;
  }

  dimension: group_quarters {
    group_label: "Z"
    type: number
    sql: ${TABLE}.group_quarters ;;
  }

  dimension: high_school_diploma {
    group_label: "Z"
    type: number
    sql: ${TABLE}.high_school_diploma ;;
  }

  dimension: high_school_including_ged {
    group_label: "Z"
    type: number
    sql: ${TABLE}.high_school_including_ged ;;
  }

  dimension: hispanic_any_race {
    group_label: "Z"
    type: number
    sql: ${TABLE}.hispanic_any_race ;;
  }

  dimension: hispanic_male_45_54 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.hispanic_male_45_54 ;;
  }

  dimension: hispanic_male_55_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.hispanic_male_55_64 ;;
  }

  dimension: hispanic_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.hispanic_pop ;;
  }

  dimension: households {
    group_label: "Z"
    type: number
    sql: ${TABLE}.households ;;
  }

  dimension: households_public_asst_or_food_stamps {
    group_label: "Z"
    type: number
    sql: ${TABLE}.households_public_asst_or_food_stamps ;;
  }

  dimension: housing_built_1939_or_earlier {
    group_label: "Z"
    type: number
    sql: ${TABLE}.housing_built_1939_or_earlier ;;
  }

  dimension: housing_built_2000_to_2004 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.housing_built_2000_to_2004 ;;
  }

  dimension: housing_built_2005_or_later {
    group_label: "Z"
    type: number
    sql: ${TABLE}.housing_built_2005_or_later ;;
  }

  dimension: housing_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.housing_units ;;
  }

  dimension: housing_units_renter_occupied {
    group_label: "Z"
    type: number
    sql: ${TABLE}.housing_units_renter_occupied ;;
  }

  dimension: in_grades_1_to_4 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.in_grades_1_to_4 ;;
  }

  dimension: in_grades_5_to_8 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.in_grades_5_to_8 ;;
  }

  dimension: in_grades_9_to_12 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.in_grades_9_to_12 ;;
  }

  dimension: in_school {
    group_label: "Z"
    type: number
    sql: ${TABLE}.in_school ;;
  }

  dimension: in_undergrad_college {
    group_label: "Z"
    type: number
    sql: ${TABLE}.in_undergrad_college ;;
  }

  dimension: income_100000_124999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_100000_124999 ;;
  }

  dimension: income_10000_14999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_10000_14999 ;;
  }

  dimension: income_125000_149999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_125000_149999 ;;
  }

  dimension: income_150000_199999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_150000_199999 ;;
  }

  dimension: income_15000_19999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_15000_19999 ;;
  }

  dimension: income_200000_or_more {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_200000_or_more ;;
  }

  dimension: income_20000_24999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_20000_24999 ;;
  }

  dimension: income_25000_29999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_25000_29999 ;;
  }

  dimension: income_30000_34999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_30000_34999 ;;
  }

  dimension: income_35000_39999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_35000_39999 ;;
  }

  dimension: income_40000_44999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_40000_44999 ;;
  }

  dimension: income_45000_49999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_45000_49999 ;;
  }

  dimension: income_50000_59999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_50000_59999 ;;
  }

  dimension: income_60000_74999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_60000_74999 ;;
  }

  dimension: income_75000_99999 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_75000_99999 ;;
  }

  dimension: income_less_10000 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_less_10000 ;;
  }

  dimension: income_per_capita {
    group_label: "Z"
    type: number
    sql: ${TABLE}.income_per_capita ;;
  }

  dimension: less_one_year_college {
    group_label: "Z"
    type: number
    sql: ${TABLE}.less_one_year_college ;;
  }

  dimension: less_than_high_school_graduate {
    group_label: "Z"
    type: number
    sql: ${TABLE}.less_than_high_school_graduate ;;
  }

  dimension: male_10_to_14 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_10_to_14 ;;
  }

  dimension: male_15_to_17 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_15_to_17 ;;
  }

  dimension: male_18_to_19 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_18_to_19 ;;
  }

  dimension: male_20 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_20 ;;
  }

  dimension: male_21 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_21 ;;
  }

  dimension: male_22_to_24 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_22_to_24 ;;
  }

  dimension: male_25_to_29 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_25_to_29 ;;
  }

  dimension: male_30_to_34 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_30_to_34 ;;
  }

  dimension: male_35_to_39 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_35_to_39 ;;
  }

  dimension: male_40_to_44 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_40_to_44 ;;
  }

  dimension: male_45_64_associates_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_64_associates_degree ;;
  }

  dimension: male_45_64_bachelors_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_64_bachelors_degree ;;
  }

  dimension: male_45_64_grade_9_12 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_64_grade_9_12 ;;
  }

  dimension: male_45_64_graduate_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_64_graduate_degree ;;
  }

  dimension: male_45_64_high_school {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_64_high_school ;;
  }

  dimension: male_45_64_less_than_9_grade {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_64_less_than_9_grade ;;
  }

  dimension: male_45_64_some_college {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_64_some_college ;;
  }

  dimension: male_45_to_49 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_to_49 ;;
  }

  dimension: male_45_to_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_45_to_64 ;;
  }

  dimension: male_50_to_54 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_50_to_54 ;;
  }

  dimension: male_55_to_59 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_55_to_59 ;;
  }

  dimension: male_5_to_9 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_5_to_9 ;;
  }

  dimension: male_65_to_66 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_65_to_66 ;;
  }

  dimension: male_67_to_69 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_67_to_69 ;;
  }

  dimension: male_70_to_74 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_70_to_74 ;;
  }

  dimension: male_75_to_79 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_75_to_79 ;;
  }

  dimension: male_80_to_84 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_80_to_84 ;;
  }

  dimension: male_85_and_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_85_and_over ;;
  }

  dimension: male_male_households {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_male_households ;;
  }

  dimension: male_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_pop ;;
  }

  dimension: male_under_5 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.male_under_5 ;;
  }

  dimension: management_business_sci_arts_employed {
    group_label: "Z"
    type: number
    sql: ${TABLE}.management_business_sci_arts_employed ;;
  }

  dimension: married_households {
    group_label: "Z"
    type: number
    sql: ${TABLE}.married_households ;;
  }

  dimension: masters_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.masters_degree ;;
  }

  dimension: median_age {
    group_label: "Z"
    type: number
    sql: ${TABLE}.median_age ;;
  }

  dimension: median_income {
    group_label: "Z"
    type: number
    sql: ${TABLE}.median_income ;;
  }

  dimension: median_rent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.median_rent ;;
  }

  dimension: median_year_structure_built {
    group_label: "Z"
    type: number
    sql: ${TABLE}.median_year_structure_built ;;
  }

  dimension: million_dollar_housing_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.million_dollar_housing_units ;;
  }

  dimension: mobile_homes {
    group_label: "Z"
    type: number
    sql: ${TABLE}.mobile_homes ;;
  }

  dimension: mortgaged_housing_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.mortgaged_housing_units ;;
  }

  dimension: no_car {
    group_label: "Z"
    type: number
    sql: ${TABLE}.no_car ;;
  }

  dimension: no_cars {
    group_label: "Z"
    type: number
    sql: ${TABLE}.no_cars ;;
  }

  dimension: nonfamily_households {
    group_label: "Z"
    type: number
    sql: ${TABLE}.nonfamily_households ;;
  }

  dimension: not_hispanic_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.not_hispanic_pop ;;
  }

  dimension: not_in_labor_force {
    group_label: "Z"
    type: number
    sql: ${TABLE}.not_in_labor_force ;;
  }

  dimension: not_us_citizen_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.not_us_citizen_pop ;;
  }

  dimension: occupation_management_arts {
    group_label: "Z"
    type: number
    sql: ${TABLE}.occupation_management_arts ;;
  }

  dimension: occupation_natural_resources_construction_maintenance {
    group_label: "Z"
    type: number
    sql: ${TABLE}.occupation_natural_resources_construction_maintenance ;;
  }

  dimension: occupation_production_transportation_material {
    group_label: "Z"
    type: number
    sql: ${TABLE}.occupation_production_transportation_material ;;
  }

  dimension: occupation_sales_office {
    group_label: "Z"
    type: number
    sql: ${TABLE}.occupation_sales_office ;;
  }

  dimension: occupation_services {
    group_label: "Z"
    type: number
    sql: ${TABLE}.occupation_services ;;
  }

  dimension: occupied_housing_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.occupied_housing_units ;;
  }

  dimension: one_car {
    group_label: "Z"
    type: number
    sql: ${TABLE}.one_car ;;
  }

  dimension: one_parent_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.one_parent_families_with_young_children ;;
  }

  dimension: one_year_more_college {
    group_label: "Z"
    type: number
    sql: ${TABLE}.one_year_more_college ;;
  }

  dimension: other_race_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.other_race_pop ;;
  }

  dimension: owner_occupied_housing_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.owner_occupied_housing_units ;;
  }

  dimension: owner_occupied_housing_units_lower_value_quartile {
    group_label: "Z"
    type: number
    sql: ${TABLE}.owner_occupied_housing_units_lower_value_quartile ;;
  }

  dimension: owner_occupied_housing_units_median_value {
    group_label: "Z"
    type: number
    sql: ${TABLE}.owner_occupied_housing_units_median_value ;;
  }

  dimension: owner_occupied_housing_units_upper_value_quartile {
    group_label: "Z"
    type: number
    sql: ${TABLE}.owner_occupied_housing_units_upper_value_quartile ;;
  }

  dimension: percent_income_spent_on_rent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.percent_income_spent_on_rent ;;
  }

  dimension: pop_15_and_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_15_and_over ;;
  }

  dimension: pop_16_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_16_over ;;
  }

  dimension: pop_25_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_25_64 ;;
  }

  dimension: pop_25_years_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_25_years_over ;;
  }

  dimension: pop_5_years_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_5_years_over ;;
  }

  dimension: pop_determined_poverty_status {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_determined_poverty_status ;;
  }

  dimension: pop_divorced {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_divorced ;;
  }

  dimension: pop_in_labor_force {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_in_labor_force ;;
  }

  dimension: pop_never_married {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_never_married ;;
  }

  dimension: pop_now_married {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_now_married ;;
  }

  dimension: pop_separated {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_separated ;;
  }

  dimension: pop_widowed {
    group_label: "Z"
    type: number
    sql: ${TABLE}.pop_widowed ;;
  }

  dimension: population_1_year_and_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.population_1_year_and_over ;;
  }

  dimension: population_3_years_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.population_3_years_over ;;
  }

  dimension: poverty {
    group_label: "Z"
    type: number
    sql: ${TABLE}.poverty ;;
  }

  dimension: rent_10_to_15_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_10_to_15_percent ;;
  }

  dimension: rent_15_to_20_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_15_to_20_percent ;;
  }

  dimension: rent_20_to_25_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_20_to_25_percent ;;
  }

  dimension: rent_25_to_30_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_25_to_30_percent ;;
  }

  dimension: rent_30_to_35_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_30_to_35_percent ;;
  }

  dimension: rent_35_to_40_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_35_to_40_percent ;;
  }

  dimension: rent_40_to_50_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_40_to_50_percent ;;
  }

  dimension: rent_burden_not_computed {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_burden_not_computed ;;
  }

  dimension: rent_over_50_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_over_50_percent ;;
  }

  dimension: rent_under_10_percent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.rent_under_10_percent ;;
  }

  dimension: renter_occupied_housing_units_paying_cash_median_gross_rent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.renter_occupied_housing_units_paying_cash_median_gross_rent ;;
  }

  dimension: sales_office_employed {
    group_label: "Z"
    type: number
    sql: ${TABLE}.sales_office_employed ;;
  }

  dimension: some_college_and_associates_degree {
    group_label: "Z"
    type: number
    sql: ${TABLE}.some_college_and_associates_degree ;;
  }

  dimension: speak_only_english_at_home {
    group_label: "Z"
    type: number
    sql: ${TABLE}.speak_only_english_at_home ;;
  }

  dimension: speak_spanish_at_home {
    group_label: "Z"
    type: number
    sql: ${TABLE}.speak_spanish_at_home ;;
  }

  dimension: speak_spanish_at_home_low_english {
    group_label: "Z"
    type: number
    sql: ${TABLE}.speak_spanish_at_home_low_english ;;
  }

  dimension: three_cars {
    group_label: "Z"
    type: number
    sql: ${TABLE}.three_cars ;;
  }

  dimension: total_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.total_pop ;;
  }

  dimension: two_cars {
    group_label: "Z"
    type: number
    sql: ${TABLE}.two_cars ;;
  }

  dimension: two_or_more_races_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.two_or_more_races_pop ;;
  }

  dimension: two_parent_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.two_parent_families_with_young_children ;;
  }

  dimension: two_parents_father_in_labor_force_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.two_parents_father_in_labor_force_families_with_young_children ;;
  }

  dimension: two_parents_in_labor_force_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.two_parents_in_labor_force_families_with_young_children ;;
  }

  dimension: two_parents_mother_in_labor_force_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.two_parents_mother_in_labor_force_families_with_young_children ;;
  }

  dimension: two_parents_not_in_labor_force_families_with_young_children {
    group_label: "Z"
    type: number
    sql: ${TABLE}.two_parents_not_in_labor_force_families_with_young_children ;;
  }

  dimension: unemployed_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.unemployed_pop ;;
  }

  dimension: vacant_housing_units {
    group_label: "Z"
    type: number
    sql: ${TABLE}.vacant_housing_units ;;
  }

  dimension: vacant_housing_units_for_rent {
    group_label: "Z"
    type: number
    sql: ${TABLE}.vacant_housing_units_for_rent ;;
  }

  dimension: vacant_housing_units_for_sale {
    group_label: "Z"
    type: number
    sql: ${TABLE}.vacant_housing_units_for_sale ;;
  }

  dimension: walked_to_work {
    group_label: "Z"
    type: number
    sql: ${TABLE}.walked_to_work ;;
  }

  dimension: white_male_45_54 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.white_male_45_54 ;;
  }

  dimension: white_male_55_64 {
    group_label: "Z"
    type: number
    sql: ${TABLE}.white_male_55_64 ;;
  }

  dimension: white_pop {
    group_label: "Z"
    type: number
    sql: ${TABLE}.white_pop ;;
  }

  dimension: worked_at_home {
    group_label: "Z"
    type: number
    sql: ${TABLE}.worked_at_home ;;
  }

  dimension: workers_16_and_over {
    group_label: "Z"
    type: number
    sql: ${TABLE}.workers_16_and_over ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
