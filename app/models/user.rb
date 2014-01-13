class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name,      
  presence: { message: "Imię nie może być puste" }, 
  length: { maximum: 30, message: "Imię jest za długie, maksimum 30 znaków"} 

  validates :surname,   
  presence: { message: "Nazwisko nie może być puste" }, 
  length: { maximum: 30 ,message: "Nazwisko jest za długie, maksimum 30 znaków"}

  VALID_NUM = /[0-9]{2}/
  validates :age,       
  presence: { message: "Wiek nie może być pusty" }, 
  format: { with: VALID_NUM, message: "Wiek poza skalą" }

  validates :specialty, 
  presence: { message: "Specjalność nie może być pusta" }, 
  length: { maximum: 30, message: "Specjalność jest za długa, maksimum 30 znaków" }

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email,     
  presence: { message: "Email nie może być pusty" }, 
  format: { with: VALID_EMAIL, message: "Email o niepoprawnym formacie" }, 
  uniqueness: { case_sensitive: false, message: "Konto o podanym adresie email już istnieje" }
  
  has_secure_password
  
  validates_confirmation_of :password, message: "Hasła nie są takie same", if: :password_confirmation_required?
  validates_presence_of :password, message: "Hasło nie może być puste",  on: :create
  validates_length_of :password, minimum: 6, message: "Hasło za krótkie, minimum 6 znaków" 
  validates_presence_of :password_confirmation, message: "Potwierdz hasło", if: :password_confirmation_required?

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def password_confirmation_required?
      password_confirmation && password.present?
    end

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end