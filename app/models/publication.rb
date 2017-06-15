# Generated via
#  `rails generate hyrax:work Publication`
class Publication < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  # This must come after the WorkBehavior because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata

  self.indexer = PublicationIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  self.human_readable_type = 'Publication'

  property :journal, predicate: ::RDF::Vocab::DC.title, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :number, predicate: ::RDF::Vocab::MODS.partDetailType, multiple: false
  property :volume, predicate: ::RDF::Vocab::MODS.partDetailType, multiple: false
  property :year, predicate: ::RDF::Vocab::MODS.partDetailType, multiple: false
  property :pages, predicate: ::RDF::Vocab::MODS.partDetailType, multiple: false

end
