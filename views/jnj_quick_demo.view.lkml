view: kpis_by_date {
  derived_table: {
    datagroup_trigger: once_daily
    sql:

SELECT '2021-01-01' AS date,1 AS customer_id,10 AS orders,50 AS line_items
UNION ALL
SELECT '2021-01-02',1,15,75
UNION ALL
SELECT '2021-01-03',1,20,100
UNION ALL
    ;;
  }

  dimension: date {
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: orders {
    type: number
    sql: ${TABLE}.orders ;;
  }

  dimension: line_items {
    type: number
    sql: ${TABLE}.line_items ;;
  }

  measure: sum_orders {
    type: sum
    sql: ${orders} * 1.25 ;;
  }

  measure: sum_line_items {
    type: sum
    sql: ${line_items} ;;
  }

  parameter: choose_your_kpi {
    type: unquoted
    default_value: "orders"
    allowed_value: { label: "orders" value: "orders" }
    allowed_value: { label: "lineitems" value: "lineitems" }
  }

  measure: dynamic_kpi {
    type: number
    sql: {% if choose_your_kpi._parameter_value == 'orders' %} ${sum_orders} {% else %} ${sum_line_items} {% endif %} ;;
  }

}

view: customer_lifetime_orders_manual {
  derived_table: {
    datagroup_trigger: once_daily
    sql:
      SELECT customer_id, sum(orders) as lifetime_value
      FROM ${kpis_by_date.SQL_TABLE_NAME}
      GROUP BY 1
    ;;
  }

  dimension: customer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: lifetime_value {
    type: number
    sql: ${TABLE}.lifetime_value ;;
  }

  dimension: lifetime_value_tiers {
    type: tier
    tiers: [300, 500]
    sql: ${lifetime_value} ;;
  }
}

view: customer_lifetime_orders_native_derived_table {
  derived_table: {
    datagroup_trigger: once_daily
    explore_source: kpis_by_date {
      column: customer_id {}
      column: sum_orders {}
    }
  }
  dimension: customer_id {}
  dimension: sum_orders {
    type: number
  }
  dimension: lifetime_value {
    type: number
    sql: ${TABLE}.sum_orders ;;
  }

  dimension: lifetime_value_tiers {
    type: tier
    tiers: [300, 500]
    sql: ${lifetime_value} ;;
  }
}


# If necessary, uncomment the line below to include explore_source.
# include: "demo_aw.model.lkml"

view: add_a_unique_name_1612392651 {
  derived_table: {
    explore_source: kpis_by_date {
      column: customer_id {}
      column: sum_orders {}
      column: sum_line_items {}
      filters: {
        field: kpis_by_date.date
        value: "2021"
      }
    }
  }
  dimension: customer_id {}
  dimension: sum_orders {
    type: number
  }
  dimension: sum_line_items {
    type: number
  }
}

# view: columns_100 {
#   derived_table: {
#     sql:
#     1 as col1
#     ,
#     ;;
#   }
# }

view: columns_50 {
  derived_table: {
    datagroup_trigger: once_daily
    sql:
    SELECT 1 as col1

    ;;
  }

  dimension: col1 {}
}
