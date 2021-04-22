view: nps {

  dimension: visitor_id {
    type: string
  }

  dimension: survey_id {
    type: string
  }

  dimension: nps_score {
    type: number
  }

  dimension: is_promoter {
    type: yesno
    sql: ${nps_score} >= 9 ;;
  }

  dimension: is_detractor {
    type: yesno
    sql: ${nps_score} <= 6 ;;
  }

  measure: count_promoter {
    type: count_distinct
    sql: ${survey_id} ;;
    filters: [is_promoter: "Yes"]
  }

  measure: count_detractor {
    type: count_distinct
    sql: ${survey_id} ;;
    filters: [is_detractor: "Yes"]
  }

  measure: count_total_survey {
    type: count_distinct
    sql: ${survey_id} ;;
  }

  measure: nps_ratio {
    type: number
    sql: (${count_promoter} - ${count_detractor}) / ${count_total_survey} ;;
    value_format_name: percent_1
  }

}
