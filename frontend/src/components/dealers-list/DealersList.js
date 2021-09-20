import ReactPaginate from 'react-paginate';
import { useState, useEffect } from 'react'
import DealerItem from '../dealer-item/DealerItem';
import './DealersList.css';

function DealersList() {
  const PAGE_LIMIT = 10;

  const [dealers, setDealers] = useState(null);
  const [offset, setOffset] = useState(0);
  const [pageCount, setPageCount] = useState(0);

  useEffect(() => getDealers(offset), [offset]);

  const onPageChange = (data) => {
    setOffset(Math.ceil(data.selected * PAGE_LIMIT));
  };

  async function getDealers(offset) {
    const res = await fetch(`/api/v1/dealers?offset=${offset}&limit=${PAGE_LIMIT}`);
    const data = await res.json();

    setDealers(data['data']);
    setPageCount(Math.ceil(data['total_count'] / PAGE_LIMIT))
  }

  return (
    <div className="dealers-list">
      <div class="dealers-list-row">
        <div class="dealers-list-col">Name</div>
        <div class="dealers-list-col">Phone</div>
        <div class="dealers-list-col">Street</div>
        <div class="dealers-list-col">City</div>
        <div class="dealers-list-col">Zipcode</div>
        <div class="dealers-list-col">Country</div>
      </div>

      {dealers && dealers.map((dealer, index) => (
        <DealerItem key={index} dealer={dealer}></DealerItem>
      ))}

      <ReactPaginate
        previousLabel={'previous'}
        nextLabel={'next'}
        breakLabel={'...'}
        breakClassName={'break-me'}
        pageCount={pageCount}
        marginPagesDisplayed={2}
        pageRangeDisplayed={5}
        onPageChange={onPageChange}
        containerClassName={'pagination'}
        activeClassName={'active'}
      />
    </div>
  );
}

export default DealersList;
