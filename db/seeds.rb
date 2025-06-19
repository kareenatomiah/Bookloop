# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "🔁 Resetting BookMetadata..."
BookMetadatum.destroy_all

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
  work_key: "/works/OL999999W",
  author: "Rebecca Yarros",
  category: "Fantasy",
  description: <<~DESC.strip
    In Iron Flame, Violet Sorrengail returns to Basgiath War College, but everything has changed. War is closer than ever, and betrayal lurks in every corner. As secrets rise to the surface and alliances crumble, Violet must face her fears and fight for her future.

    With the bond to her dragon deepening and her heart torn between loyalty and truth, she navigates a treacherous world where love and power collide.

    Iron Flame continues the electrifying story with higher stakes, fiercer battles, and an unforgettable journey into courage and defiance.
  DESC
)

puts "📚 Creating Romance books..."

BookMetadatum.create!(
  work_key: "/works/OL123456W",
  author: "Ana Huang",
  category: "Romance",
  description: <<~DESC.strip
    In "Twisted Love", Ava Chen falls for her brother’s best friend, Alex Volkov—a man with a haunted past and a dangerous charm. Their connection is forbidden, but irresistible.

    As walls break down, secrets emerge. Can love heal a soul bound by vengeance? Or will it destroy everything in its path?

    Twisted Love is the first in a bestselling series of steamy, angsty, and addictive romances by Ana Huang.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL234567W",
  author: "Chloe Walsh",
  category: "Romance",
  description: <<~DESC.strip
    "Binding 13" is a heart-wrenching and passionate story of Johnny Kavanagh, Ireland’s rugby golden boy, and Shannon Lynch, a broken girl hiding a dark past.

    As their worlds collide in school, love blooms in the most unexpected places. But demons from the past and pressures of fame threaten their fragile bond.

    A rollercoaster of emotions, trauma, healing, and first love.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL345678W",
  author: "Chloe Walsh",
  category: "Romance",
  description: <<~DESC.strip
    "Keeping 13" continues Johnny and Shannon’s powerful journey. Love deepens, but so do the wounds they both carry.

    With media chaos, family issues, and self-doubt surrounding them, staying together becomes harder than ever.

    An emotional and intense sequel that explores love, pain, and the battle to keep what matters most.
  DESC
)

puts "📚 Creating Sci-Fi books..."

BookMetadatum.create!(
  work_key: "/works/OL456789W",
  author: "Pierce Brown",
  category: "Sci-Fi",
  description: <<~DESC.strip
    "Red Rising" follows Darrow, a lowborn Red miner on Mars, as he infiltrates the elite ruling class known as the Golds. In a society built on lies and brutality, Darrow rises to become a symbol of rebellion.

    A gripping tale of strategy, war, and identity in a dystopian universe.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL567890W",
  author: "Pierce Brown",
  category: "Sci-Fi",
  description: <<~DESC.strip
    "Golden Son" intensifies the stakes as Darrow climbs higher within Gold society. Loyalties are tested and betrayals sting deep.

    With explosive twists and brutal battles, Darrow’s mission to bring justice to the worlds grows more dangerous.

    A fast-paced continuation of the Red Rising saga.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL678901W",
  author: "Pierce Brown",
  category: "Sci-Fi",
  description: <<~DESC.strip
    In "Morning Star", the final installment of the trilogy, Darrow faces his greatest challenge yet: tearing down the empire from within.

    Allies fall. Enemies rise. And the price of freedom may be everything.

    A breathtaking conclusion to a revolutionary sci-fi epic.
  DESC
)

puts "📚 Creating Thriller books..."

BookMetadatum.create!(
  work_key: "/works/OL789012W",
  author: "Freida McFadden",
  category: "Thriller",
  description: <<~DESC.strip
    "The Housemaid" tells the chilling story of Millie, who takes a live-in job with a wealthy family—only to discover their disturbing secrets.

    As her curiosity grows, so does the danger. A psychological thriller filled with twists and eerie suspense.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL890123W",
  author: "Freida McFadden",
  category: "Thriller",
  description: <<~DESC.strip
    In "The Housemaid’s Secret", Millie returns to clean another house... and uncover another terrifying mystery.

    What starts as a new beginning becomes a nightmare laced with lies, murder, and betrayal.

    A dark and addictive sequel.
  DESC
)

BookMetadatum.create!(
  work_key: "/works/OL901234W",
  author: "Freida McFadden",
  category: "Thriller",
  description: <<~DESC.strip
    "The Housemaid is Watching" concludes Millie’s twisted journey. After trying to rebuild her life, new threats emerge and old enemies return.

    The line between right and wrong blurs once again in a finale full of shocking revelations.

    The ultimate psychological game.
  DESC
)

puts "✅ Seeds created!"
