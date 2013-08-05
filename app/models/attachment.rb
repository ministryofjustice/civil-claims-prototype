class Attachment < ActiveRecord::Base
  belongs_to :claim

  def self.create_random
    self.create(generate)
  end

  def self.generate
    file_names = [
      "Crystal palace park road.pdf",
      "Tenancy Agreement July 2010.doc",
      "Notice to quit - June 2013.doc"]
    {
      :file_name  => file_names.rand
    }
  end

end
