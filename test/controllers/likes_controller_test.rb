require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    # On récupère des données de test (fixtures)
    @user = users(:one) 
    @gossip = gossips(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Like.count' do
      post gossip_likes_path(@gossip), params: { gossip_id: @gossip.id }
    end
    # Vérifie que l'app redirige bien vers le login (ton système de sécurité)
    assert_redirected_to new_session_path
  end

  test "should create like when logged in" do
    log_in_as(@user)
    assert_difference 'Like.count', 1 do
      post gossip_likes_path(@gossip), params: { gossip_id: @gossip.id }
    end
    assert_redirected_to gossip_path(@gossip)
  end
end