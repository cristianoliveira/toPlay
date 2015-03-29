# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# COURSES
  connection = ActiveRecord::Base.connection();
  course = Course.create(name: 'ENEM & Vestibular');
  subject = course.subjects.create(name: "Física");
  level = subject.levels.create(name: 'Introdução a Física');
  level.topic.create(name: 'Grandezas e Medidas');
  level.topic.create(name: "Cinemática");
  level.topic.create(name: "As Leis de Newton");
  level.topic.create(name: "Energia Mecânica");
  level.topic.create(name: "Impulso e Quantidade de Movimento");
  level.topic.create(name: "Estática");
  level.topic.create(name: "Gravitação");
  level.topic.create(name: "Hidrostática");
  level.topic.create(name: "Eletrostática");
  level.topic.create(name: "Eletrodinâmica");
  level.topic.create(name: "Magnetismo");

# ADMIN USER
  admin = User.new({email:"admin@torreplay.com.br", password: "admin123", password_confirmation: "admin123"})
  admin.role = :administrator
  admin.confirmed_at = "2015-01-01"
  admin.save
