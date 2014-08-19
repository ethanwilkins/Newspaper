class Vote < ActiveRecord::Base
  belongs_to :posts
  
  def self.up_vote!(obj, user)
    vote ||= obj.votes.find_by_voter_id(user.id)
    unless vote
      obj.votes.create up: true, voter_id: user.id
    else
      vote.update up: true
    end
  end
  
  def self.un_vote!(obj, user)
    vote ||= obj.votes.find_by_voter_id(user.id)
    vote.update up: false if vote
  end
  
  def self.score(obj)
    _score = (obj.votes.up_votes.size.to_i - obj.votes.down_votes.size.to_i) - 
      (Date.today - obj.created_at.to_date).to_i
    return _score
  end

  def self.up_voted?(obj, user)
    vote ||= obj.votes.find_by_voter_id(user)
    vote.up if vote
  end
  
  def self.up_votes
    where up: true
  end
end
