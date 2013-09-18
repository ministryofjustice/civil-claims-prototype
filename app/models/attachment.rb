class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  before_create :randomise_file_name
  
  def randomise_file_name
    self.file_name = get_random_file_name
  end

  private 
    def get_random_file_name
      ["Crystal palace park road.pdf",
      "Tenancy Agreement July 2010.doc",
      "Notice to quit - June 2013.doc"].rand
    end

end
