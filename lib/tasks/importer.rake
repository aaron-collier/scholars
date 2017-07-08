require 'json'
require 'open-uri'
require 'uri'

# fields from fresca
# - name => creator
# - University => affiliotion
# - office
# - phone
# - email
# - about
# - major_tags
# - minor_tags
# - geo_tags
# - hist_tags => history_tags
# - other_tags
# - websites

@university_vocabulary = {
  "California Maritime Academy" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/maritime",
  "California Polytechnic State University" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/calpoly",
  "California State Polytechnic University, Pomona" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/pomona",
  "California State University, Bakersfield" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/bakersfield",
  "California State University, Channel Islands" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/channelislands",
  "California State University, Chico" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/chico",
  "California State University, Dominguez Hills" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/dominguezhills",
  "California State University, East Bay" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/eastbay",
  "California State University, Fresno" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/fresnostate",
  "California State University, Fullerton" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/fullerton",
  "California State University, Long Beach" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/longbeach",
  "California State University, Los Angeles" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/losangeles",
  "California State University, Monterey Bay" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/monterey",
  "California State University, Northridge" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/northridge",
  "California State University, Sacramento" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/sacramento",
  "California State University, San Bernardino" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/sanbernardino",
  "California State University, San Marcos" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/sanmarcos",
  "California State University, Stanislaus" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/stanislaus",
  "Humboldt State University" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/humboldt",
  "Moss Landing Marine Laboratories" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/mosslanding",
  "San Diego State University" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/sandiego",
  "San Francisco State University" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/sanfrancisco",
  "San José State University" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/sanjose",
  "Sonoma State University" => "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/sonoma"
}
# embargo fields
# :visibility_during_embargo, :embargo_release_date, :visibility_after_embargo,
# :visibility_during_embargo: authenticated
# :visibility: embargo

# This is a variable to use during XML parse testing to avoid submitting new items
@debugging = FALSE

namespace :importer do

  task :people, [:file] =>  [:environment] do |t, args|
    puts "loading task import"

    @source_file = args[:file] or raise "No source input file provided."

    @defaultDepositor = User.find_by_user_key("acollier@calstate.edu") # THIS MAY BE UNNECESSARY

    abort("Exiting packager: input file [" + @source_file + "] not found.") unless File.exists?(@source_file)

    @sourceHash = JSON.parse(File.read(@source_file))
    @sourceHash.each do |person|

      params = Hash.new {|h,k| h[k] = [] }
#      person["name"] = person["name"].gsub(/[^A-Za-z]/i,'')
#      person["name"] = person["name"].gsub(/\ADr/,'')
      person_prefix = person["name"].gsub(/[^A-Za-z]/i,'').gsub(/\ADr/,'')
      # puts person
      creator = format_name(person["name"].split(/[\s,]+/))
      unless !creator
        # puts name_holder.to_s unless name_holder.size != 3
        # params["creator"] << "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csupeople/" + person["name"]
        # puts person["name"]
        params["creator"] << creator
        params["title"] << person["name"] unless person["name"].nil?

        params["university"] << person["university"]["name"] unless person["university"].nil? # @university_vocabulary[person["university"]] unless @university_vocabulary[person["university"]].nil?
        # params["affiliation"] << "http://csuvocab.tipj95gksd.us-east-1.elasticbeanstalk.com/ns/csuinstitutions/coast"
        # puts person["photo_url"]
        params["office"] = person["office"] unless person["office"] == 'null'
        puts person["phone"]
        params["phone"] = person["phone"] unless person["phone"].nil?
        params["email"] = person["email"] unless person["email"] == 'null'
        params["about"] = person["about"] unless person["about"] == 'null'
        params["position"] = person["position_title"] unless person["position_title"] == 'null'
        params["major_tags"] = person["major_tags"] unless person["major_tags"].nil?
        params["minor_tags"] = person["minor_tags"] unless person["minor_tags"].nil?
        params["geo_tags"] = person["geo_tags"] unless person["geo_tags"].nil?
        params["history_tags"] = person["hist_tags"] unless person["hist_tags"].nil?
        params["other_tags"] = person["other_tags"] unless person["other_tags"].nil?
        person["publications"].each do |pub|
          params["citation"] << pub["citation"] unless person["publications"].nil?
        end
        person["websites"].each do |website|
          params["website"] << website["href"]
        end
        params["visibility"] = "open"
        unless person["disciplines"].nil?
          person["disciplines"].each do |discipline|
            params["discipline"] << discipline["name"]
          end
        end
        unless person["groups"].nil?
          person["groups"].each do |group|
            params["group"] << group["name"]
          end
        end

        puts params

