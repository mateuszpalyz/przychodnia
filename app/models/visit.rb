class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :patient
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :patient_id, presence: true

  validates :cause,      
  presence: { message: "Przyczyna zgłoszenia nie może być pusta" }, 
  length: { maximum: 255, message: "Przyczyna zgłoszenia za długa, maksimum 255 znaków"}

  validates :psymptom,      
  presence: { message: "Objawy zauważone przez pacjenta nie mogą być puste" }, 
  length: { maximum: 255, message: "Objawy zauważone przez pacjenta za długie, maksimum 255 znaków"}

  validates :time_symptom,      
  presence: { message: "Czas wystąpienia pierwszych objawów nie może być pusty" }, 
  length: { maximum: 255, message: "Czas wystąpienia pierwszych objawów za długi, maksimum 255 znaków"}

  validates :illness_change,      
  presence: { message: "Dynamika choroby nie może być pusta" }, 
  length: { maximum: 255, message: "Dynamika choroby za długa, maksimum 255 znaków"}

  validates :symptom_type,      
  presence: { message: "Cechy objawów nie mogą być puste" }, 
  length: { maximum: 255, message: "Cechy objawów są za długie, maksimum 255 znaków"}

  validates :time_illness,      
  presence: { message: "Początek choroby nie może być pusty" }, 
  length: { maximum: 255, message: "Początek choroby za długi, maksimum 255 znaków"}

  validates :freq_illness,      
  presence: { message: "Częstość występowania objawy nie może być pusta" }, 
  length: { maximum: 255, message: "Częstość wytępowania objawów za długa, maksimum 255 znaków"}

  validates :care,      
  presence: { message: "Dotychczasowa opieka nie może być pusta" }, 
  length: { maximum: 255, message: "Dotychczasowa opieka za długa, maksimum 255 znaków"}

  validates :dsymptom,      
  presence: { message: "Objawy na podstawie badania nie mogą być puste" }, 
  length: { maximum: 255, message: "Objawy na podstawie badania za długie, maksimum 255 znaków"}

  validates :illness,      
  presence: { message: "Diagnoza nie może być pusta" }, 
  length: { maximum: 255, message: "Diagnoza za długa, maksimum 255 znaków"}

  validates :drugs,      
  presence: { message: "Przepisane leki nie mogą być puste" }, 
  length: { maximum: 255, message: "Przepisane leki za długie, maksimum 255 znaków"}

 # Validates :next_visit
end
