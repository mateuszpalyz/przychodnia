namespace :db do
  desc "Fill database with data"
  task populate: :environment do
    admin = User.create!(name: "Robert",
                         surname: "Olcha",
                         email: "admin@example.com",
                         age: 28,
                         specialty: "administrator",
                         password: "strongpassword",
                         password_confirmation: "strongpassword",
                         admin: true)
  end
end
