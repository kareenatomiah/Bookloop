# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "🔁 Resetting categories..."
Category.destroy_all

puts "📦 Creating categories..."
["Fantasy", "Romance", "Sci-Fi", "Thriller", "Crime", "Young Adult", "Horror", "Self-Help"].each do |cat|
  Category.create!(name: cat)
end

puts "👥 Creating users..."

user1 = User.find_or_create_by!(email: "kareena1508@gmail.com") do |u|
  u.name = "Kareena"
  u.username = "kareena1508"
  u.password = u.password_confirmation = "azerty123"
end

user2 = User.find_or_create_by!(email: "louann@example.com") do |u|
  u.name = "Louannsher"
  u.username = "louanngabillon"
  u.password = u.password_confirmation = "azerty123"
end

user3 = User.find_or_create_by!(email: "nina@example.com") do |u|
  u.name = "Nina"
  u.username = "ninalove"
  u.password = u.password_confirmation = "azerty123"
end

user4 = User.find_or_create_by!(email: "ethan@example.com") do |u|
  u.name = "Ethan"
  u.username = "ethan24"
  u.password = u.password_confirmation = "azerty123"
end

# puts "📸 Creating BeRead for Kareena..."

# BeRead.find_or_create_by!(user: user1, comment: "Kareena is the best")

puts "✅ Seed completed!"



puts "🔁 Resetting BookMetadata..."
BookMetadatum.destroy_all

puts "📚 Creating Self-Help books..."

BookMetadatum.create!(
  work_key: "/works/OL1968368W",
  author: "Robert Greene",
  category: "Self-Help",
  description: <<~DESC.strip
    The 48 Laws of Power is a modern classic that distills 3,000 years of wisdom from philosophers, strategists, and leaders into timeless lessons on influence, manipulation, and self-mastery.

    Drawing on the cunning of Machiavelli, the boldness of Sun Tzu, and the insight of powerful historical figures, Robert Greene presents 48 laws that reveal how power is acquired, defended, and lost. Whether you're navigating the workplace, politics, or personal relationships, each law offers ruthless yet deeply practical guidance.

    From "Law 1: Never outshine the master" to "Law 48: Assume formlessness", this book explores the dark art of strategy in a brutally honest and unapologetically pragmatic tone. Loved and loathed in equal measure, it has become a cult favorite among entrepreneurs, athletes, and creatives alike.

    The 48 Laws of Power is not a moral guide—it’s a survival manual for those who understand that power, like fire, must be handled with respect, clarity, and precision.
  DESC
)


puts "📚 Creating Fantasy books..."

BookMetadatum.create!(
  work_key: "/works/OL29226517W",
  author: "Rebecca Yarros",
  category: "Fantasy",
  description: "In the brutal world of Navarre, twenty-year-old Violet Sorrengail never expected to be thrust into the elite Riders Quadrant at Basgiath War College.

    Frail and studious, she had trained her whole life for a quiet role in the Scribes Quadrant. But when her mother, the commanding general, forces her into the brutal world of dragon riders, Violet is thrown into a whirlwind of danger, betrayal, and secrets.

    With dragons that don’t accept weakness, and deadly trials that eliminate the unworthy, she must prove she’s stronger than anyone imagined. And when secrets about the kingdom’s true history begin to unravel, Violet must decide who to trust—and whether survival is worth the cost of the truth.

    Fourth Wing is a spellbinding tale of courage, romance, and rebellion in a world where nothing is as it seems."

)

BookMetadatum.create!(
  work_key: "/works/OL43523737W",
  author: "Rebecca Yarros",
  category: "Fantasy",
  description: <<~DESC.strip
    In Iron Flame, Violet Sorrengail returns to Basgiath War College, but everything has changed. War is closer than ever, and betrayal lurks in every corner. As secrets rise to the surface and alliances crumble, Violet must face her fears and fight for her future.

    With the bond to her dragon deepening and her heart torn between loyalty and truth, she navigates a treacherous world where love and power collide.

    Iron Flame continues the electrifying story with higher stakes, fiercer battles, and an unforgettable journey into courage and defiance.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL41943074W",
  author: "Rebecca Yarros",
  category: "Fantasy",
  description: <<~DESC.strip
    In the brutal world of Navarre, twenty-year-old Violet Sorrengail never expected to be thrust into the elite Riders Quadrant at Basgiath War College.

    Frail and studious, she had trained her whole life for a quiet role in the Scribes Quadrant. But when her mother, the commanding general, forces her into the brutal world of dragon riders, Violet is thrown into a whirlwind of danger, betrayal, and secrets.

    With dragons that don’t accept weakness, and deadly trials that eliminate the unworthy, she must prove she’s stronger than anyone imagined. And when secrets about the kingdom’s true history begin to unravel, Violet must decide who to trust—and whether survival is worth the cost of the truth.

    Fourth Wing is a spellbinding tale of courage, romance, and rebellion in a world where nothing is as it seems.
  DESC
)


