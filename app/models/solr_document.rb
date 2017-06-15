# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models.

  use_extension( Hydra::ContentNegotiation )

  def university
    self[Solrizer.solr_name('university')]
  end

  def affiliation
    self[Solrizer.solr_name('affiliation')]
    # fetch('org_ssim')
    # self[Solrizer.solr_name('affiliation')]
  end

#  def organization
#    fetch('organization_ssim')
#  end

#  def organization
#    # self[Solrizer.solr_name('org')]
#    fetch('org_ssim', [])
#  end

  def office
    self[Solrizer.solr_name('office')]
  end

  def email
    self[Solrizer.solr_name('email')]
  end

  def phone
    self[Solrizer.solr_name('phone')]
  end

  def about
    self[Solrizer.solr_name('about')]
  end

  def major_tags
    self[Solrizer.solr_name('major_tags')]
  end

  def minor_tags
    self[Solrizer.solr_name('minor_tags')]
  end

  def history_tags
    self[Solrizer.solr_name('history_tags')]
  end

  def geo_tags
    self[Solrizer.solr_name('geo_tags')]
  end

  def other_tags
    self[Solrizer.solr_name('other_tags')]
  end

  def classification
    self[Solrizer.solr_name('classification')]
  end

  def position
    self[Solrizer.solr_name('position')]
  end

  def website
    self[Solrizer.solr_name('website')]
  end

  def citation
    self[Solrizer.solr_name('citation')]
  end

  def discipline
    self[Solrizer.solr_name('discipline')]
  end

  def journal
    self[Solrizer.solr_name('journal')]
  end

  def volume
    self[Solrizer.solr_name('volume')]
  end

  def number
    self[Solrizer.solr_name('number')]
  end

  def year
    self[Solrizer.solr_name('year')]
  end

  def pages
    self[Solrizer.solr_name('pages')]
  end

  def group
    self[Solrizer.solr_name('group')]
  end

  def journal
    self[Solrizer.solr_name('journal')]
  end

  def number
    self[Solrizer.solr_name('number')]
  end

  def volume
    self[Solrizer.solr_name('volume')]
  end

  def year
    self[Solrizer.solr_name('year')]
  end

  def pages
    self[Solrizer.solr_name('pages')]
  end
end
