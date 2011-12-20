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

Product.create([
    {
      title:       'KORG X50',
      image:       '8714701_1.jpg',
      price:       600
    },
    {
      title:       'An arrow to the knee ',
      image:       'arrow.JPG',
      price:       9000,
      description: 'If you used to be an adventurer like me...'
    },
    {
      title:       'SSD',
      price:       150,
      image:       'ssd-test-jeu-video.jpg',
    },
])