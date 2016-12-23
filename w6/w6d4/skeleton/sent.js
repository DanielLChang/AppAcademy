const MessageStore = require('./message_store');

module.exports = {
  render() {
    let container = document.createElement("ul");
    let messages = MessageStore.getSentMessages();

    container.className = "messages";
    messages.forEach( message => {
      container.appendChild(this.renderMessage(message));
    });

    return container;
  },

  renderMessage(message) {
    let el = document.createElement("li");
    el.className = "message";
    el.innerHTML = `<span class="to">${message.to}</span>
                    <span class="subject">${message.subject}</span> -
                    <span class="body">${message.body}</span>`;
    return el;
  }
};
