class Vote < ActiveRecord::Base
  belongs_to :posts
  belongs_to :poll
  
  def self.up_vote! obj, user
    vote ||= obj.votes.find_by_voter_id(user.id)
    if vote and vote.poll_id
      Poll.find(poll_id).choices.each do |choice|
        choice.votes.where(user.id).update_all up: true, down: false
      end
    end
    if not vote
      obj.votes.create up: true, voter_id: user.id
    elsif vote and vote.up
      vote.update up: false
    else
      vote.update up: true, down: false
    end
  end
  
  def self.un_vote_all user, vote
    
  end
  
  def self.down_vote! obj, user
    vote ||= obj.votes.find_by_voter_id(user.id)
    if not vote
      obj.votes.create down: true, voter_id: user.id
    elsif vote and vote.down
      vote.update down: false
    else
      vote.update down: true, up: false
    end
  end
  
  def self.un_vote! obj, user
    vote ||= obj.votes.find_by_voter_id(user.id)
    vote.update up: false, down: false if vote
  end

  def self.up_voted? obj, user
    vote ||= obj.votes.find_by_voter_id(user)
    vote.up if vote
  end
  
  def self.score obj
    up_votes = obj.votes.where(up: true).size
    down_votes = obj.votes.where(down: true).size
    return up_votes - down_votes
  end
end
