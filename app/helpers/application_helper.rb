module ApplicationHelper
  def category_image(name)
    case name.downcase
    when "fantasy"
      "https://images.unsplash.com/photo-1503437313881-503a91226402" # paysage magique
    when "romance"
      "https://images.unsplash.com/photo-1506744038136-46273834b3fb" # couple amoureux
    when "sci-fi"
      "https://images.unsplash.com/photo-1549924231-f129b911e442"   # ville futuriste
    when "thriller"
      "https://images.unsplash.com/photo-1534447677768-be436bb09401" # ambiance sombre, rue la nuit
    when "crime"
      "https://images.unsplash.com/photo-1608889174112-31d94237e5f9" # scène d'enquête, lumière rouge
    when "young adult"
      "https://images.unsplash.com/photo-1603297625799-bb8e5fa3e918" # livres, carnet, ambiance ado
    when "horror"
      "https://images.unsplash.com/photo-1602930940719-b2b51c0a81f3" # forêt sombre, ambiance creepy
    else
      "https://images.unsplash.com/photo-1526304640581-3ad991d90eb2" # pile de livres générique
    end
  end
end
