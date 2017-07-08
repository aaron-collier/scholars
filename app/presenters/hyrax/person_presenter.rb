# Generated via
#  `rails generate hyrax:work Person`
module Hyrax
  class PersonPresenter < Hyrax::WorkShowPresenter
    delegate :affiliation, :university, :office, :phone, :email, :about, :major_tags, :minor_tags,
             :history_tags, :geo_tags, :other_tags, :website, :group,
             :position, :classification, :citation, :discipline, to: :solr_document
  end
end
