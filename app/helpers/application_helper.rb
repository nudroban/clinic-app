# frozen_string_literal: true

module ApplicationHelper
  def toast_type_for(flash_type)
    case flash_type.to_sym
    when :notice,  :success then 'success'
    when :alert,   :error   then 'error'
    else                         'info'
    end
  end
end
