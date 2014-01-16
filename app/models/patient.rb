class Patient < ActiveRecord::Base
  self.per_page = 10
  has_many :visits, dependent: :destroy

  validates :name,      
  presence: { message: "Imię nie może być puste" }, 
  length: { maximum: 30, message: "Imię jest za długie, maksimum 30 znaków"}

  validates :surname,   
  presence: { message: "Nazwisko nie może być puste" }, 
  length: { maximum: 30 ,message: "Nazwisko jest za długie, maksimum 30 znaków"}

  VALID_NUM = /[0-9]{11}/
  validates :pesel,       
  presence: { message: "PESEL nie może być pusty" }, 
  format: { with: VALID_NUM, message: "PESEL o nieprawidłowym formacie" },
  uniqueness: { case_sensitive: false, message: "Pacjent o podanym PESELu już istnieje" }

  has_secure_password
  
  validates_confirmation_of :password, message: "Hasła nie są takie same", if: :password_confirmation_required?
  validates_presence_of :password, message: "Hasło nie może być puste",  on: :create
  validates_length_of :password, minimum: 6, message: "Hasło za krótkie, minimum 6 znaków" 
  validates_presence_of :password_confirmation, message: "Potwierdz hasło", if: :password_confirmation_required?

  private

    def password_confirmation_required?
      password_confirmation && password.present?
    end
end
