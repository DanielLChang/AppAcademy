import React from 'react';
import ItemDetailContainer from './item_detail_container';
import { Link } from 'react-router';

class ItemDetail extends React.Component {

  render() {
    return (
      <ul>
        <li>name: {this.props.itemDetail.name}</li>
        <li>price: {this.props.itemDetail.price}</li>
        <li>happiness: {this.props.itemDetail.happiness}</li>
      </ul>
    );
  }
}

export default ItemDetail;
