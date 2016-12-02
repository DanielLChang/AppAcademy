class Question < ActiveRecord::Base

  validates :text, :poll_id, presence: true

  belongs_to :poll,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: 'Poll'

  has_many :answer_choices,
  primary_key: :id,
  foreign_key: :question_id,
  class_name: 'AnswerChoice'

  has_many :responses,
  through: :answer_choices,
  source: :responses

  def results
    result = Hash.new(0)
    self.answer_choices.each do |choice|
      result[choice.text] += choice.responses.length
    end
    result
  end

  def results_n2
    result = Hash.new(0)
    self.answer_choices.includes(:responses) do |choice|
      result[choice.text] += choice.responses.length
    end
    result
  end

  def improved_results_n2
    acs = AnswerChoice.find_by_sql([<<-SQL, id])
      SELECT
        answer_choices.text,
        COUNT(responses.id) as responses_count
      FROM answer_choices
        LEFT OUTER JOIN
          responses ON answer_choices.id = responses.answer_id
      WHERE answer_choices.question_id = ?
      GROUP BY answer_choices.id
    SQL

    results = Hash.new(0)

    acs.each do |choice|
      results[choice.text] = choice.responses_count
    end

    results

    # results.max_by {|k,v| v}[0

  end

end
