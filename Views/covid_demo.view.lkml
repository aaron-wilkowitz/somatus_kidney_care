view: covid_demo {
  derived_table: {
    sql:
                SELECT 'United Kingdom' as country, 'Scotland' as region, 103921 as posts
      UNION ALL SELECT 'United Kingdom' as country, 'Northern Ireland' as region, 82390 as posts
      UNION ALL SELECT 'United Kingdom' as country, 'England' as region, 81390 as posts
      UNION ALL SELECT 'United Kingdom' as country, 'Wales' as region, 39208 as posts
    ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
  }

  dimension: region {
    type: string
    map_layer_name: countries
  }

  measure: count_posts {
    type: sum
    sql: ${TABLE}.posts ;;
  }
}
