ActiveAdmin.register User do

  permit_params :name, :avatar, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
    index do
      selectable_column
      id_column
      column :name
      column :email
      column :sign_in_count
      column :created_at
      column :tweet_count do |user|
        columns user.tweets.count
      end
      column :followed_count do |user|
        columns user.friends.count
      end
      column :likes_count do |user|
        columns user.likes.count
      end
      column :retweet_count do |user|
        columns user.tweets.pluck(:retweet_id).compact!
      end
      actions
    end
    
    
  end