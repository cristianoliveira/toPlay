# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  math = Course.create(name: 'Matematica');
  stat = Course.create(name: 'Estatistica');

  mq = math.subjects.create(name: "Quantica");
  level1 = mq.levels.create({name: "Level 1"});
  level1.topics.create({name: "Topico 1"});
  level1.topics.create({name: "Topico 2"})
  level1.topics.create({name: "Topico 3"})
  level2 = mq.levels.create({name: "Level 2"});
  level2.topics.create({name: "Topico 1"});
  level2.topics.create({name: "Topico 2"})
  level2.topics.create({name: "Topico 3"})

  mq = stat.subjects.create(name: "Aplicada");
  level1 = mq.levels.create({name: "Level 1"});
  level1.topics.create({name: "Topico 1"});
  level1.topics.create({name: "Topico 2"})
  level1.topics.create({name: "Topico 3"})
  level2 = mq.levels.create({name: "Level 2"});
  level2.topics.create({name: "Topico 1"});
  level2.topics.create({name: "Topico 2"})
  level2.topics.create({name: "Topico 3"})

  admin = AdminUser.new({email:"admin@torreplay.com.br", password: "admin123", password_confirmation: "admin123"})
  admin.save

  
