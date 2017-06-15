# Generated via
#  `rails generate hyrax:work Person`
module Hyrax
  class PersonForm < Hyrax::Forms::WorkForm
    self.model_class = ::Person
    self.terms += [:resource_type]
  end
end
