Gem::Specification.new do |s|
  s.name        = "formula"
  s.version     = "0.0.3"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kevin Sylvestre"]
  s.email       = ["kevin@ksylvest.com"]
  s.homepage    = "http://github.com/ksylvest/formula"
  s.summary     = "A great way to simplify complex forms"
  s.description = "Formula is a Rails form generator that generates simple clean markup. The project aims to let users create semantically beautiful forms without introducing too much syntax. The goal is to make integrating advanced layout systems (such as grid systems) as simple as possible."
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(README.rdoc LICENSE)
end

