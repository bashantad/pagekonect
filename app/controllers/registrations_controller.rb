class RegistrationsController < Devise::RegistrationsController
  layout 'user'

  def update
    binding.pry
    super
  end
end