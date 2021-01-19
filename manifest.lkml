project_name: "zz_aw"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
# application: aw_test {
#   url: "http://localhost:8080/bundle.js"
#     # switch this to file once you have the required js to run
#     # see line 55 on webpack.config.js for why it's bundle.js
#     # all of the rules in 58-64 give rules for typescript
#   # file: "" -- once you're done developing, you would upload bundle.js file in Looker, and you'd use this instead of the URL
#   entitlements: {}
# }



application: aw_test {
  label: "Aw Test"
  url: "http://localhost:8080/bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    # allow_forms: yes
    # allow_same_origin: yes
    core_api_methods: ["all_connections","search_folders", "run_inline_query", "me", "all_looks", "run_look"]
    external_api_urls: ["http://127.0.0.1:3000", "http://localhost:3000", "https://*.googleapis.com", "https://*.github.com", "https://REPLACE_ME.auth0.com"]
    oauth2_urls: ["https://accounts.google.com/o/oauth2/v2/auth", "https://github.com/login/oauth/authorize", "https://dev-5eqts7im.auth0.com/authorize", "https://dev-5eqts7im.auth0.com/login/oauth/token", "https://github.com/login/oauth/access_token"]
  }
}
