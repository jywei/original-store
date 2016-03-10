module ChargesHelper

  def successful?
    @response.present?
  end
end
