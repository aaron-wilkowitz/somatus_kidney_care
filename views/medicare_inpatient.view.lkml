view: medicare_inpatient {
  derived_table: {
    datagroup_trigger: once_monthly
    sql:
                SELECT 2011 as year, * FROM `bigquery-public-data.medicare.inpatient_charges_2011`
      UNION ALL SELECT 2012 as year, * FROM `bigquery-public-data.medicare.inpatient_charges_2012`
      UNION ALL SELECT 2013 as year, * FROM `bigquery-public-data.medicare.inpatient_charges_2013`
      UNION ALL SELECT 2014 as year, * FROM `bigquery-public-data.medicare.inpatient_charges_2014`
    ;;
  }

##################
### Original Dimensions
##################

  dimension: pk {
    group_label: "Z"
    type: string
    sql: ${year} || '|' || ${provider_id} || '|' || ${drg_definition} ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: average_covered_charges {
    group_label: "Z"
    type: number
    sql: ${TABLE}.average_covered_charges ;;
  }

  dimension: average_medicare_payments {
    group_label: "Z"
    type: number
    sql: ${TABLE}.average_medicare_payments ;;
  }

  dimension: average_total_payments {
    group_label: "Z"
    type: number
    sql: ${TABLE}.average_total_payments ;;
  }

  dimension: drg_definition {
    type: string
    sql: ${TABLE}.drg_definition ;;
  }

  dimension: hospital_referral_region_description {
    group_label: "Z"
    type: string
    sql: ${TABLE}.hospital_referral_region_description ;;
  }

  dimension: provider_city {
    group_label: "Provider Information"
    type: string
    sql: ${TABLE}.provider_city ;;
  }

  dimension: provider_id {
    group_label: "Z"
    type: number
    sql: ${TABLE}.provider_id ;;
  }

  dimension: provider_name {
    group_label: "Provider Information"
    type: string
    sql: ${TABLE}.provider_name ;;
  }

  dimension: provider_state {
    group_label: "Provider Information"
    type: string
    sql: ${TABLE}.provider_state ;;
    map_layer_name: us_states
  }

  dimension: provider_street_address {
    group_label: "Provider Information"
    type: string
    sql: ${TABLE}.provider_street_address ;;
  }

  dimension: provider_zipcode {
    group_label: "Provider Information"
    type: zipcode
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.provider_zipcode ;;
  }

  dimension: total_discharges {
    group_label: "Z"
    type: number
    sql: ${TABLE}.total_discharges ;;
  }

##################
### Derived Dimensions
##################

  dimension: is_kidney_care {
    type: yesno
    sql:
          ${drg_definition} like '%KIDNEY%'
      OR  ${drg_definition} like '%RENAL%'
      OR  ${drg_definition} like '%DIALYSIS%'
    ;;
  }

##################
### Measures
##################

## # Claims

  measure: total_claims {
    group_label: "Count Claims"
    type: sum
    sql: ${total_discharges} ;;
  }

  measure: total_kidney_claims {
    group_label: "Count Claims"
    type: sum
    sql: ${total_discharges} ;;
    filters: [is_kidney_care: "Yes"]
  }

  measure: percent_kidney_claims {
    group_label: "Count Claims"
    type: number
    sql: ${total_kidney_claims} / nullif(${total_claims},0) ;;
    value_format_name: percent_1
  }

## Amount Money

  measure: total_cost_claims {
    group_label: "Cost Claims"
    type: sum
    sql: ${average_total_payments} ;;
    value_format_name: usd
  }

  measure: total_cost_kidney_claims {
    group_label: "Cost Claims"
    type: sum
    sql: ${average_total_payments} ;;
    filters: [is_kidney_care: "Yes"]
    value_format_name: usd
  }

  measure: percent_cost_kidney_claims {
    group_label: "Cost Claims"
    type: number
    sql: ${total_cost_kidney_claims} / nullif(${total_cost_claims},0) ;;
    value_format_name: percent_1
  }

## Cost per Patient

  measure: total_cost_per_patient {
    group_label: "Cost per Patient"
    type: number
    sql: ${total_cost_claims} / nullif(${total_claims},0) ;;
    value_format_name: usd
  }

  measure: total_cost_per_kidney_patient {
    group_label: "Cost per Patient"
    type: number
    sql: ${total_cost_kidney_claims} / nullif(${total_kidney_claims},0) ;;
    value_format_name: usd
  }

## % Reimbursed

  measure: total_reimbursed_kidney_claims {
    group_label: "% Reimbursed"
    type: sum
    sql: ${average_medicare_payments} ;;
    filters: [is_kidney_care: "Yes"]
    value_format_name: usd
  }

  measure: percent_reimbursed_kidney_claims {
    group_label: "% Reimbursed"
    type: number
    sql: ${total_reimbursed_kidney_claims} / nullif(${total_cost_kidney_claims},0) ;;
    value_format_name: percent_1
  }

## Counts

  measure: count {
    group_label: "Z"
    type: count
    drill_fields: [provider_name]
  }

  measure: count_pk {
    group_label: "Z"
    type: count_distinct
    sql: ${pk} ;;
  }
}
