require_relative 'questions_database'
require_relative 'question'
# require_relative 'user'

class QuestionLike
  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.liker_id
      WHERE
        question_likes.question_id = ?
    SQL
    likers.map do |liker|
      User.new(liker)
    end
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS like_count
      FROM
        question_likes
      WHERE
        question_id = ?
      GROUP BY
        question_id
    SQL
    num_likes.empty? ? 0 : num_likes.first['like_count']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        question_likes.liker_id = ?
    SQL
  end

  def self.most_liked_questions(n)
    question_liked = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
  end
end
