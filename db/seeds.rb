# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# COURSES
  p "Seeding defaults courses..."
  course = Course.create(name: 'ENEM & Vestibular');

  subject = course.subjects.create(name: "Física");

  level_position = 0;
  level = subject.levels.create(name: 'Introdução a Física', position: level_position+=1);
  topic_position = 0;
  level.topics.create(name: "Grandezas e medidas", position: topic_position+=1);
  level.topics.create(name: "Vetores e operações vetoriais", position: topic_position+=1);
  level.topics.create(name: "Notação científica", position: topic_position+=1);

  level = subject.levels.create(name: "Cinemática", position: level_position += 1);
  topic_position = 0;
  level.topics.create(name: "Velocidade instantânea e média", position: topic_position+=1);
  level.topics.create(name: "Aceleração", position: topic_position+=1);
  level.topics.create(name: "MRU", position: topic_position+=1);
  level.topics.create(name: "MRUV", position: topic_position+=1);
  level.topics.create(name: "Gráficos de MRU e MRUV", position: topic_position+=1);
  level.topics.create(name: "Queda livre e lançamento vertical", position: topic_position+=1);
  level.topics.create(name: "Lançamento horizontal e oblíquo", position: topic_position+=1);
  level.topics.create(name: "MCU", position: topic_position+=1);

  level = subject.levels.create(name: "As Leis de Newton", position: level_position+=1);
  topic_position = 0;
  level.topics.create(name: "Força, massa e peso", position: topic_position+=1);
  level.topics.create(name: "Inércia: 1a lei de Newton", position: topic_position+=1);

# ADMIN USER
  admin = User.new({email:"admin@torreplay.com.br", password: "admin123", password_confirmation: "admin123"})
  admin.role = :administrator
  admin.confirmed_at = "2015-01-01"
  admin.save
