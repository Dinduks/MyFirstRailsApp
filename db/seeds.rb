# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
    {
      email:       'samy@dindane.com', 
      password:    'samysawesome',
      admin:       true
    },
    {
      email:       'hello@world.com', 
      password:    'helloworld'
    },
 ])

Article.create([
    {
      titre:       'KORG X50',
      image:       '8714701_1.jpg',
    },
    {
      titre:       'An arrow to the knee ',
      image:       'arrow.JPG',
      description: 'If you used to be an adventurer like me...'
    },
    {
      titre:       'SSD',
      image:       'ssd-test-jeu-video.jpg',
    },
])