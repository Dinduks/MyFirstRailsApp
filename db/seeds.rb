User.create([
    {
      email:       'samy@dindane.com', 
      password:    'samysawesome',
      admin:       1
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