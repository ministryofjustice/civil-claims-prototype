class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants
  has_many :attachments, :dependent => :destroy
  has_many :defenses, :dependent => :destroy
  has_and_belongs_to_many :arrears

  has_one :address, as: :addressable
  belongs_to :owner, :class_name => 'Claimant'

  accepts_nested_attributes_for :claimants
  accepts_nested_attributes_for :defendants
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  accepts_nested_attributes_for :arrears, :allow_destroy => true

  def total_rental_arrears
    (self.rental_amount || 0) * self.arrears.count - self.arrears.sum(:paid)
  end

  def grounds_for_possesion
    grounds = []
    grounds << "Non payment of rent" if self.non_payment_of_rent
    grounds << "Anti-social behaviour" if self.anti_social_behaviour
    grounds << "Property misuse" if self.property_misuse
    grounds << self.other_breach if self.other_breach_of_tenancy
    grounds
  end

  def address_for_possession
    self.address
  end

  def address_for_possession=( address )
    self.address = address
  end

  def get_people_of_type( type )
    self.send(type.pluralize)
  end

  def primary_claimant
    self.claimants.first
  end

  def additional_claimants
    self.claimants.drop(1)
  end

  def primary_defendant
    self.defendants.first
  end

  def additional_defendants
    self.defendants.drop(1)
  end

  def before_create( record )
    self.defendants.create
    self.build_address
  end

  def create_as_per_user_journey
    tenant = Defendant.find_by uj: true
    landlord = Claimant.find_by uj: true

    self.owner = landlord
    self.claimants << landlord
    self.defendants << tenant
    self.address = tenant.address

    self.property_type = 'residential'
    self.resident_type = 'private tenant'

    self.non_payment_of_rent = true 
    self.anti_social_behaviour = false 
    self.property_misuse = false 
    self.other_breach_of_tenancy = false 
    self.other_breach = "" 
    self.notice_to_quit = true 
    self.notice_served_date = Date.new(2013, 6, 11)
    self.lease_breach = false 
    self.seeking_possetion = false 
    self.other_recovery_steps_taken = false 
    self.other_recovery_steps = "" 
    self.claim_rental_arrears = true 
    self.lease_forfeiture = false 
    self.includes_human_rights_issues = false 
    self.tenancy_type = "assured-shorthold-tenancy" 
    self.tenancy_start_date = Date.new(2013, 9, 10)
    self.rental_amount = 950 
    self.unpaid_rent_per_day = 32
    self.defendent_to_pay_for_claim = true 
    self.other_information = "" 

    self.attachments << Attachment.create(file_name: "Tenancy Agreement July 2010.doc")
    self.attachments << Attachment.create(file_name: "Crystal palace park road.pdf")

    self.arrears << Arrear.create(amount: 950, due_date: Date.new(2013, 4, 10), paid: 0)
    self.arrears << Arrear.create(amount: 950, due_date: Date.new(2013, 5, 10), paid: 0)
    self.arrears << Arrear.create(amount: 950, due_date: Date.new(2013, 6, 10), paid: 0)

    self.signature = true

    
    self.save
    self
  end
end 