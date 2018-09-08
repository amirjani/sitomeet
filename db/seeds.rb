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
            name: "امیرحسین جانی" ,
            phone_number: "09334682529" ,
            password_digest: "$2a$10$bz.MWukM2sUWyFjq6j1kyujt8W2l3XOZJchOMN0aeJ7iLildXR6qW" ,
            sex: 0 ,
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
                name: "احمد آزاد" ,
                phone_number: "09382782419" ,
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
