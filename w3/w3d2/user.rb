# require_relative 'question_follow'
require_relative 'question_like'
require_relative 'modelbase'

class User < ModelBase

  attr_reader :id
  attr_accessor :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_author_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT(questions.id)) AS avg
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = ?
    SQL
    karma.first['avg']
  end

end
