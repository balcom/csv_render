# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "csv_render"
  s.summary = "Rails engine to render AR model as CSV"
  s.description = "CsvRender is a Ruby on Rails engine to render an ActiveRecord model as CSV"
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = "0.0.1"
end