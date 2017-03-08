import React from 'react';
import moment from 'moment';
moment.locale('ja');
import {
  getTodayArticle,
  postArticle,
  editArticle
} from '../../APIClient.js';

export default class Editor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      body: '',
      date: moment(),
      loaded: false,
      changed: false
    };
    getTodayArticle().then(article => {
      const body = article ? article.body : '';
      const date = article ? moment(article.published_at) : this.state.date;
      this.setState({
        body: body,
        date: date,
        loaded: true,
        article: article
      });
    });
  }

  handleOnChange(e) {
    this.setState({
      body: e.target.value
    });
  }

  handleSubmit() {
    console.log('submit', this.state.body, this.state.date.format('YYYYMMDD'));
  }

  render() {
    return (
      <div>
        <div>{this.state.date.format('YYYY年 M月D日')}</div>
        <div>
          <textarea
            value={this.state.body}
            onChange={e => { this.handleOnChange(e); }}
            disabled={!this.state.loaded}
          />
        </div>
        <button
          onClick={e => { this.handleSubmit(); }}
          disabled={!this.state.loaded}
        >
          submit
        </button>
      </div>
    );
  }
}
