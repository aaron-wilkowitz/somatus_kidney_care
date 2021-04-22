connection: "lookerdata"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: nps {}

explore: medicare_inpatient {
  join: zipcode_census {
    relationship: many_to_one
    sql_on: right('000' || cast(${medicare_inpatient.provider_zipcode} as string),5) = ${zipcode_census.geo_id} ;;
  }
}

explore: zipcode_census {}

explore: kpis_by_date {
  join: customer_lifetime_orders_manual {
    relationship: many_to_one
    sql_on: ${kpis_by_date.customer_id} = ${customer_lifetime_orders_manual.customer_id} ;;
  }

  join: customer_lifetime_orders_native_derived_table {
    relationship: many_to_one
    sql_on: ${kpis_by_date.customer_id} = ${customer_lifetime_orders_native_derived_table.customer_id} ;;
  }
}

explore: customer_lifetime_orders_native_derived_table {}

# explore: columns_100 {}
explore: columns_50 {}

### PDT Timeframes

datagroup: once_daily {
  max_cache_age: "24 hours"
  sql_trigger: SELECT current_date() ;;
}

datagroup: once_weekly {
  max_cache_age: "168 hours"
  sql_trigger: SELECT extract(week from current_date()) ;;
}

datagroup: once_monthly {
  max_cache_age: "720 hours"
  sql_trigger: SELECT extract(month from current_date()) ;;
}

datagroup: once_yearly {
  max_cache_age: "9000 hours"
  sql_trigger: SELECT extract(year from current_date()) ;;
}
