import React from 'react';

class Weather extends React.Component {
  constructor() {
    super();
    this.getLocation = this.getLocation.bind(this);
    this.getWeather = this.getWeather.bind(this);
    this.state = { location:  };
  }

  getLocation() {

  }

  getWeather() {
    let request = new XMLHTTPRequest();
    request.open('GET',
      `http://api.openweathermap.org/data/2.5/weather?lat=${this.state.lat}&lon=${this.state.lon}`,
      true);

    request.send();
  }

  componentDidMount() {

  }

  render() {
    return (
      <div></div>
    );
  }
}

// 60eedff74f52b52ead090b7cf7b3f8bb

export default Weather;
