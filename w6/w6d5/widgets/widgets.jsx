import React from 'react';
import ReactDOM from 'react-dom';

import Tabs from './tabs';
import Weather from './weather';
import Clock from './clock';


const Panes = [
  {title: 'one', content: 'I am the first'},
  {title: 'two', content: 'Second pane here'},
  {title: 'three', content: 'Third pane here'}
];

class Root extends React.Component {

  render() {
    return (
      <div>
        <h1>Weather</h1>
        <Weather />
        <h1>Clock</h1>
        <Clock />
        <h1>Tabs</h1>
        <Tabs panes={Panes} />
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Root />, document.getElementById('main'));
});
