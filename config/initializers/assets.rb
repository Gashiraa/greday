# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( services.js )
Rails.application.config.assets.precompile += %w( wares.js )
Rails.application.config.assets.precompile += %w( invoices.js )
Rails.application.config.assets.precompile += %w( quotations.js )
Rails.application.config.assets.precompile += %w( extras.js )
Rails.application.config.assets.precompile += %w( project_extra_lines.js )
Rails.application.config.assets.precompile += %w( projects.js )
Rails.application.config.assets.precompile += %w( payments.js )
Rails.application.config.assets.precompile += %w( customers.js )
Rails.application.config.assets.precompile += ['pdf.scss']


# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
