#Couldn't do it by myself. Used https://github.com/emilyjennings/oo-student-scraper-flatiron/tree/master/lib
require 'open-uri'
require 'pry'

#students_card: div class="student-card"
#name: h4 class="student-name"
#location: p class="student=location"
#profile_url: a href="students/ryan-johnson.html"

class Scraper

  #is a class method that scrapes the student index page ('./fixtures/student-site/index.html') 
  #and a returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)
    
    html = open(index_url)
    page = Nokogiri::HTML(html)

    students = []

     page.css("div.student-card").each do |student|

      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  #is a class method that scrapes a student's profile page 
  #and returns a hash of attributes describing an individual student
  #can handle profile pages without all of the social links
  def self.scrape_profile_page(profile_url)
    url = Nokogiri::HTML(open(profile_url))
    
    profiles = {}

    social_links = url.css("div.social-icon-container").css("a").collect {|social| social.attributes["href"].value}

    social_links.detect do |social|
      profiles[:twitter] = social if social.include?("twitter")
      profiles[:linkedin] = social if social.include?("linkedin")
      profiles[:github] = social if social.include?("github")
    end

    profiles[:blog] = social_links[3] if social_links[3] != nil
    profiles[:profile_quote] = url.css("div.profile-quote")[0].text
    profiles[:bio] = url.css("div.description-holder").css("p")[0].text
    profiles
    profiles
  end

end
