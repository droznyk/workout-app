module ChatroomService
  class << self
    def create(user)
      hyphenated_username = user.full_name.split.join('-')
      Room.create(name: hyphenated_username, user_id: user.id)
    end
  end
end
