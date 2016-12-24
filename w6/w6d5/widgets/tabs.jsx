import React from 'react';

class Tabs extends React.Component {
  constructor(props) {
    super(props);
    this.state = { selectedTab: 0 };

    // this.switchSelected = this.switchSelected.bind(this);
  }

  switchSelected(idx) {
    this.setState({selectedTab: idx});
  }

  render() {
    let titles = this.props.panes.map ((pane, idx) => (
      <li className="tab" key={idx} onClick={this.switchSelected.bind(this, idx)}>
        <h1>{pane.title}</h1>
      </li>
    ));

    return (
      <div className="tabs-and-content">
        <h1>Tabs</h1>
        <ul className="tabs">
          {titles}
        </ul>

        <article key={this.state.selectedTab}>
          {this.props.panes[this.state.selectedTab].content}
        </article>
      </div>
    );
  }
}

export default Tabs;
