story = Story.create! name: "Test Text"

step0 = Step.create! story: story

frame0 = Frame.create! text: "Le petit chaperon rouge", step: step0

branch0 = Branch.create!
branch0.frames << frame0

frame1 = frame0.add_follow_up text: "croise un loup."

frame2 = frame1.add_follow_up text: "Le loup lui dit :"

frame3 = frame2.add_follow_up text: "'Suuuup'"
frame4 = frame2.add_follow_up text: "'Bonjour'"

frame5 = frame3.add_follow_up text: "'T'as l'air cool brah'"
frame6 = frame4.add_follow_up text: "Ou vas tu donc ?"
frame7 = frame4.add_follow_up text: "Je vais te tuer"

frame8 = frame5.add_follow_up text: "'Tu veux de la beuh ?'"
frame9 = frame5.add_follow_up text: "'Tu veux faire du patin a roulette yo ?'"
frame10 = frame6.add_follow_up text: "'Chez ma grand mere !'"
frame11 = frame6.add_follow_up text: "'Au village !'"
frame12 = frame6.add_follow_up text: "'Nul part :U'"
frame13 = frame7.add_follow_up text: "'Oh shit' pensa le petit chaperon rouge"



story = Story.create! name: "Stick Adventure Bro"

step0 = Step.create! story: story

frame0 = Frame.create! text: "Choose your weapon", step: step0, image: File.new("#{Rails.root}/app/assets/images/seeds/0.jpg")

branch0 = Branch.create!
branch0.frames << frame0

frame1 = frame0.add_follow_up text: "", image: File.new("#{Rails.root}/app/assets/images/seeds/1-1.jpg")
frame2 = frame0.add_follow_up text: "", image: File.new("#{Rails.root}/app/assets/images/seeds/1-2.jpg")

frame3 = frame1.add_follow_up text: "Hum hi", image: File.new("#{Rails.root}/app/assets/images/seeds/1-1 1-1.jpg")
frame4 = frame1.add_follow_up text: "What are you doing here?!", image: File.new("#{Rails.root}/app/assets/images/seeds/1-1 1-2.jpg")
frame5 = frame2.add_follow_up text: "Hum hi", image: File.new("#{Rails.root}/app/assets/images/seeds/1-2 1-1.jpg")
frame6 = frame2.add_follow_up text: "What are you doing here?!", image: File.new("#{Rails.root}/app/assets/images/seeds/1-2 1-2.jpg")

frame7 = frame3.add_follow_up text: "Let's party my brogon!", image: File.new("#{Rails.root}/app/assets/images/seeds/2-1 1-1 1-1.jpg")
frame8 = frame3.add_follow_up text: "OK then!", image: File.new("#{Rails.root}/app/assets/images/seeds/2-1 1-1 1-2.jpg")

frame9 = frame5.add_follow_up text: "I shall cook us magic marshmallow!", image: File.new("#{Rails.root}/app/assets/images/seeds/2-2 1-1 1-1.jpg")
frame10 = frame5.add_follow_up text: "NIET IS FURFIRE!", image: File.new("#{Rails.root}/app/assets/images/seeds/2-2 1-1 1-2.jpg")