BookMetadatum.create!(
  work_key: "/works/OL5738147W",
  author: "Brandon Sanderson",
  category: "Fantasy",
  description: <<~DESC.strip
    Elantris was the city of the gods: radiant, powerful, and immortal. But every god was once a mortal, and Elantris has fallen.

    Now, its citizens are cursed — living corpses caught in eternal pain and decay, cast out and forgotten.

    Prince Raoden of Arelon wakes up one day transformed and thrown into Elantris. But instead of succumbing, he sets out to bring hope to the fallen.

    Meanwhile, Princess Sarene arrives in Arelon only to find herself a widow before the wedding. Political intrigue, mystery, and revolution collide as Sarene and Raoden fight against a dark religious empire.

    Elantris is a brilliant standalone epic of lost magic, political rebellion, and hope against all odds.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL20157354W",
  author: "Samantha Shannon",
  category: "Fantasy",
  description: <<~DESC.strip
    A world divided. A queendom without an heir. An ancient enemy awakens.

    The House of Berethnet has ruled Inys for a thousand years. Still unwed, Queen Sabran the Ninth must conceive a daughter to protect her realm from destruction — but assassins are getting closer to her door.

    Ead Duryan is an outsider at court. Though she has risen to the position of lady-in-waiting, she is loyal to a hidden society of mages. She keeps a watchful eye on Sabran, secretly protecting her with forbidden magic.

    Across the dark sea, Tané has trained all her life to be a dragonrider, but is forced to make a choice that could see her life unravel.

    The Priory of the Orange Tree is a sweeping epic of queens, dragons, and destiny, perfect for fans of high fantasy and feminist storytelling.
  DESC
)


puts "📚 Creating Romance books..."

BookMetadatum.create!(
  work_key: "/works/OL24390422W",
  author: "Ana Huang",
  category: "Romance",
  description: <<~DESC.strip
    In "Twisted Love", Ava Chen falls for her brother’s best friend, Alex Volkov—a man with a haunted past and a dangerous charm. Their connection is forbidden, but irresistible.

    As walls break down, secrets emerge. Can love heal a soul bound by vengeance? Or will it destroy everything in its path?

    Twisted Love is the first in a bestselling series of steamy, angsty, and addictive romances by Ana Huang.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL35677398W",
  author: "Chloe Walsh",
  category: "Romance",
  description: <<~DESC.strip
    "Binding 13" is a heart-wrenching and passionate story of Johnny Kavanagh, Ireland’s rugby golden boy, and Shannon Lynch, a broken girl hiding a dark past.

    As their worlds collide in school, love blooms in the most unexpected places. But demons from the past and pressures of fame threaten their fragile bond.

    A rollercoaster of emotions, trauma, healing, and first love.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL27965945W",
  author: "Chloe Walsh",
  category: "Romance",
  description: <<~DESC.strip
    "Keeping 13" continues Johnny and Shannon’s powerful journey. Love deepens, but so do the wounds they both carry.

    With media chaos, family issues, and self-doubt surrounding them, staying together becomes harder than ever.

    An emotional and intense sequel that explores love, pain, and the battle to keep what matters most.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL20248394W",
  author: "Jojo Moyes",
  category: "Romance",
  description: <<~DESC.strip
    Louisa Clark is an ordinary girl living an exceedingly ordinary life — steady boyfriend, close family — who has never been farther afield than their tiny village.

    Will Traynor is a high-powered man of the world who loved risk, speed, and adventure... until a motorcycle accident left him paralyzed.

    When Lou is hired to care for him, their worlds collide. At first resentful and distant, Will gradually opens up to Lou, and their bond becomes something that changes both of them forever.

    *Me Before You* is a heartfelt story about love, loss, and choosing how to live. It asks the question: what would you do if making the person you love happy meant breaking your own heart?
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL54797W",
  author: "Nicholas Sparks",
  category: "Romance",
  description: <<~DESC.strip
    In a quiet nursing home, an old man reads aloud from a worn-out notebook to a woman who no longer remembers him.

    The story he tells is one of love that bloomed in the 1940s: Noah Calhoun, a country boy back from the war, and Allie Nelson, a wealthy young woman, fell deeply in love one summer.

    But life and circumstance pulled them apart. Decades later, their story returns — a testament to enduring passion, heartbreak, and the power of memory.

    *The Notebook* is a timeless romance about how some loves are meant to last a lifetime — no matter what.
  DESC
)


puts "📚 Creating Sci-Fi books..."

