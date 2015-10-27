class Provider < ActiveRecord::Base
  belongs_to :category
  belongs_to :property
  has_secure_password
  has_many :agings
  has_many :ages, :through => :agings
  has_many :sizings
  has_many :sizes, :through => :sizings
  mount_uploader :avatar, AvatarUploader
  has_many :provider_attachments
  accepts_nested_attributes_for :provider_attachments
  validates_presence_of :email, :name, :last_name_1, :last_name_2, :phone, :dni
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_uniqueness_of :dni
  has_many :localizations
  has_many :locations, through: :localizations
  validates :locations, :presence => true
  validates :dni, length: { is: 13, message: "debe tener 13 dígitos." }
  validates_format_of :dni,
    with: /[0-9]+\z/i,
    message: %Q[solo puede incluir números (0-9).]
  validates_format_of :phone,
    with: /\A[0-9\-]+\z/,
    message: %Q[solo puede incluir números (0-9) y guiones "-".]  
  validate :fields_a_and_b_are_equal, on: :create


  def prov_locations
    if self.locations.count > 5
      return "Varios municipios en México DF."
    else
      return self.locations.map(&:name).join(", ")
    end
  end

  protected

  def fields_a_and_b_are_equal
    if self.email.present?
      unless self.email == self.email_c
        errors.add(:email_c, 'debe coincidir con el correo electrónico')
      end
    end  
  end  

end
