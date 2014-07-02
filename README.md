Cloning Twitter with Rails 4
==

I posted this _Rails 4 Development Map_ for myself to review in the future. Also, this repo helped me earn my **first + second** SoftEng jobs!!!

1. **The Must-Know Core:**
	
	a. RAILS command-line: `rails generate xxx`, `rails server`, `rails console`
   	* RAKE tasks: `db:migrate` (VERSION=0), `db:rollback`, `test:prepare`, `db:reset`, `assets:precompile`
   	* Git & Heroku

	b. Flexible DB-schema with "migrations"

	c. MODEL as a soft DB-manipulater with: "validations", "associations", "callbacks", `has_secure_password`, and business logics
	
	d. RAILS app-dev as RESOURCE manipulation via Controller-and-View(s):
	* CONTROLLER: RESTful & custom methods linked with VIEW(s), execute application logics, have "strong parameters" and "filters"
	* VIEW(s): "layouts", "templates", and "partials" with Bootstrap-HTML
	* HELPER(s): extracting codes to achieve DRY
	
	e. Different ROUTING(s):
	* RESTful routes
	* custom routes
	* named routes

2. **Additions for a Good Junior:**

	a. TDD with RSpec:
	* 3 test levels: models, helpers, & requests
	* `spec/*_helper.rb` configs
    * `spec/support` functions
	* factory_girl
	* capybara
	
	b. RAKE task: `db:populate`
    
3. **Advanced(s) for a Senior/Full-stack:**
	* Gems Hunting
	* CSS styling
	* JS-related stuffs
	* More configs: `config/environments`, `configs/initializers` & `config/application.rb`.