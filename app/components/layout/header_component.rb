# frozen_string_literal: true

module Layout
  class HeaderComponent < ViewComponent::Base
    def initialize(user:)
      @user = user
    end

    def render?
      @user.present?
    end
  end
end
