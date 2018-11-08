class Visit < ApplicationRecord
  belongs_to :user, {
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
  }

  belongs_to :short_url, {
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: 'ShortenedUrl'
  }

end