#      download = open(person["photo_url"])
#      IO.copy_stream(download,'/Users/acollier/Documents/Projects/Coast/thumbnails/'+person_prefix+".jpg")

        new_person = Person.new(id: ActiveFedora::Noid::Service.new.mint)
        new_person.update(params)
        new_person.apply_depositor_metadata("acollier@calstate.edu")
        new_person.save

        begin
        file = File.open('/Users/acollier/Documents/Projects/Coast/thumbnails/'+person_prefix+".jpg")
          personImage = Hyrax::UploadedFile.create(file: file)
          personImage.save
        file.close
        AttachFilesToWorkJob.perform_now(new_person,[personImage])
      rescue
        puts "No thumbnail image for #{creator}"
      end
    end
    end
  end

  task :publications, [:file] =>  [:environment] do |t, args|
    puts "loading task import"

    @source_file = args[:file] or raise "No source input file provided."

    abort("Exiting packager: input file [" + @source_file + "] not found.") unless File.exists?(@source_file)

    @sourceHash = JSON.parse(File.read(@source_file))
    @sourceHash.each do |person|
      creator = format_name(person["name"].split(/[\s,]+/))
      unless !creator
        person["publications"].each do |publication|
          params = Hash.new {|h,k| h[k] = [] }

          params["creator"] << creator
          publication["type"][0] = publication["type"][0].capitalize unless publication["type"].nil?
          params["resource_type"] << publication["type"] unless publication["type"].nil?
          params["year"] = publication["pubYear"] unless publication["pubYear"].nil?
          params["title"] << publication["title"] unless publication["title"].nil?
          params["journal"] = publication["journal"] unless publication["journal"].nil?
          params["volume"] = publication["volume"] unless publication["volume"].nil?
          params["number"] = publication["number"] unless publication["number"].nil?
          params["pages"] = publication["pages"] unless publication["pages"].nil?

          publication["authors"].each do |author|
            params["contributor"] << "#{author['lastName']}, #{author['firstName']}"
          end

          pub = Publication.new(id: ActiveFedora::Noid::Service.new.mint)
          pub.update(params)
          pub.apply_depositor_metadata("acollier@calstate.edu")
          pub.save
        end
      end
    end

  end

  task :get_images, [:file] =>  [:environment] do |t, args|
    puts "loading task get_images"
    @source_file = args[:file] or raise "No source input file provided."
    @sourceHash = JSON.parse(File.read(@source_file))
    @sourceHash.each do |person|
      person_prefix = person["name"].gsub(/[^A-Za-z]/i,'').gsub(/\ADr/,'')
      begin
        download = open(person["photo_url"])
        IO.copy_stream(download,'/data/csuscholars/thumbnails/'+person_prefix+".jpg")
      rescue
        puts "Error downloading Image [#{person_prefix}.jpg]."
      end
    end
  end
end

def format_name(name)
  return unless name.size > 1 # if there is only one name, or it's blank, return nil
  return "#{name[1]}, #{name[0]}" unless name.size > 2
  return "#{name[2]}, #{name[0]} #{name[1]}" unless name.size > 3
  return # if the name doesn't match the 2 above conditions, it will require special care.
end
