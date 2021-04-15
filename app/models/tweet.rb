class Tweet < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweet, class_name: "Tweet", foreign_key: "retweet_id"
  has_and_belongs_to_many :tags
  scope :tweets_for_me, ->(friendship) {where(user_id: friendship)}

  
  after_create do
    tweet = Tweet.find_by(id: self.id)
    hastags = self.content.scan(/#\w+/)
    hastags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
        tweet.tags << tag
    end
  end

  after_update do
      tweet = Tweet.find_by(id: self.id)
      tweet.tags.clear
      hastags = self.content.scan(/#\w+/)
      hastags.uniq.map do |hashtag|
          tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
          tweet.tags << tag
      end
  end

end
