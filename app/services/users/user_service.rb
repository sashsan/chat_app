module Users::UserService
  extend ActiveSupport::Concern

  included do
    def user_name
      name_part = email.split('@').first
      name_part.gsub(/[\._-]/, ' ').split.map(&:capitalize).join(' ')
    end
  end
end
