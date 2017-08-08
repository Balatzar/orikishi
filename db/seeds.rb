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
