# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string(255)      not null
#  content    :text(65535)
#  category   :string(255)
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
end
