# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users =
    User.create(
        [
            first_name: "امیرحسین" ,
            family_name: "جانی",
            phone_number: "09334682529" ,
            password_digest: "$2a$10$bz.MWukM2sUWyFjq6j1kyujt8W2l3XOZJchOMN0aeJ7iLildXR6qW" ,
            sex: 0 ,
            email: "amir.jani500@gmail.com",
            birthday: "2018-08-04",
            role: 0,
            is_private: true ,
            verification_code: 1111 ,
            verified: true ,
            status: true ,
            verification_code_sent_at: "2018-08-25 07:49:10.778897" ,
            forget_password: false
        ]
    ) ,
        User.create(
            [
                first_name: "احمد" ,
                family_name: "آزاد" ,
                phone_number: "09382782419" ,
                email: "ahmad@azad.com" ,
                password_digest: "$2a$10$bz.MWukM2sUWyFjq6j1kyujt8W2l3XOZJchOMN0aeJ7iLildXR6qW" ,
                sex: 0 ,
                birthday: "2018-08-04",
                role: 1,
                is_private: true ,
                verification_code: 1111 ,
                verified: true ,
                status: true ,
                verification_code_sent_at: "2018-08-25 07:49:10.778897" ,
                forget_password: false
            ]
    )
personalEvent = 
 Event.create(
  [
   user_id: User.first().id ,
   event_type: "personal",  
   date: "2018-12-15T", 
   description: "amirhossein Jani is here and coding", 
   title: "amir jani personal event", 
   location_lat: 35.689198, 
   location_long: 51.388973, 
   address: "sattarkhan", 
   start_time: "2018-12-15T08:59:37+00:00",
   end_time: "2018-12-15T10:00:37+00:00",
   repeat_time: "no_repeat",
   notification_time: "no_notification", 
   end_of_repeat: "2018-12-15T11:00:37+00:00", 
   is_private: true,
   is_verified: true, 
   photo: nil 
  ]
 )

colorEventUser = 
 UserColorEvent.create(
  [
   user_id: User.first().id, 
   event_type: 0, 
   event_color: 0 
  ]),UserColorEvent.create(
  [
   user_id: User.first().id,
   event_type: 1,
   event_color: 1
  ]),UserColorEvent.create(
  [
   user_id: User.first().id,
   event_type: 2,
   event_color: 2
  ]),UserColorEvent.create(
  [
   user_id: User.first().id,
   event_type: 3,
   event_color: 3
  ]),UserColorEvent.create(
  [
   user_id: User.first().id,
   event_type: 4,
   event_color: 4
  ])

national_event = NationalEvent.create(
  [
    user_id: User.first().id,
    date: "2018-12-29T" , 
    title: "vafat e emam" , 
    description: "emam rahmat dar in tarikh fot karde" , 
    is_day_off: true
  ]),NationalEvent.create(
  [
    user_id: User.first().id,
    date: "2018-12-30T" ,
    title: "vafat e emam1" ,
    description: "emam1 rahmat dar in tarikh fot karde" ,
    is_day_off: false
  ]),NationalEvent.create(
  [
    user_id: User.first().id,
    date: "2019-01-03T" ,
    title: "vafat e emam3" ,
    description: "emam3 rahmat dar in tarikh fot karde" ,
    is_day_off: true
  ]),NationalEvent.create(
  [
    user_id: User.first().id,
    date: "2019-01-07T" ,
    title: "vafat e emam4" ,
    description: "emam4 rahmat dar in tarikh fot karde" ,
    is_day_off: true
  ])

socialEventCategory = 
  SocialEventCategory.create(
  [
    title: "cat 1"
  ]),SocialEventCategory.create( 
  [
    title: "cat 2"
  ]),SocialEventCategory.create( 
  [
    title: "cat 3"
  ]),SocialEventCategory.create( 
  [
    title: "cat 4"
  ])



