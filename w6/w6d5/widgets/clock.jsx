import React from 'react';

class Clock extends React.Component {
  constructor() {
    super();
    this.state = { date: new Date() };
    this.updateTime = this.updateTime.bind(this);
  }

  updateTime() {
    this.setState( { date: new Date() } );
  }

  componentDidMount() {
    window.setInterval(this.updateTime, 1000);
  }

  componentWillUnmount() {
  }

  render() {

    return (
      <div>
        <h1>{this.state.date.toDateString()}</h1>
        <h1>{this.state.date.toTimeString()}</h1>
      </div>
    );
  }
}

export default Clock;
