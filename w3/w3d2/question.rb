# require_relative 'question_follow'
require_relative 'reply'
# require_relative 'question_like'
require_relative 'modelbase'

class Question < ModelBase

  attr_reader :id, :author_id
  attr_accessor :title, :body

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    author_name = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
      SELECT
        fname,
        lname
      FROM
        users
      WHERE
        id = ?
    SQL
    author_name.first.values.join(" ")
  end

  def replies
    reply = Reply.find_by_question_id(@id)
    reply.map(&:body)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
end
