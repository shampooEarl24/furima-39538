module ItemsHelper
  before_action :authenticate_user!, except: :index

  def index
  end
end