BookMetadatum.create!(
  work_key: "/works/OL17076473W",
  author: "Pierce Brown",
  category: "Sci-Fi",
  description: <<~DESC.strip
    "Red Rising" follows Darrow, a lowborn Red miner on Mars, as he infiltrates the elite ruling class known as the Golds. In a society built on lies and brutality, Darrow rises to become a symbol of rebellion.

    A gripping tale of strategy, war, and identity in a dystopian universe.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL19340986W",
  author: "Pierce Brown",
  category: "Sci-Fi",
  description: <<~DESC.strip
    "Golden Son" intensifies the stakes as Darrow climbs higher within Gold society. Loyalties are tested and betrayals sting deep.

    With explosive twists and brutal battles, Darrow’s mission to bring justice to the worlds grows more dangerous.

    A fast-paced continuation of the Red Rising saga.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL19650409W",
  author: "Pierce Brown",
  category: "Sci-Fi",
  description: <<~DESC.strip
    In "Morning Star", the final installment of the trilogy, Darrow faces his greatest challenge yet: tearing down the empire from within.

    Allies fall. Enemies rise. And the price of freedom may be everything.

    A breathtaking conclusion to a revolutionary sci-fi epic.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL24731706W",
  author: "Emily St. John Mandel",
  category: "Sci-Fi",
  description: <<~DESC.strip
    Une forêt canadienne en 1912. Une station lunaire en 2203. Un musicien, un écrivain en tournée, une détective temporelle. Leurs vies n’auraient jamais dû se croiser — sauf qu’un phénomène étrange les relie tous : un battement, une faille, une boucle temporelle.

    *Sea of Tranquility* est une fresque subtile de science-fiction sur l’effondrement des mondes, le voyage dans le temps et la beauté de la vie, même fugace. Poétique, mélancolique, fascinant.
  DESC
)


BookMetadatum.create!(
  work_key: "/works/OL21745884W",
  author: "Andy Weir",
  category: "Sci-Fi",
  description: <<~DESC.strip
    Ryland Grace se réveille seul dans un vaisseau spatial, sans souvenir de sa mission ni de son identité. Ce qu’il découvre est terrifiant : il est la seule chance de sauver l’humanité.

    Avec seulement un ordinateur, ses connaissances scientifiques, et un allié inattendu, il doit résoudre une énigme cosmique… ou tout perdre.

    *Project Hail Mary* est une odyssée spatiale brillante, émotive et pleine d’humour, par l’auteur de *The Martian*.
  DESC
)

puts "📚 Creating Thriller books..."

BookMetadatum.create!(
  work_key: "/works/OL27729743W",
  author: "Freida McFadden",
  category: "Thriller",
  description: <<~DESC.strip
    "The Housemaid" tells the chilling story of Millie, who takes a live-in job with a wealthy family—only to discover their disturbing secrets.

    As her curiosity grows, so does the danger. A psychological thriller filled with twists and eerie suspense.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL34113490W",
  author: "Freida McFadden",
  category: "Thriller",
  description: <<~DESC.strip
    In "The Housemaid’s Secret", Millie returns to clean another house... and uncover another terrifying mystery.

    What starts as a new beginning becomes a nightmare laced with lies, murder, and betrayal.

    A dark and addictive sequel.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL37576476W",
  author: "Freida McFadden",
  category: "Thriller",
  description: <<~DESC.strip
    "The Housemaid is Watching" concludes Millie’s twisted journey. After trying to rebuild her life, new threats emerge and old enemies return.

    The line between right and wrong blurs once again in a finale full of shocking revelations.

    The ultimate psychological game.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL29327038W",
  author: "Lisa Jewell",
  category: "Thriller",
  description: <<~DESC.strip
    Alix, une podcasteuse célèbre, rencontre Josie lors d’un dîner d’anniversaire. Josie semble banale… jusqu’à ce qu’elle propose de devenir le sujet du prochain podcast.

    Très vite, Alix se retrouve prise dans une toile de secrets et de manipulations. Car Josie cache quelque chose. Et une fois qu’elle a mis la main sur vous, elle ne vous lâche plus.

    *None of This Is True* est un thriller psychologique haletant sur l’identité, le danger et le voyeurisme.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL27774874W",
  author: "Ana Reyes",
  category: "Thriller",
  description: <<~DESC.strip
    Maya est hantée par le souvenir d’un été : sa meilleure amie est morte subitement… sous les yeux d’un garçon mystérieux, Frank. Sept ans plus tard, une vidéo virale montre une mort identique, avec Frank encore là.

    Maya doit replonger dans ses souvenirs — et dans cette cabane perdue au milieu des pins — pour découvrir la vérité.

    *The House in the Pines* est un thriller psychologique à suspense lent, envoûtant et très addictif.
  DESC
)

puts "✅ Seeds created!"
