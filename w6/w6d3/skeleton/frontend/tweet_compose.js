const APIUtil = require('./api_util');

class TweetCompose {
  constructor(el) {
    this.$el = $(el);

    this.$input = this.$el.find("textarea");
    this.$input.on("input", this.handleInput.bind(this));

    this.$mentionedUsers = this.$el.find(".mentioned-users");
    // add mentioned users
    this.$el.find("a.add-mentioned-user").on(
      "click", this.addMentionedUser.bind(this));
    // remove mentioned users
    this.$el.find("a.remove-mentioned-user").on(
      "click", this.removeMentionedUser.bind(this));

    this.$el.on("submit", this.submit.bind(this));
    // debugger;
  }

  addMentionedUser(e) {
    e.preventDefault();

    const $selectUser = $(this.$mentionedUsers.find("script").html());
    this.$mentionedUsers.find("ul").append($selectUser);
    return false;
  }

  removeMentionedUser(e) {
    e.preventDefault();
    $(e.currentTarget).parent().remove();
  }

  handleInput(e) {
    const inputLength = this.$input.val().length;
    this.$el.find(".char-left").text(`${140 - inputLength} chars left`);
  }

  clearInput() {
    this.$input.val("");
    this.$mentionedUsers.find("ul").empty();
    this.$el.find(":input").prop("disabled", false);
    this.$el.find(".char-left").empty();
  }

  handleSuccess(data) {
    const $tweetsUl = $(this.$el.data("tweets-ul"));
    $tweetsUl.trigger("insert-tweet", data);

    this.clearInput();
  }

  submit(e) {
    e.preventDefault();

    const data = this.$el.serializeJSON();
    this.$el.find(":input").prop("disabled", true);
    debugger;
    APIUtil.createTweet(data.tweet).then(tweet => {
      this.handleSuccess(tweet);
    });

  }
}

module.exports = TweetCompose;
