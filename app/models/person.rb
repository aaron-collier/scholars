# Generated via
#  `rails generate hyrax:work Person`
class Person < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  # This must come after the WorkBehavior because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata

  self.indexer = PersonIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  self.human_readable_type = 'Person'

  property :university, predicate: ::RDF::Vocab::MARCRelators.dgg do |index|
    index.as :stored_searchable, :facetable
  end

  property :affiliation, predicate: ::RDF::Vocab::MADS.Affiliation do |index|
    index.as :stored_searchable, :facetable
  end

  property :office, predicate: ::RDF::Vocab::MADS.Address, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :email, predicate: ::RDF::Vocab::MADS.email, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :phone, predicate: ::RDF::Vocab::MADS.phone, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :about, predicate: ::RDF::Vocab::DC.description, multiple: false do |index|
    index.as :stored_searchable
  end

  property :major_tags, predicate: ::RDF::Vocab::MADS.fieldOfActivity do |index|
    index.as :stored_searchable, :facetable
  end

  property :minor_tags, predicate: ::RDF::Vocab::DC.subject do |index|
    index.as :stored_searchable, :facetable
  end

  property :history_tags, predicate: ::RDF::Vocab::DC.coverage do |index|
    index.as :stored_searchable, :facetable
  end

  property :geo_tags, predicate: ::RDF::Vocab::MADS.associatedLocale do |index|
    index.as :stored_searchable, :facetable
  end

  property :other_tags, predicate: ::RDF::Vocab::DC.subject do |index|
    index.as :stored_searchable, :facetable
  end

  property :classification, predicate: ::RDF::Vocab::MADS.Occupation, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :position, predicate: ::RDF::Vocab::MADS.Title, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :website, predicate: ::RDF::Vocab::MADS.see do |index|
    index.as :stored_searchable, :facetable
  end

  property :citation, predicate: ::RDF::Vocab::MADS.citationNote do |index|
    index.as :stored_searchable, :facetable
  end

  property :discipline, predicate: ::RDF::Vocab::MADS.organization do |index|
    index.as :stored_searchable, :facetable
  end

  property :group, predicate: ::RDF::Vocab::FOAF.Group do |index|
    index.as :stored_searchable, :facetable
  end
end
