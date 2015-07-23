CONFIG = YAML.load(File.read(File.join(::Rails.root.to_s, 'config', 'constants.yml')))[Rails.env]
