# Barnabas Bulpett
# WEB-289-YD1
# Spring 2015
# config/initializers/assets.rb

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
Rails.application.config.assets.precompile += %w( winter_sunrise.css )
Rails.application.config.assets.precompile += %w( tranquil_mountain.css )
Rails.application.config.assets.precompile += %w( tropical_shores.css )
Rails.application.config.assets.precompile += %w( basic_styles.css )
Rails.application.config.assets.precompile += %w(404.html 422.html 500.html)
Rails.application.config.assets.paths << Rails.root.join('public')
Rails.application.config.assets.register_mime_type('text/html', '.html')

# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
