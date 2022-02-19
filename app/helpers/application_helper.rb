# frozen_string_literal: true

module ApplicationHelper
  def title
    content_for(:title) || t("#{controller_path.tr('/', '.')}.#{action_name}.title", default: '')
  end
end
