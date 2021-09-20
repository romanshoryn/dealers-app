function DealerItem(props) {
  return (
    <div class="dealers-list-row">
      <div class="dealers-list-col">{props.dealer.name}</div>
      <div class="dealers-list-col">{props.dealer.phone}</div>
      <div class="dealers-list-col">{props.dealer.street}</div>
      <div class="dealers-list-col">{props.dealer.city}</div>
      <div class="dealers-list-col">{props.dealer.zipcode}</div>
      <div class="dealers-list-col">{props.dealer.country}</div>
    </div>
  )
}

export default DealerItem;
