module PollsHelper
  def up_voted? choice
    choice.votes.where(voter_id: current_user.id).where(up: true).present?
  end
  
  def down_voted? choice
    choice.votes.where(voter_id: current_user.id).where(down: true).present?
  end
end
