$:.unshift File.dirname(__FILE__)

# Load dependencies
require 'sinatra/base'
require 'sinatra/contrib'
require 'pg'
require 'slim'
require 'sequel'
require 'sequel-noinflectors'
require 'redcarpet'

# Load configs
CONFIG = YAML::load(File.open('config/peterhenrikson.yml'))
AUTH = YAML::load(File.open('config/auth.yml'))

# Connect to database
DB = Sequel.connect(CONFIG['db'])

# Load helpers.
require 'peterhenrikson/helpers/utils'
require 'peterhenrikson/helpers/assets'
require 'peterhenrikson/helpers/forms'
require 'peterhenrikson/helpers/email'

# Load models.
require 'peterhenrikson/models/email'
require 'peterhenrikson/models/page_seo'
require 'peterhenrikson/models/timeline'
require 'peterhenrikson/models/photo'
require 'peterhenrikson/models/project'
require 'peterhenrikson/models/product'

# Load sinatra.
require 'peterhenrikson/app'

# Load controllers.
require 'peterhenrikson/controllers/filters'
require 'peterhenrikson/controllers/index'
require 'peterhenrikson/controllers/contact'
require 'peterhenrikson/controllers/projects'
require 'peterhenrikson/controllers/products'
require 'peterhenrikson/controllers/plans'
require 'peterhenrikson/controllers/timeline'
