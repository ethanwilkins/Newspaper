class Vote < ActiveRecord::Base
  belongs_to :posts
  
  def self.up_vote!(obj, user)
    vote = obj.votes.find_by_voter(user) if obj.votes.find_by_voter(user)
    unless vote
      obj.votes.create up: true, voter: user.id
    else
      vote.update(down: false, up: true) if vote.down
    end
  end
  
  def self.down_vote!(obj, user)
    vote = obj.votes.find_by_voter(user) if obj.votes.find_by_voter(user)
    unless vote
      obj.votes.create down: true, voter: user.id
    else
      vote.update(up: false, down: true) if vote.up
    end
  end
  
  def self.score(obj)
    _score = (obj.votes.up_votes.size.to_i - obj.votes.down_votes.size.to_i) - 
      (Date.today - obj.created_at.to_date).to_i
      
    return _score
  end
  
  def self.up_votes
    where up: true
  end
  
  def self.down_votes
    where down: true
  end
end
