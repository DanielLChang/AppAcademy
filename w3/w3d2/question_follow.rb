require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow

  attr_reader :id, :follower_id, :question_id

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_follows ON question_follows.follower_id = users.id
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_id = ?
    SQL
    followers.map do |follower|
      User.new(follower)
    end
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        users
      JOIN
        question_follows ON question_follows.follower_id = users.id
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        follower_id = ?
    SQL
    questions.map do |question|
      Question.new(question)
    end
  end

  def self.most_followed_questions(n)
    question_data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
  end

  def initialize(options)
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end

end
