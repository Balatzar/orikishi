story = Story.create! name: "Test Text"

step0 = Step.create! story: story

frame0 = Frame.create! text: "Je", step: step0

branch0 = Branch.create!
branch0.frames << frame0

frame1 = frame0.add_follow_up text: "suis"

frame2 = frame1.add_follow_up text: "un"

frame3 = frame2.add_follow_up text: "caca"
frame4 = frame2.add_follow_up text: "gentil"

frame5 = frame3.add_follow_up text: "poilu"
frame6 = frame4.add_follow_up text: "geant"
frame7 = frame4.add_follow_up text: "dinosaure"

frame8 = frame5.add_follow_up text: "et"
frame9 = frame5.add_follow_up text: "mais"
frame10 = frame6.add_follow_up text: "grand"
frame11 = frame7.add_follow_up text: "vieux"
frame12 = frame7.add_follow_up text: "dans"
frame13 = frame7.add_follow_up text: "sanguinaire"
