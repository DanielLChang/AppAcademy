class Response < ActiveRecord::Base

validates :answer_id, :responder_id, presence: true
validate respondent_already_answered?

belongs_to :answer_choice,
primary_key: :id,
foreign_key: :answer_id,
class_name: 'AnswerChoice'

belongs_to :respondent,
primary_key: :id,
foreign_key: :responder_id,
class_name: 'User'

has_one :question,
through: :answer_choice,
source: :question

def sibling_responses
  self.question.responses.where.not(id: self.id)
end

def respondent_already_answered?
  # self.sibling_responses.COUNT(where(responder_id: self.respondent.id)) > 0
  if sibling_responses.exists?(responder_id: self.responder_id)
    errors[:responder_id] << "already responded"
  end
end

def own_poll?
  if self.respondent.id == self.question.poll.author_id
    errors[:responder_id] << "can't cook books"
  end
end



end
