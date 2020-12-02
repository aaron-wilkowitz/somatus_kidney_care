view: covid_demo {
  derived_table: {
    sql:
                SELECT 'United Kingdom' as country, 'Scotland' as region, 18000 as posts, 400 as cases
      UNION ALL SELECT 'United Kingdom' as country, 'Northern Ireland' as region, 30000 as posts, 300 as cases
      UNION ALL SELECT 'United Kingdom' as country, 'England' as region, 80000 as posts, 10921 as cases
      UNION ALL SELECT 'United Kingdom' as country, 'Wales' as region, 500 as posts, 850 as cases
    ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    drill_fields: [region]
    link: {
      label: "Country Drill Down"
      url: "/dashboards/covid::world?Region=&Country=United%20Kingdom"
      icon_url: "http://www.google.com/s2/favicons?domain=www.looker.com"
    }
  }

  dimension: region {
    type: string
    drill_fields: [postal_code, city, date]
  }

  dimension: postal_code {
    type: string
    sql: 'Example' ;;
  }

  dimension: city {
    type: string
    sql: 'Example' ;;
  }

  dimension: date {
    type: string
    sql: 'Example' ;;
  }

  measure: count_posts {
    type: sum
    sql: ${TABLE}.posts ;;
    drill_fields: [drill*]
  }

  measure: count_cases {
    type: sum
    sql: ${TABLE}.cases ;;
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      country,
      region,
      count_posts,
      count_cases
    ]
  }
}
