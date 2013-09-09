class Person < ActiveRecord::Base
  belongs_to :claim
  has_one :address, :as => :addressable, :dependent => :destroy

  accepts_nested_attributes_for :address, :allow_destroy => true

  scope :randomly, -> { order("RANDOM()") }

  def display_name
    self.full_name
  end

  def extended_contact_details
    %w(phone mobile email).reject{|x| self.send(x).blank? }.map {|x| self.send(x) }
  end

  def self.at_random
    randomly.first
  end

  def claims
    Claim.where(:owner => self)
  end
  
  def self.create_random
    self.create(generate)
  end

  def self.upcreate(params, type)
    p = nil
    if params[:id] && (p = self.find_by_id params[:id])
      if params[:address]
        p.address.update_attributes(params[:address])
        params.except! :address
      end
      p.update_attributes(params)
    else
      a = params[:address]
      params.except! :address
      p = self.create(params)
      p.create_address a
    end
    p
  end

  def self.generate
    {
      :full_name  => "#{Random.firstname} #{Random.lastname}",
      :phone      => Random.phone,
      :email      => Random.email,
    }
  end
end
