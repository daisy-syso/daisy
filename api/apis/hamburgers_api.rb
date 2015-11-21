class HamburgersAPI < Grape::API

  get 'hamburgers' do
    @hamburgers = Hamburger.all.order("created_at desc")

    present @hamburgers, with: ::HamburgerEntity
  end
end