I18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
I18n.available_locales = [:en, :ru]
I18n.default_locale = :ru