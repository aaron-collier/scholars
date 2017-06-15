# Generated via
#  `rails generate hyrax:work Person`

module Hyrax
  class PeopleController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Person

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::PersonPresenter
  end
end
