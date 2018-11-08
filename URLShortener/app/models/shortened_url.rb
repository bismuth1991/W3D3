# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'SecureRandom'

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true

  belongs_to :users, {
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
  }

  has_many :visits, {
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: 'Visit'
  }

  has_many :visitors, {
    through: :visits,
    source: :user
  }



  def self.random_code
    SecureRandom.urlsafe_base64
  end

  def self.create!(user, long_url)
    short_url = ShortenedUrl.make_short_url
    ShortenedUrl.new(user_id: user.id, long_url: long_url, short_url: short_url).save
  end

  def self.make_short_url
    shortened_url = ShortenedUrl.random_code
    if ShortenedUrl.exists?(short_url: shortened_url)
      make_short_url
    else
      shortened_url
    end
  end
end
